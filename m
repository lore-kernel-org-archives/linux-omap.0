From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Mon, 25 Jun 2012 19:01:51 +0530
Message-ID: <CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
	<CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	<1340616643.3395.19.camel@deskari>
	<CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	<1340628094.3395.63.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48350 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756365Ab2FYNbx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 09:31:53 -0400
Received: by eaak11 with SMTP id k11so1197059eaa.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 06:31:52 -0700 (PDT)
In-Reply-To: <1340628094.3395.63.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 25 June 2012 18:11, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-06-25 at 17:57 +0530, Jassi Brar wrote:
>> On 25 June 2012 15:00, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
>> > The driver needs to enable the HW and the call to pm_runtime_get()=
 is
>> > skipped. Won't this lead to crash as the DSS registers are accesse=
d
>> > without the HW in enabled state?
>> >
>> Hmm... =A0how does the extant code in hdmi driver ensures DSS is up =
and running ?
>> While it does sound important even to my limited knowledge of OMAPDS=
S,
>> I see rpm of HDMI, VENC and RFBI only dependent on DISPC, not DSS.
>
> DSS device is parent to all the DSS subdevices. So when a subdevice i=
s
> enabled, DSS device is enabled first.
>
> But anyway, I wasn't referring to the DSS part of OMAPDSS, but to
> omapdss generally. If we do this:
>
> /* this is skipped, if runtime PM is disabled */
> dispc_runtime_get();
>
I hope you do realize that there is difference between "PM is disabled
on a device"
and "the device is in some low-power state".   pm_runtime_enabled()
checks for the former.
So under this light...

> /* this accesses a register, but the HW is disabled? */
> dispc_read_reg(FOO);
>
=2E... the H/W is already always enabled if CONFIG_PM_RUNTIME is not de=
fined.

If CONFIG_PM_RUNTIME is indeed defined,  pm_runtime_enabled() will
always return true after pm_runtime_enable()  unless someone disables
it explicitly - omapdss or the RPM stack(during suspend/resume).
OMAPDSS never does so in the lifetime of a driver.  So the only period
in which pm_runtime_enabled() returns false, is when the platform is
suspending, suspended or resuming.


>> > And what happens if the pm_runtime_get() call is skipped, but pm_r=
untime_put() is not?
>> >
>> Not sure in what newly introduced scenario by this patch, because
>> get/put both check for pm_enabled before proceeding. Am I overlookin=
g
>> something?
>
> Currently (for example) dispc_runtime_get/put call
> pm_runtime_get/put_sync. When somebody uses dispc_runtime_get, the sa=
me
> somebody knows it needs to call dispc_runtime_put later.
>
> Now, what happens if dispc_runtime_get is called when runtime PM is
> disabled (i.e. pm_runtime_get_sync is skipped), but runtime PM is
> enabled later when that somebody calls dispc_runtime_put (i.e.
> pm_runtime_put_sync is _not_ skipped)?
>
As I said, for omapdss, PM is disabled (not device deactivated) only
during rpm suspend/resume.
And it should be no different than any lock protected section
preempted by suspend-resume before reaching its end.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
