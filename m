From: John Sarman <johnsarman@gmail.com>
Subject: Re: MMC3 Overo
Date: Mon, 3 Aug 2009 06:33:43 -0400
Message-ID: <bb2708720908030333x1c9521b6ua76122b0f80e1fdc@mail.gmail.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
	 <bb2708720907301223h616eb215gb4aea1df8e1d578e@mail.gmail.com>
	 <alpine.DEB.2.00.0908021919320.19529@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:50438 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbZHCKdo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 06:33:44 -0400
Received: by yxe5 with SMTP id 5so1843638yxe.33
        for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2009 03:33:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0908021919320.19529@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>

Paul,

On Sun, Aug 2, 2009 at 9:20 PM, Paul Walmsley<paul@pwsan.com> wrote:
> Hello John,
>
> you are using the PM branch, correct?
  Unfortunately I am not using the pm patch, because I am stuck at
2.6.30-rc8.  This is because it is the last place I have usb host
working. I backported the necessary changes and pm wasn't an absolute
necessity, basically equivalent to not compiling in PM. I basically
used nearly every related patch after 6-6-09 - the 32 mmc patches.
>
> On Thu, 30 Jul 2009, John Sarman wrote:
>
>> On Thu, Jul 30, 2009 at 11:49 AM, John Sarman<johnsarman@gmail.com> =
wrote:
>> > I am trying to use mmc3 on the Overo Gumstix board with no luck. =A0=
I
>> > have patched the kernel with the latest changes and have yet to se=
e a
>> > clk pulse, both before and after the patches.
>> After adding some debugging printks, I have determined the mmc3 fail=
s
>> getting IRQ
>> mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
>> REQUEST IRQ =3D 83 HOST =3D -812068416
>> mmci-omap-hs mmci-omap-hs.1: Failed to get debounce clock
>> REQUEST IRQ =3D 86 HOST =3D -812067392
>> mmci-omap-hs mmci-omap-hs.2: Failed to get debounce clock
>> REQUEST IRQ =3D 83 HOST =3D -812066368
>> mmci-omap-hs mmci-omap-hs.2: Unable to grab HSMMC IRQ
>> mmci-omap-hs mmci-omap-hs.2: Probe Failed
>> mmci-omap-hs: probe of mmci-omap-hs.2 failed with error -16
>>
>> For some reason mmc1 and mmc3 ask for the same interrupt 83 ???
>>
>> Why would this be assigned the same value?
>
> Developer error. =A0Does this patch fix it for you?
>
>
> - Paul
>
>
> From baca68c40ec3b391cdbfc0fb20ac5092b4ab7025 Mon Sep 17 00:00:00 200=
1
> From: Paul Walmsley <paul@pwsan.com>
> Date: Mon, 3 Aug 2009 04:18:45 +0300
> Subject: [PATCH] OMAP3 hwmod: fix MMC3 IRQ
>
> The MMC3 IRQ is incorrect in mach-omap2/omap_hwmod_34xx.h, which caus=
es
> MMC3 init to fail.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod_34xx.h | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-om=
ap2/omap_hwmod_34xx.h
> index 29a2d60..56215bd 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
> +++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
> @@ -470,7 +470,7 @@ static struct omap_hwmod omap34xx_mmc2_hwmod =3D =
{
> =A0static struct mmc_dev_attr mmc3_dev_attr;
>
> =A0static u8 mmc3_mpu_irqs[] =3D {
> - =A0 =A0 =A0 INT_24XX_MMC_IRQ,
> + =A0 =A0 =A0 INT_34XX_MMC3_IRQ,
> =A0};
>
> =A0static struct omap_hwmod_dma_info mmc3_sdma_chs[] =3D {
> --
> 1.6.3.GIT
>
Thanks for the patch, I will apply that and keep on testing.

John Sarman
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
