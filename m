From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] OMAP2/4: PM: Boot message is not an error/info, and not
 helpful, remove it
Date: Mon, 30 May 2011 09:11:54 -0500
Message-ID: <BANLkTi=eZBj1BsRZ92zbo-8pUfrGwba-5Q@mail.gmail.com>
References: <1306751527-15929-1-git-send-email-santosh.shilimkar@ti.com>
 <4DE39D40.2060500@ru.mvista.com> <4DE39F2B.3040506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:60170 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751745Ab1E3OMP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 10:12:15 -0400
Received: by mail-ww0-f51.google.com with SMTP id 26so3053599wwf.20
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 07:12:14 -0700 (PDT)
In-Reply-To: <4DE39F2B.3040506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, May 30, 2011 at 08:44, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 5/30/2011 7:06 PM, Sergei Shtylyov wrote:
>>
>> Hello.
>>
>> Santosh Shilimkar wrote:
>>
>>> The commit '99aa18278e' removed the boot messege for OMAP3. Do the =
same
>>
>> Please specify that commit's summary in parens -- for the human read=
ers.
>> Oh, and you don't need quotes around commit ID too.
>>
> Yes I missed that. Updated patch below.
>
> Regards
> Santosh
>
> From 53e986a2a43dc204146af99c2d7a906dba781ea0 Mon Sep 17 00:00:00 200=
1
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Mon, 30 May 2011 15:52:01 +0530
> Subject: [PATCH] OMAP2/4: PM: Boot message is not an error/info, and =
not
> helpful, remove it
>
> The commit 99aa18278e (OMAP3: PM: Boot message is not an error,
> and not helpful, remove it), removed the boot message for OMAP3.
> Do the same for OMAP2 and OMAP4 since it's really just noise in the
> boot log and PM init is always called.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Acked-by: Nishanth Menon <nm@ti.com>
Regards,
Nishanth Menon


> ---
> =A0arch/arm/mach-omap2/pm24xx.c | =A0 =A01 -
> =A0arch/arm/mach-omap2/pm44xx.c | =A0 =A02 --
> =A02 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24x=
x.c
> index df3ded6..5970759 100644
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -442,7 +442,6 @@ static int __init omap2_pm_init(void)
> =A0 =A0 =A0 =A0if (!cpu_is_omap24xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 printk(KERN_INFO "Power Management for OMAP2 initializi=
ng\n");
> =A0 =A0 =A0 =A0l =3D omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVIS=
ION_OFFSET);
> =A0 =A0 =A0 =A0printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0=
x0f, l & 0x0f);
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44x=
x.c
> index 59a870b..a6259d6 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -103,8 +103,6 @@ static int __init omap4_pm_init(void)
> =A0 =A0 =A0 =A0if (!cpu_is_omap44xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 pr_err("Power Management for TI OMAP4.\n");
> -
> =A0 =A0 =A0 =A0ret =3D pwrdm_for_each(pwrdms_setup, NULL);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("Failed to setup powerdomains\n=
");
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
