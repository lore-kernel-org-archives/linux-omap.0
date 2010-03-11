From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: struct dmtimer definition not available in header file
Date: Thu, 11 Mar 2010 11:24:50 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9EB925F51@dnce01.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB6CA@dbde02.ent.ti.com>
 <87lje0glhj.fsf@deeprootsystems.com>
 <74583B8642AB8841B30447520659FCA9EB925C74@dnce01.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB7ED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45641 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab0CKKYx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 05:24:53 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB7ED@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gurav , Pramod" <pramod.gurav@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From: Gurav , Pramod
>Sent: Thursday, March 11, 2010 5:57 AM
>To: Cousson, Benoit; Kevin Hilman
>Cc: linux-omap@vger.kernel.org
>Subject: RE: struct dmtimer definition not available in header file
>
>Hi Benoit, Kelvin,
>
>> >>                         OMAP2_L4_IO_ADDRESS(gpt_phys_base +
>> >>                                         OMAP_TIMER_COUNTER_OFFSET);
>> >>
>> >>         gt_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
>> >>         omap_dm_timer_set_load_start(gpt, 0, 0);
>> >>
>> >>   .
>> >>   .
>> >>   .
>> >> }
>> >>
>> >> I am not able to reference *gpt as the file does not know about struct
>> >omap_dm_timer. I have included plat/dmtimer.h.
>> >>
>> >> Why doesn't the dmtimer struct definition appear in plat/dmtimer.h ?
>> >> Is there any reason for this?
>> >
>> >The declaration appears there, but the definition is hidden.
>> >
>> >In fact, it is is hidden to prevent exactly the type of thing you're
>> >trying to do, and to provide all access to DM timer details via the DM
>> >timer API.
>> >
>> >Looking at your example, I'm guessing you're trying to implement one
>> >of my ideas for the SDRC delay calculation by passing the base address
>> >to the assembly routine.
>> >
>> >As I suggested in my original patch, the better way to do this would
>> >be to extend the dmtimer API, and use C instead of assembly.
>>
>> Considering the accuracy needed in that case and the number of iteration
>> (10000), I clearly don't think we need to ack the dmtimer API to read the
>> timer value in ASM.
>> Using the regular omap_dm_timer_read_counter before and after calling the
>> ASM function will be enough.
>> Moreover the current ASM function can be simplify to reduce the overhead.
>>
>
>Thank you.
>I am trying with DMtimer API. I will even reduce the dmtimer part of ASM
>code and run only the loop in ASM.

Yes, that was my point; without the timer access the asm function will have only 3 instructions.

Regards,
Benoit

>
>Thanks and Regards
>Pramod

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



