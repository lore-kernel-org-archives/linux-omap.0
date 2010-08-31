From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 0/8 v2]usb: musb: hwmod and runtime pm support for musb
Date: Tue, 31 Aug 2010 11:10:41 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402780D3F05@dbde02.ent.ti.com>
References: <1282140177-28089-1-git-send-email-hemahk@ti.com>
 <877hje6y7k.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49735 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919Ab0HaFkv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 01:40:51 -0400
In-Reply-To: <877hje6y7k.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

 

>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: Thursday, August 26, 2010 5:29 AM
>To: Kalliguddi, Hema
>Cc: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org; 
>Felipe Balbi; Tony Lindgren; Cousson, Benoit; Paul Walmsley
>Subject: Re: [PATCH 0/8 v2]usb: musb: hwmod and runtime pm 
>support for musb
>
>Hema HK <hemahk@ti.com> writes:
>
>> Cc: Felipe Balbi <felipe.balbi@nokia.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Cousson, Benoit <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>>
>> This patch series makes OMAP2PLUS musb Module implemented
>> in HWMOD FW way. It also implements musb driver to
>> use the runtime pm apis.
>>
>> PATCH[1/8 v2] and [PATCH 2/8 v2] are the pre-requisites for the hwmod
>> support for the usb module.
>>
>> PATCH[6/8 v2] is core-offmode usb fix patch for the OMAP3
>> in idle path.
>>
>> As per the OMAP usbotg specification[1] musb sysconfig register
>> has to be set to force idle and force standby when not used
>> and set smart idle/standby during operation.otherwise core-off
>> will be prevented by musb.
>>
>> [1]: http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf
>>
>> This patch series is created on "origin/pm-wip/hwmods-omap4".
>>
>> This patch series is tested on OMAP3630 zoom3 and OMAP4430 SDP.
>> On OMAP3630 zoom3, off mode is tested on "origin/pm" branch using 
>> omap3_pm_defconfig.
>
>This IP is on OMAP2 as well, but I don't see any hwmods for OMAP2.
>
>Please also add hwmods for OMAP2 and test as well.
>

OK. I will do that and post a patch.

>Thanks,
>
>Kevin
>
>
>>
>> Version History:
>> ---------------
>> Vesrion v2:
>>
>> Fixed review comments.
>> Removed the omap_hwmod.h inclusion from musb.h file which was 
>> breaking the non-omap platform build.
>> Using the runtime pm apis in the idle path(interrupts disabled).
>> Added the omap4 hwmod data base.
>>
>> Version v1:
>> initial version of the patch series.
>>
>> Some of the links for v1
>> ------------------------
>>
>> http://www.spinics.net/lists/linux-usb/msg34570.html
>> http://www.spinics.net/lists/linux-omap/msg34568.html
>> http://www.spinics.net/lists/linux-usb/msg34544.html
>> http://www.spinics.net/lists/linux-usb/msg34540.html
>> http://www.spinics.net/lists/linux-usb/msg34589.html
>> http://www.spinics.net/lists/linux-usb/msg34554.html
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32973.html
>>
>>
>> Cousson, Benoit (1):
>>   usb: musb: HWMOD database structures addition for OMAP4
>>
>> Hema HK (7):
>>   usb: musb: Adding names for IRQs in resource structure
>>   usb: musb: Remove board_data parameter from musb_platform_init()
>>   usb: musb: HWMOD database structures addition for OMAP3
>>   usb: musb: Using omap_device_build for musb device registration
>>   usb: musb: Offmode fix for idle path
>>   OMAP: Hwmod api changes
>>   usb : musb: Using runtime pm apis for musb.
>>
>>  arch/arm/mach-davinci/usb.c                   |    2 +
>>  arch/arm/mach-omap2/omap_hwmod.c              |   18 ++-
>>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  100 +++++++++++++
>>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |   92 ++++++++++++
>>  arch/arm/mach-omap2/pm34xx.c                  |    9 ++
>>  arch/arm/mach-omap2/usb-musb.c                |  188 
>++++++++++++++++++++-----
>>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>>  arch/arm/plat-omap/include/plat/usb.h         |    9 ++
>>  arch/arm/plat-omap/omap_device.c              |   43 ++++++
>>  arch/blackfin/mach-bf527/boards/cm_bf527.c    |    2 +
>>  arch/blackfin/mach-bf527/boards/ezbrd.c       |    2 +
>>  arch/blackfin/mach-bf527/boards/ezkit.c       |    2 +
>>  arch/blackfin/mach-bf548/boards/cm_bf548.c    |    2 +
>>  arch/blackfin/mach-bf548/boards/ezkit.c       |    2 +
>>  drivers/usb/musb/blackfin.c                   |    2 +-
>>  drivers/usb/musb/cppi_dma.c                   |    2 +-
>>  drivers/usb/musb/davinci.c                    |    2 +-
>>  drivers/usb/musb/musb_core.c                  |   26 +++-
>>  drivers/usb/musb/musb_core.h                  |    3 +-
>>  drivers/usb/musb/musbhsdma.c                  |    2 +-
>>  drivers/usb/musb/omap2430.c                   |   87 ++++++------
>>  drivers/usb/musb/tusb6010.c                   |    2 +-
>>  include/linux/usb/musb.h                      |   20 +++
>>  23 files changed, 522 insertions(+), 97 deletions(-)
>