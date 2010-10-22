From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v3 09/11] OMAP3: PM: Smartreflex Class3 initialization
 from board files.
Date: Fri, 22 Oct 2010 20:13:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035EB95EAC@dbde02.ent.ti.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-10-git-send-email-thara@ti.com>
 <87aamgpc5e.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55361 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab0JVOoE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 10:44:04 -0400
In-Reply-To: <87aamgpc5e.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Friday, October 15, 2010 5:20 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v3 09/11] OMAP3: PM: Smartreflex Class3 initialization
>>from board files.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch enables smartreflex class3 functionality for OMAP3430SDP,
>>> OMAP3630SDP, ZOOM2 and ZOOM3 boards.
>>
>>This patch doesn't touch 3630sdp.
>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>I'm having some doubts about whether this should be done by board files or
>>not.  Seems like the general case will be that by default will be SoC
>>specific, and only boards that want something other than the default
>>class should need to override this.
>>
>>Thoughts?

I agree. I wanted this to be a default initcall and one to enable the menuconfig option for the required class driver.. But Nishant wanted this from board files. If we have consensus in removing this init from board file, I am cool with it.

Regards
Thara
>>
>>Kevin
>>
>>> ---
>>>  arch/arm/mach-omap2/board-3430sdp.c          |    2 ++
>>>  arch/arm/mach-omap2/board-zoom-peripherals.c |    2 ++
>>>  2 files changed, 4 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-
>>omap2/board-3430sdp.c
>>> index 67b95b5f..9a04a2e 100644
>>> --- a/arch/arm/mach-omap2/board-3430sdp.c
>>> +++ b/arch/arm/mach-omap2/board-3430sdp.c
>>> @@ -47,6 +47,7 @@
>>>  #include "sdram-qimonda-hyb18m512160af-6.h"
>>>  #include "hsmmc.h"
>>>  #include "pm.h"
>>> +#include "smartreflex-class3.h"
>>>
>>>  #define CONFIG_DISABLE_HFCLK 1
>>>
>>> @@ -813,6 +814,7 @@ static void __init omap_3430sdp_init(void)
>>>  	sdp3430_display_init();
>>>  	enable_board_wakeup_source();
>>>  	usb_ehci_init(&ehci_pdata);
>>> +	sr_class3_init();
>>>  }
>>>
>>>  MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
>>> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-
>>omap2/board-zoom-peripherals.c
>>> index 6b39849..98dffc6 100644
>>> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
>>> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
>>> @@ -26,6 +26,7 @@
>>>
>>>  #include "mux.h"
>>>  #include "hsmmc.h"
>>> +#include "smartreflex-class3.h"
>>>
>>>  /* Zoom2 has Qwerty keyboard*/
>>>  static int board_keymap[] = {
>>> @@ -282,4 +283,5 @@ void __init zoom_peripherals_init(void)
>>>  	omap_i2c_init();
>>>  	usb_musb_init(&musb_board_data);
>>>  	enable_board_wakeup_source();
>>> +	sr_class3_init();
>>>  }
