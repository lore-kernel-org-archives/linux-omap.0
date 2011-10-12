From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 14/16] OMAP2+: UART: Take console_lock in suspend path if not taken
Date: Wed, 12 Oct 2011 16:47:37 -0700
Message-ID: <87mxd5n55y.fsf@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-5-git-send-email-govindraj.raja@ti.com>
	<87sjmz1hfm.fsf@ti.com>
	<CAAL8m4zrveqqS3vq=dqMkS2gT24_=1UO+ukbxnQVf+AX4TBaVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:43372 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750780Ab1JLXrm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Oct 2011 19:47:42 -0400
In-Reply-To: <CAAL8m4zrveqqS3vq=dqMkS2gT24_=1UO+ukbxnQVf+AX4TBaVQ@mail.gmail.com>
	(Govindraj's message of "Wed, 12 Oct 2011 16:53:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Govindraj <govindraj.ti@gmail.com> writes:

> On Wed, Oct 12, 2011 at 12:31 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> In suspend path the console_lock is taken by uart_port_suspend
>>> however when no_console_suspend is used console_lock is not taken.
>>>
>>> During system wide suspend omap_pwr_domain hooks cut all
>>> clocks that are left enabled. So its unsafe to proceed printing aft=
er
>>> clocks are cut by pwr_domain hooks.
>>
>> As I've mentioned in previous reviews, when no_console_suspend is
>> enabled, the user has explicitly requested console output during
>> suspend. =C2=A0In order to support that, we should not be cutting cl=
ocks at
>> all in that mode.
>>
>> One way to address this would be to just disable runtime PM in the
>> ->prepare method of the driver if no_console_suspend is enabled.
>>
>
> Okay fine exploring this option, right API's would be to use
> pm_runtime_forbid/allow.

Yes.

> <<SNIP>>
>
> +static int serial_omap_runtime_prepare(struct device *dev)
> +{
> +       if (!console_suspend_enabled)
> +               pm_runtime_forbid(dev);
> +
> +       return 0;
> +}
> +
> +static void serial_omap_runtime_complete(struct device *dev)
> +{
> +       if (!console_suspend_enabled)
> +               pm_runtime_allow(dev);
> +}
> +
>  static const struct dev_pm_ops serial_omap_dev_pm_ops =3D {
>         SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_omap_resu=
me)
>         SET_RUNTIME_PM_OPS(serial_omap_runtime_suspend,
>                                 serial_omap_runtime_resume, NULL)
> +       .prepare =3D serial_omap_runtime_prepare,
> +       .complete =3D  serial_omap_runtime_complete,
>  };

OK, but please add comments to these functions about exactly why they
are needed.

>
> But to either use runtime forbid or disable we have ensure that
> power_domain hooks don't go ahead and disable
> the clocks with omap_device_idle as *runtime forbid or disable will
> not set runtime_status to RPM_SUSPENDED*
> and will stay in RPM_ACTIVE if we call runtime disable or forbid from
> active state.

Correct.

> in power_domain hooks we just check the pm_runtime_status_suspended
> this will be false even if
> we do runtime disable/forbid and it will cut uart clocks always.
>
> So we may need below check also:
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/om=
ap_device.c
> index 26aee5c..286a534 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -592,7 +592,8 @@ static int _od_suspend_noirq(struct device *dev)
>
>         ret =3D pm_generic_suspend_noirq(dev);
>
> -       if (!ret && !pm_runtime_status_suspended(dev)) {
> +       if (!ret && pm_runtime_enabled(dev) &&
> +                       !pm_runtime_status_suspended(dev)) {
>                 if (pm_generic_runtime_suspend(dev) =3D=3D 0) {
>                         omap_device_idle(pdev);
>                         od->flags |=3D OMAP_DEVICE_SUSPENDED;

This isn't right either because devices that may not yet be initialized
(or loaded) may not have runtime PM enabled, so those devices may not
be properly idled.

We have an omap_device API to disable this feature at the PM domain lev=
el:
omap_device_disable_idle_on_suspend().  All you should have to do is to
use this API in the device init code on the console UART if
no_console_suspend has been enabled.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
