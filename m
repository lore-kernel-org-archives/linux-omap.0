From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 00/19] ARM: OMAP4 device off support
Date: Fri, 20 Apr 2012 17:50:16 +0530
Message-ID: <CANrkHUa5q10FFxsZfgtMqKbzKKFHCcf3yYsaOK+hG8CJiME2TA@mail.gmail.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: khilman@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 20, 2012 at 3:03 PM, Tero Kristo <t-kristo@ti.com> wrote:
> Hi,
>
> First version for this work. Applies on top of mainline + iochain set +
> OMAP4 core retention set. Working tree available here:
> tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> branch: mainline-3.4-omap4-dev-off
>
> Tested on omap4430 EMU blaze + omap4460 GP panda boards.
>
> Some drivers have issues with device off, most notably MMC, as it breaks
> device off on blaze device after 1 entry to device off mode:
>
> [ =A0208.906921] omap_i2c omap_i2c.1: XRDY IRQ while no data to send
> [ =A0209.905639] omap_i2c omap_i2c.1: controller timed out
> [ =A0209.905792] twl: i2c_read failed to transfer all messages
> [ =A0209.905792] omap_hsmmc omap_hsmmc.1: could not set regulator OCR (-1=
10)
> [ =A0212.296203] mmc0: error -110 during resume (card was removed?)
Hi Tero,

I tried your branch on gp/emu devices but could not reproduce this issue.
My observation is that while resuming, omap_hsmmc.1 eMMC is
trying to turn on phoenix vaux1 regulator via i2c which fails due
to controller timeout.
Note: eMMC is present only on sdp/blaze

> [ =A0212.562164] PM: resume of devices complete after 3656.007 msecs
> [ =A0212.660125] Restarting tasks ... done.
> #
> # echo mem > /sys/power/state
> [ =A0220.376892] PM: Syncing filesystems ... done.
> [ =A0220.382476] Freezing user space processes ... (elapsed 0.01 seconds)=
 done.
> [ =A0220.408386] Freezing remaining freezable tasks ... (elapsed 0.02 sec=
onds) don
> e.
> [ =A0220.439605] Suspending console(s) (use no_console_suspend to debug)
> [ =A0220.454650] dpm_run_callback(): platform_pm_suspend+0x0/0x54 returns=
 -110
> [ =A0220.454711] PM: Device omap_hsmmc.1 failed to suspend: error -110
> [ =A0220.454711] PM: Some devices failed to suspend
> [ =A0220.718261] PM: resume of devices complete after 263.539 msecs
> [ =A0220.743988] Restarting tasks ... done.
>
> Attempting to disable MMC from config prevented boot completely for me,
> so this issue is likely to stay until someone fixes the MMC driver.
> Panda device works fine though, although the wakeup from device off is
> slow due to problems with some other drivers (most likely I2C.)
>

can you try this patch if you want to disable MMC
http://permalink.gmane.org/gmane.linux.ports.arm.omap/74540
or
http://www.spinics.net/lists/linux-omap/msg67879.html
and build omap_hsmmc as module.

> Off mode is disabled by default, it can be enabled by either calling
> omap4_pm_enable_off_mode(1) from board files or alternatively writing
> to a debugfs node from userspace:
>
> echo 1 > /debug/pm_debug/enable_off_mode
>
> Device off entry can be tracked through the debugfs also, it increases
> the core_pwrdm OFF state counter / timer, as this is an invalid state
> for the chip normally (core enters OSWR in device off.) Not sure if this
> a good way to do this but comments are welcome.
>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
