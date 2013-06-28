From: Roger Quadros <rogerq@ti.com>
Subject: Re: omap4 ehci sporadic resume issue
Date: Fri, 28 Jun 2013 15:55:08 +0300
Message-ID: <51CD87AC.6060107@ti.com>
References: <51CC2755.2030505@amarulasolutions.com> <51CC454A.1040104@ti.com> <20130627141704.GF12956@panicking> <51CC5105.4070301@ti.com> <20130627175623.GB21364@panicking> <CAB=otbQXVqFKOTtgvif=FZnWgDpbovAB6naPKTrsEHUJb21xTw@mail.gmail.com> <20130627192413.GA14115@panicking> <CAB=otbT-BcJg5tNZ=7jd1jvoK8N1Hd_skScuxczaeP=tagdcSw@mail.gmail.com> <20130628113314.GA25536@panicking> <51CD7783.8030907@ti.com> <20130628122604.GB25536@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51070 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228Ab3F1MzM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jun 2013 08:55:12 -0400
In-Reply-To: <20130628122604.GB25536@panicking>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>, USB list <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

On 06/28/2013 03:26 PM, Michael Trimarchi wrote:
> Hi
> 
> On Fri, Jun 28, 2013 at 02:46:11PM +0300, Roger Quadros wrote:
>> On 06/28/2013 02:33 PM, Michael Trimarchi wrote:
>>> Hi Roger
>>>
>>> On Thu, Jun 27, 2013 at 11:07:11PM +0300, Ruslan Bilovol wrote:
>>>> On Thu, Jun 27, 2013 at 10:24 PM, Michael Trimarchi
>>>> <michael@amarulasolutions.com> wrote:
>>
>>>> Do you have locks around this software workaround?
>>>> The patch I did against 3.4 linux kernel may be helpful for
>>>> you in such case: http://review.omapzoom.org/28515
>>>> Another patch extends this WA for all OMAP4 SoCs:
>>>> http://review.omapzoom.org/31108
>>>
>>> I'm testing using pm_test and stop to core (5ms and not 5 seconds) (usb suspend cycle are done correctly) so
>>> the problem could be:
>>>
>>> 1) SAR usb context restore. I have applied the SAR workaround but the core doesn't go in full retantion
>>> could be it a problem?
>>
>> If core doesn't go in to OFF then SAR will not come into play. Are you still affected by the
>> issue if OFF mode is disabled? If yes then it probably is not related to SAR.
>>
> 
> I don't go in full retantion for FSUSB now
> 
> [   36.317413]    PD_CORE curr=ON prev=ON logic=ON
> [   36.317413]    PD_L3_INIT curr=ON prev=ON logic=ON
> [   36.317413]       CD_L3_INIT mode=SW_SLEEP activity=0x2100
> [   36.317413]          FSUSB mode=DISABLED stbyst=STBY idlest=TRANSITION
> [   36.317413] Powerdomain (core_pwrdm) didn't enter target state 1 Vs achieved state 3. current state 3
> [   36.317413] Powerdomain (l3init_pwrdm) didn't enter target state 1 Vs achieved state 3. current state 3
> 
> This with enable_off_mode equal to 1 and usb stuck
> 
> but if I switch to enable_off_mode 0 (debug file), it works. So the problem seems somewhere there.

OK. Looks like the FSUSB module is stuck in transition. This can happen if the bootloader
hasn't improperly managed the FSUSB clock.

Can you apply the below patch to your bootloader and make sure FSUSB module is OFF at boot.

Let's see how it behaves with FSUSB out of the picture.

cheers,
-roger

>From 0e42d3643d531daabd086f7ee451fdda8f22e72a Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Wed, 25 Apr 2012 06:05:20 +0000
Subject: [PATCH] omap4: do not enable fs-usb module

If this is done in the bootloader, the FS-USB will later be stuck into
intransition state, which will prevent the device from entering idle.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/cpu/armv7/omap4/clocks.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/cpu/armv7/omap4/clocks.c b/arch/arm/cpu/armv7/omap4/clocks.c
index e2189f7..2802559 100644
--- a/arch/arm/cpu/armv7/omap4/clocks.c
+++ b/arch/arm/cpu/armv7/omap4/clocks.c
@@ -355,7 +355,6 @@ void enable_basic_clocks(void)
 		&prcm->cm_l4per_gptimer2_clkctrl,
 		&prcm->cm_wkup_wdtimer2_clkctrl,
 		&prcm->cm_l4per_uart3_clkctrl,
-		&prcm->cm_l3init_fsusb_clkctrl,
 		&prcm->cm_l3init_hsusbhost_clkctrl,
 		0
 	};
@@ -482,7 +481,6 @@ void enable_non_essential_clocks(void)
 		&prcm->cm_dss_dss_clkctrl,
 		&prcm->cm_sgx_sgx_clkctrl,
 		&prcm->cm_l3init_hsusbhost_clkctrl,
-		&prcm->cm_l3init_fsusb_clkctrl,
 		0
 	};
 
-- 
1.7.4.1
