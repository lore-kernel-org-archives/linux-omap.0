From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH v2] twl4030 reboot workaround
Date: Thu, 29 Jul 2010 22:10:43 +0300
Message-ID: <AANLkTi=OkfRGvW05ZTOaSU+-r7jo40wHFK_pkQM9Hmw=@mail.gmail.com>
References: <20100729061608.GG12063@edollo>
	<1280385678-4366-1-git-send-email-ext-mikko.rapeli@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58687 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109Ab0G2TKt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 15:10:49 -0400
Received: by gyg10 with SMTP id 10so256533gyg.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Jul 2010 12:10:48 -0700 (PDT)
In-Reply-To: <1280385678-4366-1-git-send-email-ext-mikko.rapeli@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mikko Rapeli <ext-mikko.rapeli@nokia.com>
Cc: linux-omap@vger.kernel.org, mturquette@ti.com, sameo@linux.intel.com

Hi

On Thu, Jul 29, 2010 at 9:41 AM, Mikko Rapeli
<ext-mikko.rapeli@nokia.com> wrote:
> From: Mikko Rapeli <ext-mikko.rapeli@nokia.com>
>
> Original patch: http://marc.info/?l=3Dlinux-omap&m=3D126522625032441&=
w=3D2
>
> "Removes TWL4030 sleep script prior to rebooting, only on OMAP3. This=
 is
> necessary since DPLL3 reset causes SYS_OFFMODE pin to go low, resulti=
ng
> in the sleep script being executed on TWL4030. This usually results i=
n
> VDD1 & VDD2 voltage collapse while ROM code is executing, followed by=
 an
> MPU Watch Dog reset or worse, an irrecoverable hang."

I had a similar issue when my system hanged on hard reset when there
was a TWL sleep script installed.
The workaround I've found was to install the sleep script immediately
before entering the suspend state and remove the script on the resume
path.
If you think that such approach is appropriate I can send a patch.

> Original patch resulted in a crash due to sleeping i2c calls late in =
the
> reboot sequence. Here's how to trigger the crash:
>
> =A0 =A0 =A0 =A0# cat /dev/urandom > /foo &
> =A0 =A0 =A0 =A0sync();
> =A0 =A0 =A0 =A0reboot(LINUX_REBOOT_CMD_RESTART2);
>
> Kernel trace from 2.6.32:
>
> Unable to handle kernel NULL pointer dereference at virtual address 0=
0000000
> pgd =3D c0004000
> [00000000] *pgd=3D00000000
> Internal error: Oops: 805 [#2] PREEMPT
> ...
> [<c00b3210>] (exit_mmap+0x1d4/0x1f8) from [<c006069c>] (mmput+0x34/0x=
110)
> [<c006069c>] (mmput+0x34/0x110) from [<c0064a90>] (exit_mm+0x140/0x18=
0)
> [<c0064a90>] (exit_mm+0x140/0x180) from [<c00668ec>] (do_exit+0x5d8/0=
x6ac)
> [<c00668ec>] (do_exit+0x5d8/0x6ac) from [<c0035858>] (die+0x2d4/0x2e0=
)
> [<c0035858>] (die+0x2d4/0x2e0) from [<c0035904>] (baddataabort+0x0/0x=
50)
> [<c0035904>] (baddataabort+0x0/0x50) from [<c0274ff4>] (i2c_transfer+=
0xec/0x104)
> [<c0274ff4>] (i2c_transfer+0xec/0x104) from [<00000001>] (0x1)
>
> Fix is to move reboot preparations into a reboot notifier.
>
> Signed-off-by: Mikko Rapeli <ext-mikko.rapeli@nokia.com>
> Acked-by: Mike Turquette <mturquette@ti.com>
> ---
>
> v2: added a new line after variable declarations
>
> v1: http://marc.info/?l=3Dlinux-omap&m=3D128031011323970&w=3D2
>
> =A0drivers/mfd/twl4030-power.c | =A0 30 +++++++++++++++++++++++++++++=
+
> =A01 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.=
c
> index 7efa878..5c6da1e 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -28,6 +28,7 @@
> =A0#include <linux/pm.h>
> =A0#include <linux/i2c/twl.h>
> =A0#include <linux/platform_device.h>
> +#include <linux/reboot.h>
>
> =A0#include <asm/mach-types.h>
>
> @@ -127,6 +128,30 @@ static u8 res_config_addrs[] =3D {
> =A0 =A0 =A0 =A0[RES_Main_Ref] =A0=3D 0x94,
> =A0};
>
> +/*
> + * PRCM on OMAP3 will drive SYS_OFFMODE low during DPLL3 warm reset.
> + * This causes Gaia sleep script to execute, usually killing VDD1 an=
d
> + * VDD2 while code is running. =A0WA is to disable the sleep script
> + * before warm reset.
> + */
> +static int twl4030_prepare_for_reboot(struct notifier_block *this,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long cmd, void *p)
> +{
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 err =3D twl4030_remove_script(TWL4030_SLEEP_SCRIPT);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("TWL4030: error trying to disabl=
e sleep script!\n");
> +
> + =A0 =A0 =A0 return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block twl4030_reboot_notifier =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .notifier_call =3D twl4030_prepare_for_=
reboot,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .next =3D NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .priority =3D 0
> +};
> +
> =A0static int __init twl4030_write_script_byte(u8 address, u8 byte)
> =A0{
> =A0 =A0 =A0 =A0int err;
> @@ -549,6 +574,11 @@ void __init twl4030_power_init(struct twl4030_po=
wer_data *twl4030_scripts)
> =A0 =A0 =A0 =A0err =3D twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, =
R_PROTECT_KEY);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("TWL4030 Unable to relock regis=
ters\n");
> +
> + =A0 =A0 =A0 err =3D register_reboot_notifier(&twl4030_reboot_notifi=
er);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("TWL4030 Failed to register rebo=
ot notifier\n");
> +
> =A0 =A0 =A0 =A0return;
>
> =A0unlock:
> --
> 1.5.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
=A0 =A0 Sincerely Yours,
=A0 =A0 =A0 =A0 Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
