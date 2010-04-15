From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [PATCHv2 0/5] OMAP: RX51: Add LCD Panel Support for N900
Date: Thu, 15 Apr 2010 13:04:01 +0300
Message-ID: <4BC6E491.2020308@nokia.com>
References: <1270729267-27553-1-git-send-email-roger.quadros@nokia.com> <1271325104.2690.232.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48788 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab0DOKE2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 06:04:28 -0400
In-Reply-To: <1271325104.2690.232.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

Valkeinen Tomi (Nokia-D/Helsinki) wrote:
> Hi,
> 
> On Thu, 2010-04-08 at 14:21 +0200, Quadros Roger (Nokia-D/Helsinki)
> wrote:
>> Tomi,
>>
>> Please take these in your DSS branch if they are OK.
>> Tony is fine if you take the board stuff too.
> 
> checkpatch complained about using spaces for indenting. Can you check
> the patches?

I did check before sending. Anyways I will recheck and resend.

I also have some more fixes to the patchset
1) setting default_bpp in panel driver to 16. with SDI it takes it as 24 by default.
2) Add video memory allocation at board init.

There seems to be a TSC2005 driver floating around. So I will remove the patch 
which introduces TSC2005 SPI info in board-file from my patchset to avoid 
possible merge conflicts in future.

I will include these fixes in v3.

cheers,
-roger

>>
>> These patches get the N900 LCD panel working.
>> Apply's cleanly on 2.6.34-rc3
>>
>> Pre-requisites:
>> https://patchwork.kernel.org/patch/86318/
>> https://patchwork.kernel.org/patch/86319/
>> https://patchwork.kernel.org/patch/86320/
>>
>> Changes since v1:
>> -Added Backlight control
>>
>> ---
>> Roger Quadros (5):
>>   OMAP: RX51: Add LCD Panel support
>>   OMAP: RX51: Add "vdds_sdi" supply voltage for SDI
>>   OMAP: RX51: Add Touch Controller in SPI board info
>>   OMAP: DSS2: Add ACX565AKM Panel Driver
>>   OMAP: RX51: Update board defconfig
>>
>>  arch/arm/configs/rx51_defconfig                |   39 ++-
>>  arch/arm/mach-omap2/Makefile                   |    1 +
>>  arch/arm/mach-omap2/board-rx51-peripherals.c   |   43 ++
>>  arch/arm/mach-omap2/board-rx51-video.c         |   95 +++
>>  drivers/video/omap2/displays/Kconfig           |    6 +
>>  drivers/video/omap2/displays/Makefile          |    1 +
>>  drivers/video/omap2/displays/panel-acx565akm.c |  819 ++++++++++++++++++++++++
>>  7 files changed, 1003 insertions(+), 1 deletions(-)
>>  create mode 100644 arch/arm/mach-omap2/board-rx51-video.c
>>  create mode 100644 drivers/video/omap2/displays/panel-acx565akm.c
>>
> 
> 

