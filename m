From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [pm-wip/mmc][PATCH 00/10] OMAP MMC Hwmod & Runtime patches
Date: Fri, 27 Aug 2010 19:43:47 +0530
Message-ID: <AANLkTimReVkTE2gvR+zqc7oWUh1_cVbSdDCqy-dCVz8j@mail.gmail.com>
References: <16071.10.24.255.18.1282335017.squirrel@dbdmail.itg.ti.com>
	<87hbihvu9i.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55157 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab0H0ONv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 10:13:51 -0400
Received: by vws3 with SMTP id 3so2895824vws.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 07:13:51 -0700 (PDT)
In-Reply-To: <87hbihvu9i.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com

Thanks Kevin, I will take up things for MMC from here.
Currently working on runtime for MMC and post out once done.

Regards,
Kishore

On Fri, Aug 27, 2010 at 4:47 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "kishore kadiyala" <kishore.kadiyala@ti.com> writes:
>
>> Hi,
>>
>> 1) The patch series has dependency on Tony's patches
>> =A0 =A0http://www.spinics.net/lists/linux-omap/msg34835.html
>> =A0 =A0http://www.spinics.net/lists/linux-omap/msg34834.html
>>
>> 2) The patch series has some updations of hwmod data
>> =A0 =A0for MMC controller's on MMC2/3.
>> 3) Also adds & updates hwmod data for mmc and uart for OMAP4.
>> =A0 =A0Adding UART for OMAP4 helps to validate MMC cards from consol=
e
>> 4) Also the series includes couple of fixes
>> =A0 =A0a) runtime crash seen currently on tree. Validated on OMAP343=
0.
>> =A0 =A0b) crash on OMAP4430 when CONFIG_MMC_OMAP_HS is not set.
>>
>> The entire series has been tested on OMAP4430 SDP with omap3_defconf=
ig
>> Currently working on runtime for MMC and will update later.
>
> This needs testing on OMAP2 as well.
>
> Please take over responsibility of the pm-wip/mmc branch and feel fre=
e
> to combine those patches with yours. =A0They are there just to get
> started, but you are free to take them and do what you like with them=
=2E
>
> For the next rev, just include/merge the patches from pm-wip/mmc with
> yours and post them against my pm-core branch (a.k.a. pm-wip/hwmods-o=
map4)
>
>> Kishore Kadiyala (7):
>> =A0 [PM-WIP-MMC] OMAP2 HWMOD: Updating MMC Controller data
>> =A0 [PM-WIP-MMC] OMAP3 HWMOD: Updating MMC controller data
>> =A0 [PM-WIP-MMC] OMAP2/OMAP3: Updating hwmod name for MMC controller
>> =A0 [PM-WIP-MMC] OMAP4 hwmod: Updating hwmod data for MMC controller=
s
>
> Some minor nits on naming: =A0let's use the prefix:
>
> =A0 =A0 <soc>: hwmod data: <shortlog>
>
> e.g. OMAP3: hwmod data: add MMC controllers
>
> Kevin
>
>> =A0 [PM-WIP-MMC] OMAP MMC: Remove MMC controller reset
>> =A0 [PM-WIP-MMC] OMAP MMC: Register offset handling
>> =A0 [PM-WIP-MMC] OMAP MMC : Fix crash with CONFIG_PM_RUNTIME
>>
>> Benoit Cousson (3):
>> =A0 [PM-WIP-MMC] OMAP4 hwmod: Adding hwmod data for MMC controller
>> =A0 [PM-WIP-UART] OMAP4 hwmod : Adding hwmod data for UART
>> =A0 [PM-WIP-MMC] omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS is =
not
>> =A0 =A0 set
>>
>> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0 =A0 =A0| =A0 =A07 +-
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0106=
 +-----
>> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A06 +
>> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0 =A09 +-
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 11 +-
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0567 +++++++++++++=
++++++++++++++-
>> =A0arch/arm/plat-omap/include/plat/mmc.h =A0 =A0 =A0| =A0 76 ++++
>> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0256=
 ++++++-------
>> =A08 files changed, 785 insertions(+), 253 deletions(-)
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
