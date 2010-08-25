From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: AM3517 (Sitara) MMC2 help
Date: Wed, 25 Aug 2010 09:58:35 -0400
Message-ID: <AANLkTikzBMuCeMEnCfxkdmAXd9Xa3qMbekk=+8Wrc+5N@mail.gmail.com>
References: <4C73BE1C.7080503@compulab.co.il>
	<AANLkTinQWpYbFzDeAdsjpLsiW63q5q9XLkhef0NiujM1@mail.gmail.com>
	<4C74D073.3060105@compulab.co.il>
	<AANLkTi=3G2DdAFCJQyyAPEsvBeY-3Moxkarpaz41aAai@mail.gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03243069A8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43415 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab0HYN6i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 09:58:38 -0400
Received: by wyb35 with SMTP id 35so720726wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Aug 2010 06:58:37 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03243069A8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Laine Walker-Avina <lwalkera@ieee.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Aug 25, 2010 at 9:51 AM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> Ashwin Bihari wrote:
>> On Wed, Aug 25, 2010 at 4:12 AM, Igor Grinberg <grinberg@compulab.co=
=2Eil> wrote:
>> > =A0On 08/25/10 03:29, Laine Walker-Avina wrote:
>> >> On Tue, Aug 24, 2010 at 5:42 AM, Igor Grinberg <grinberg@compulab=
=2Eco.il> wrote:
> ...
>
>> >> Make sure the MMC2_CLK pin is muxed as an input so the clock can
>> >> feedback to the module.
>> >
>> > omap2_mmc_mux() in arch/arm/mach-omap2/devices.c is handling this
>> > and I think properly or else any omap will fail using the mmc2.
>> >
>> >> Also, you may need to set
>> >> CONTROL_DEVCONF1.MMCSDIO2ADPCLKISEL=3D1 if that exists on the Sit=
ara. I
>> >> had the same problem on the OMAP3x.
>> >
>> > I will try that.
>> >
>
> ...
>
>> I've got this exact same problem on a OMAP35x based board. We have
>> MMC1 connected to a SD card cage and MMC2 connected to an eMMC. I ca=
n
>> detect an inserted SD card and eMMC during boot up, but if I suspend
>> and resume the device, I get a ton of timeout errors on MMC1 (the SD
>> slot) and the RFS that's being used from it ends up having lots of
>> EXT3 journal errors and ends up hosing itself..
>>
>> I've confirmed that the CONTROL_DEVCONF1.MMCSDIO2ADPCLKISEL is set t=
o
>> 1 as well and that doesn't affect any change.
>>
>> I was using a 2.6.29 Kernel on this board before and it had no
>> problems, I then jumped to 2.6.32 and this problem appeared. I'm now
>> running the latest linux-next (2.6.35) Kernel and it also presents t=
he
>> problem..
>>
>> Any guidance would be appreciated..
>
> Ashwin,
>
> I'm not sure your problem is the same as the one originally posted.
> Do you have CONFIG_MMC_UNSAFE_RESUME enabled?
>
> - Anand
>

Anand,

Yup, have MMC_UNSAFE_RESUME set. I'm actually using the
"omap3_defconfig" to build my Kernel..

CONFIG_MMC=3Dy
CONFIG_MMC_DEBUG=3Dy
CONFIG_MMC_UNSAFE_RESUME=3Dy
# MMC/SD/SDIO Card Drivers
CONFIG_MMC_BLOCK=3Dy
CONFIG_MMC_BLOCK_BOUNCE=3Dy
# CONFIG_MMC_TEST is not set
# MMC/SD/SDIO Host Controller Drivers
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_OMAP=3Dy
CONFIG_MMC_OMAP_HS=3Dy
# CONFIG_MMC_SPI is not set

The interesting thing is that enabling MMC2 causes me issues on MMC1
though I'm not doing anything on MMC2's eMMC apart from discovering
it..

Thanks
-- Ashwin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
