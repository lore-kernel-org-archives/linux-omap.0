From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] OMAP3: MMC: Add mux for pins
Date: Wed, 17 Jun 2009 23:14:58 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F53D18B1@dbde02.ent.ti.com>
References: <1244846488-28313-1-git-send-email-vikram.pandita@ti.com>
 <20090615081242.GE4474@atomide.com>
 <5C07676A-0A93-48DE-B4C0-5A6709BE34A8@gmail.com>
 <20090615110431.GO4474@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F53D146A@dbde02.ent.ti.com>
 <87y6rs2nu0.fsf@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F53D14A4@dbde02.ent.ti.com>
 <20090617081206.GD6605@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37629 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbZFQRpL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 13:45:11 -0400
In-Reply-To: <20090617081206.GD6605@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Hugo Vincent <hugo.vincent@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>



>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>
>* Pandita, Vikram <vikram.pandita@ti.com> [090616 09:50]:
>>
>> >From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> >
>> >"Pandita, Vikram" <vikram.pandita@ti.com> writes:
>> >
>> >>>-----Original Message-----
>> >>>From: Tony Lindgren [mailto:tony@atomide.com]
>> >>>Sent: Monday, June 15, 2009 6:05 AM
>> >>>To: Hugo Vincent
>> >>>Cc: Pandita, Vikram; linux-omap@vger.kernel.org; Chikkature Rajashekar, Madhusudhan
>> >>>Subject: Re: [PATCH] OMAP3: MMC: Add mux for pins
>> >>>
>> >>>* Hugo Vincent <hugo.vincent@gmail.com> [090615 03:44]:
>> >>>>
>> >>>> On 15/06/2009, at 8:12 PM, Tony Lindgren wrote:
>> >>>>
>> >>>>> * Vikram Pandita <vikram.pandita@ti.com> [090612 15:43]:
>> >>>>>> For OMAP3 add MMC1 MMC2 and MMC3 pin mux
>> >>>>>>
>> >>>>>> Signed-off-by: Chikkature Rajashekar <madhu.cr@ti.com>
>> >>>>>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> >>>>>> ---
>> >>>>>> arch/arm/mach-omap2/devices.c         |   33 ++++++++++++++++++++++
>> >>>>>> arch/arm/mach-omap2/mux.c             |   49 +++++++++++++++++++++++
>> >>>>>> ++++++++++
>> >>>>>> arch/arm/plat-omap/include/mach/mux.h |   28 +++++++++++++++++++
>> >>>>>
>> >>>>> Great, just one issue: All data pins may not be connected, so you
>> >>>>> need to look at wires in struct omap_mmc_slot_data to see how many
>> >>>>> data pins to mux.
>> >>>>
>> >>>> There is another issue: different mux-outs are possible for different
>> >>>> board layouts; for example, I'm using AE10_3430_MMC3_CMD instead of
>> >>>> AC3_3430_MMC3_CMD. I'm not sure what the best way of handling this is,
>> >>>> but at a minimum, perhaps make mux setting optional, e.g. add no_mux to
>> >>>> struct omap_mmc_slot_data.
>> >>>
>> >>>Hmm, yeah that's right. I guess only the common pins should be muxed
>> >>>in  devices.c, and any optional pins should be muxed in the board-*.c
>> >>>files.
>> >>
>> >> Please check this patch set:
>> >> [PATCH 1/2] OMAP3: MMC: Pass pin muxing control flag
>> >>
>> >> I used the nomux flag to do this distinction.
>> >>
>> >
>> >This still doesn't address the problem that when you do mux, you mux
>> >all OMAP3 platforms the same way, and that is not correct.
>>
>> The patch tries to address this exact concern.
>>
>> Using nomux flag, the board file decides if the default mux for each MMC(n) controller is good for
>it or not.
>>
>> In case default is good, then MMC(n).nomux=0
>> In case default mux for any one MMC controller is not good, then for that MMC(n).nomux=1
>>
>> And the board file specifies the mux for that MMC(n) only.
>>
>> I do not see any advantage to control mux at ball level for each mmc controller instance.
>
>To me it seems cleanest just to do the muxing in board-*.c files and not even
>attempt to do it in a generic way. As we also support doing the muxing in
>the bootloader only, adding a flag for nomux can easily create hard to
>track bugs.

Ok.

>
>If some pins are always needed, and don't have alternative pinouts, then
>the common pins could be muxed in devices.c.

This is the algo we can use for MMC pin muxing in that case:

MMC1: No pin has mux clash
	Mux all 10 pins in devices.c 

MMC2: MUX CLK,CMD,D0-D3 in devices.c: D4-D7 have mux clash
	In case board needs 8 bit support,
	then in devices.c print KERN_WARNING "Configure MMC2:D4-D7 mux in board file"

MMC3: All pins have mux clash: No mux done in devices.c
	In case board specifies MMC3 usage, 
	then in devices.c print KERN_WARNING "Configure MMC3 mux in board file"

Let me know if this is final and I can submit a patch.

>
>Regards,
>
>Tony

