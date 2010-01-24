From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: How to put TWL/TPS into sleep?
Date: Sun, 24 Jan 2010 08:47:36 +0200
Message-ID: <4B5BED08.6070203@compulab.co.il>
References: <4B583E62.80603@compulab.co.il> <032901ca9aab$0e9ac6b0$LocalHost@wipultra1385>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:49050 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977Ab0AXGsJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 24 Jan 2010 01:48:09 -0500
In-Reply-To: <032901ca9aab$0e9ac6b0$LocalHost@wipultra1385>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly AM <x0080970@ti.com>
Cc: linux-omap@vger.kernel.org

Lesly AM wrote:
> Hi Mike,
> 
> ----- Original Message ----- From: "Mike Rapoport" <mike@compulab.co.il>
> To: <linux-omap@vger.kernel.org>
> Sent: Thursday, January 21, 2010 5:15 PM
> Subject: How to put TWL/TPS into sleep?
> 
> 
>> Hi all,
>> I'm trying to achieve maximal power savings on omap3 based system with
>> TPS65930 PMIC using twl4030_script and twl4030_resconfig. I've tried
>> different resource mappings and different command sequences in the
>> sleep/wakeup scripts by to no avail. Moreover, with some resource
>> definitions and sleep/wakeup scripts the system behaves in a weird ways,
>> e.g. does not properly respond to hard resets.
>> Most probably my resource remapping and command sequences are wrong and
>> this is the reason for system misbehavior.
>>
>> However, several things are completely unclear to me:
>> * Does TPS/TWL have defaults for sleep-on and sleep-off transitions?
> 
> AFIK TPS659x & TWL4030 is same chip, may have some Si version(ES 1.x)
> difference.
> So the power seqeunce used on TWL4030, should work on TPS659x  also.
> 
>> * What would happen if nSLEEP1 would go low/high and there is no
>> sleep/wakeup sequence programmed?
> By default reset value for the resgister pointing to [sleep/wakeup/wrst]
> seq is 0x3F, which is the exit addr for seq.
> So the TRITON resources will not have any change.
> 
>> * If I have a sleep sequence that disables some power resources, what
>> would be the state of the other resources?
> If you are using singular messages in the seq, you can address each
> resource by specifying the Resource_id.
> But if you are using broadcast messages, the resources which will
> respond depends on the Resource_group, TYPE & TYPE2 values.
> 
>>
>> I've read the TPS TRM several times to now and I still got now clue
>> about what's going on there :(
> You can verify wether your clk/volt setup_time holds good.


Thanks a lot. This is really helpful :)

>>
>>
>> -- 
>> Sincerely yours,
>> Mike.
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 


-- 
Sincerely yours,
Mike.
