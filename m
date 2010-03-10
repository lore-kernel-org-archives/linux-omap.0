From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: struct dmtimer definition not available in header file
Date: Wed, 10 Mar 2010 21:57:59 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9EB925C74@dnce01.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB6CA@dbde02.ent.ti.com>
 <87lje0glhj.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53716 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757150Ab0CJU6G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 15:58:06 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <87lje0glhj.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Gurav , Pramod" <pramod.gurav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Kevin Hilman
>Sent: Wednesday, March 10, 2010 6:01 PM
>
>"Gurav , Pramod" <pramod.gurav@ti.com> writes:
>
>> Hi All,
>> I am using dmtimer in my code. Code looks like this:
>>
>> {
>>         static struct omap_dm_timer *gpt;
>>         void * __iomem gpt10_counter_reg;
>>         unsigned long gpt_phys_base;
>>
>>         omap_dm_timer_init();
>>         gpt = omap_dm_timer_request();
>>         if (!gpt) {
>>                 pr_err("Could not get the gptimer\n");
>>                 return -1;
>>         }
>>         omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
>>
>>         gpt_phys_base = gpt->phys_base;
>>
>>         gpt10_counter_reg =
>>                         OMAP2_L4_IO_ADDRESS(gpt_phys_base +
>>                                         OMAP_TIMER_COUNTER_OFFSET);
>>
>>         gt_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
>>         omap_dm_timer_set_load_start(gpt, 0, 0);
>>
>>      .
>>      .
>>      .
>> }
>>
>> I am not able to reference *gpt as the file does not know about struct
>omap_dm_timer. I have included plat/dmtimer.h.
>>
>> Why doesn't the dmtimer struct definition appear in plat/dmtimer.h ?
>> Is there any reason for this?
>
>The declaration appears there, but the definition is hidden.
>
>In fact, it is is hidden to prevent exactly the type of thing you're
>trying to do, and to provide all access to DM timer details via the DM
>timer API.
>
>Looking at your example, I'm guessing you're trying to implement one
>of my ideas for the SDRC delay calculation by passing the base address
>to the assembly routine.
>
>As I suggested in my original patch, the better way to do this would
>be to extend the dmtimer API, and use C instead of assembly.

Considering the accuracy needed in that case and the number of iteration (10000), I clearly don't think we need to ack the dmtimer API to read the timer value in ASM.
Using the regular omap_dm_timer_read_counter before and after calling the ASM function will be enough.
Moreover the current ASM function can be simplify to reduce the overhead.

Regards,
Benoit

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



