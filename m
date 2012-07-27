From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 2/4] ARM: OMAP: PM: Get rid of Powerdomain book-keeping
 from cpuidle
Date: Fri, 27 Jul 2012 12:16:55 +0530
Message-ID: <5012395F.3040903@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>	 <1342764284-8143-3-git-send-email-rnayak@ti.com>	 <CAMQu2gyCmx57ctZFBoAUKUXY+9zwFLCDHsBfehXicH7mEyDzQg@mail.gmail.com>	 <5009120A.1060400@ti.com> <1342774283.4672.181.camel@sokoban>	 <87obn3798o.fsf@ti.com> <50113B3C.4090608@ti.com>  <87boj2s9hi.fsf@ti.com> <1343327231.30247.151.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:44152 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751565Ab2G0GrD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jul 2012 02:47:03 -0400
Received: by obbuo19 with SMTP id uo19so3352565obb.25
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 23:47:01 -0700 (PDT)
In-Reply-To: <1343327231.30247.151.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Kevin Hilman <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com

Hi Tero,

On Thursday 26 July 2012 11:57 PM, Tero Kristo wrote:
>> Yeah, this is definitely a problem.
>> >
>> >  As long as we have autodeps, everything is centralized around CPU
>> >  transitions anyways, so it makes sense to keep the accounting
>> >  centralized too.
>> >
>>> >  >  I think as long as we have autodeps, the only way on OMAP3 to accurately
>>> >  >  do this is to do it for all dependent domains in CPUIdle:(
>> >
>> >  Or, to get rid of autodeps.;)
> Whats the reason for having them anyway? Some of the wakedeps make sense
> (per domain due to hw bugs) but sleepdeps...?
>

FWIK, the main problem is with modules with clocks under hardware
control. Once a slave module isn't functional and there are no
outstanding OCP accesses pending, the module when sent an IDLEREQ
by PRCM responds with an IDLEACK causing the clkdm to transition
to INACTIVE. A driver which is active can still in the meantime
cause a register access to the module, but the register access
does not act as an event which makes PRCM de-assert IDLEREQ causing
the module to unidle. This causes problems. So as long as there is
a possibility of some code doing a register access on the module
we need to keep it from idling. IIRC the issues we saw on OMAP3
were mostly around PER domain and I think with GPIO in particular.

The problem might be limited to modules with _only_ hardware controlled
clocks (iclks) like GPIO. For others which have an iclk and fclk, we can
always keep the autodeps while fclks are requested and get rid of them
when fclks are disabled. This is exactly what clkdm_clk_enable/disable
functions do, but given in the current mainline even iclks account
for usecounting, a clkdms usecount would never hit 0 causing 
clkdm_clk_disable never to be called. (On clkdms which have atleast one
iclk under hardware control).
hwmod keeps all iclks always enabled and under hardware control unless
the OCP interface has a 'OCPIF_SWSUP_IDLE' flag set.

But now with your series, which does not account iclks for usecounting,
I would expect this to be fixed. I was expecting for modules with both
fclk and iclk, as long as the driver has done a pm_runtime_get_sync()
or equivalent the autodeps would be set, and once the driver does a
pm_runtime_put_sync() the autodeps would be removed. This would also
be the same time we clear the Powerdomains previous power state register
and the Powerdomain should ideally immediately transition on not go in
and out with every MPU transition.
So this kind of rules out the problems that my theory above was
suggesting we would have with the $subject patch.
We still have to deal with the iclk only modules like GPIO though.

However a quick test with just your latest usecounting series (without
any of my RFC patches) seems to make me think I am still missing
something.

If you see the counts below for usbhost and dss, they both seem to
go in and out of RET with every MPU transition. Which means the
dependencies are still set.

# cat /debug/pm_debug/count
usbhost_pwrdm 
(ON),OFF:0,RET:138,INA:0,ON:139,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm 
(ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:138,INA:0,ON:139,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:0,RET:132,INA:6,ON:139,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:132,INA:6,ON:139,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm 
(RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0

However if I look at the dss registers, I don;t see any fclks are
enabled.

# ./readmem 0x48004E00
0x00000000 <- All FCLK disabled.

# ./readmem 0x48004E10
0x00000001 <- ICLK enabled

# ./readmem 0x48004E44
0x00000006 <- dependencies are set with MPU and IVA

# ./readmem 0x48004E48
0x00000003 <- clkdm is under HWSUP.

Any idea why this could be happening?

regards,
Rajendra




