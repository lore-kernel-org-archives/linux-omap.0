From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 14/16] OMAP2+: UART: Take console_lock in suspend path
 if not taken
Date: Wed, 12 Oct 2011 16:53:05 +0530
Message-ID: <CAAL8m4zrveqqS3vq=dqMkS2gT24_=1UO+ukbxnQVf+AX4TBaVQ@mail.gmail.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
 <1317380561-661-5-git-send-email-govindraj.raja@ti.com> <87sjmz1hfm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87sjmz1hfm.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 12, 2011 at 12:31 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> In suspend path the console_lock is taken by uart_port_suspend
>> however when no_console_suspend is used console_lock is not taken.
>>
>> During system wide suspend omap_pwr_domain hooks cut all
>> clocks that are left enabled. So its unsafe to proceed printing afte=
r
>> clocks are cut by pwr_domain hooks.
>
> As I've mentioned in previous reviews, when no_console_suspend is
> enabled, the user has explicitly requested console output during
> suspend. =A0In order to support that, we should not be cutting clocks=
 at
> all in that mode.
>
> One way to address this would be to just disable runtime PM in the
> ->prepare method of the driver if no_console_suspend is enabled.
>

Okay fine exploring this option, right API's would be to use
pm_runtime_forbid/allow.

<<SNIP>>

+static int serial_omap_runtime_prepare(struct device *dev)
+{
+       if (!console_suspend_enabled)
+               pm_runtime_forbid(dev);
+
+       return 0;
+}
+
+static void serial_omap_runtime_complete(struct device *dev)
+{
+       if (!console_suspend_enabled)
+               pm_runtime_allow(dev);
+}
+
 static const struct dev_pm_ops serial_omap_dev_pm_ops =3D {
        SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_omap_resume=
)
        SET_RUNTIME_PM_OPS(serial_omap_runtime_suspend,
                                serial_omap_runtime_resume, NULL)
+       .prepare =3D serial_omap_runtime_prepare,
+       .complete =3D  serial_omap_runtime_complete,
 };

<<SNIP>>

But to either use runtime forbid or disable we have ensure that
power_domain hooks don't go ahead and disable
the clocks with omap_device_idle as *runtime forbid or disable will
not set runtime_status to RPM_SUSPENDED*
and will stay in RPM_ACTIVE if we call runtime disable or forbid from
active state.

in power_domain hooks we just check the pm_runtime_status_suspended
this will be false even if
we do runtime disable/forbid and it will cut uart clocks always.

So we may need below check also:

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap=
_device.c
index 26aee5c..286a534 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -592,7 +592,8 @@ static int _od_suspend_noirq(struct device *dev)

        ret =3D pm_generic_suspend_noirq(dev);

-       if (!ret && !pm_runtime_status_suspended(dev)) {
+       if (!ret && pm_runtime_enabled(dev) &&
+                       !pm_runtime_status_suspended(dev)) {
                if (pm_generic_runtime_suspend(dev) =3D=3D 0) {
                        omap_device_idle(pdev);
                        od->flags |=3D OMAP_DEVICE_SUSPENDED;


--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
