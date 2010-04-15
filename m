From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCHv3 0/5] OMAP: RX51: Add LCD Panel Support for N900
Date: Thu, 15 Apr 2010 17:00:31 +0300
Message-ID: <q2g6ed0b2681004150700td93683uf0944408ef2b7bc4@mail.gmail.com>
References: <1271333181-23609-1-git-send-email-roger.quadros@nokia.com>
	 <4BC701D1.5080108@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:50242 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab0DOOAe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 10:00:34 -0400
In-Reply-To: <4BC701D1.5080108@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <roger.quadros@nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Something's strange with Tomi's mail path I guess, I always send
patches with git send-email and he still received some of them (but
not all) mangled.

On Thu, Apr 15, 2010 at 3:08 PM, Roger Quadros <roger.quadros@nokia.com=
> wrote:
> Tarball attached in case checkpatch complains.
>
> -roger
>
> Quadros Roger (Nokia-D/Helsinki) wrote:
>>
>> Tomi,
>>
>> Resending the patchset.
>>
>> Checkpatch was not complaining at my end. Probably the mail server i=
s
>> mangling the patches. I will send a tarball separately.
>>
>> The only change in this version is that i've put the Video memory
>> initialization code in the board file.
>>
>> The TSC2005 stuff is still thereas without it panel is not detected.
>> The merge conflict with TSC2005 patches if happens is very trivial t=
o
>> resolve.
>>
>>
>> regards,
>> -roger
>>
>> These patches get the N900 LCD panel working.
>> Applys cleanly on 2.6.34-rc3
>>
>> Changes since v2:
>> -Added Video mem init in board file
>> Changes since v1:
>> -Added Backlight control
>>
>> Pre-requisites:
>> https://patchwork.kernel.org/patch/86318/
>> https://patchwork.kernel.org/patch/86319/
>> https://patchwork.kernel.org/patch/86320/
>>
>> ---
>> Roger Quadros (5):
>> =A0OMAP: RX51: Add LCD Panel support
>> =A0OMAP: RX51: Add "vdds_sdi" supply voltage for SDI
>> =A0OMAP: RX51: Add Touch Controller in SPI board info
>> =A0OMAP: DSS2: Add ACX565AKM Panel Driver
>> =A0OMAP: RX51: Update board defconfig
>>
>> =A0arch/arm/configs/rx51_defconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 39 ++-
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A01 +
>> =A0arch/arm/mach-omap2/board-rx51-peripherals.c =A0 | =A0 43 ++
>> =A0arch/arm/mach-omap2/board-rx51-video.c =A0 =A0 =A0 =A0 | =A0107 +=
++
>> =A0arch/arm/mach-omap2/board-rx51.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +
>> =A0drivers/video/omap2/displays/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
6 +
>> =A0drivers/video/omap2/displays/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 +
>> =A0drivers/video/omap2/displays/panel-acx565akm.c | =A0819
>> ++++++++++++++++++++++++
>> =A08 files changed, 1017 insertions(+), 1 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/board-rx51-video.c
>> =A0create mode 100644 drivers/video/omap2/displays/panel-acx565akm.c
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fbde=
v" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
