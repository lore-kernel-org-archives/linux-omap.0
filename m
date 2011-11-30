From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Wed, 30 Nov 2011 17:20:04 +0100
Message-ID: <4ED657B4.9020806@ti.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com> <1319467559-5518-5-git-send-email-ming.lei@canonical.com> <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com> <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com> <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com> <4EC6566C.70202@ti.com> <alpine.DEB.2.00.1111261854340.6289@utopia.booyaka.com> <alpine.DEB.2.00.1111261906010.6289@utopia.booyaka.com> <4ED50600.8070607@ti.com> <alpine.DEB.2.00.1111291053250.6289@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38409 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757124Ab1K3QUY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 11:20:24 -0500
In-Reply-To: <alpine.DEB.2.00.1111291053250.6289@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ming Lei <ming.lei@canonical.com>, linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi Paul,

On 11/29/2011 7:11 PM, Paul Walmsley wrote:
> On Tue, 29 Nov 2011, Cousson, Benoit wrote:
>
>> On 11/27/2011 3:07 AM, Paul Walmsley wrote:
>>
>>> So just out of curiosity, do those SYSCONFIG registers in the STM address
>>> space apply to the entire DEBUGSS, or just the STM IP block?
>>
>> The STM IP is the only one to have the TI generic wrapper to be compliant with
>> TI standards.
>> But in term of PRCM, there is only one IP, the DEBUGSS.
>> There are probably a bunch of internal clock management inside it that are not
>> exposed to PRCM.
>>
>> The confusing part is that in theory all these entries can be accessed by the
>> same OCP port, and should potentially have this flags.
>> The point is that for the moment, we are mainly using that flag to get the
>> SYSCONFIG.
>> We already discussed that, but I think we should modify this flag to highlight
>> the SYSCONFIG / SYSSTATUS availability.
>> Maybe with something like ADDR_SYSCONFIG?
>>
>> Any thought?
>
> Well, the ADDR_TYPE_RT flag in this hwmod would indicate the address space
> of the DEBUGSS's OCP header registers, not the MIPI STM's OCP header
> registers.
>
> So if the MIPI STM's OCP header registers also control the entire DEBUGSS
> power management, then the current layout makes sense.  Otherwise, the
> MIPI STM should be created as a separate hwmod.

There is no OCP TA registers in this case, so finding the SYSCONFIG is 
the only important thing to do to set them properly at boot time.

> It appears to me that the DEBUGSS has no OCP header registers of its own.

Yes, indeed.

> Upon reflection, rather than creating a macro hwmod for the DEBUGSS, it
> seems to make more sense to add hwmods for its two internal interconnects,
> then to create another hwmod for the MIPI STM device.

Mmm, I'm not sure it makes sense to do that. There is only one PRCM 
control entry for all these IPs inside the debugss "module". The diagram 
28.9 seems to indicate that the STM is accessed through L3_INSTR using 
some internals L4_CFG_EMU and L3_INSTR_EMU buses.

So for the hwmod / driver point of view having only one node for the 
debugss IPs connected to L3_INSTR is accurate enough. This is as well 
how the memory mapping is represented in the 28-42 table (28.11$).

Moreover, having two different nodes controlled by a single PRCM entry 
will raise some dependency issue with STM and DEBUGSS.

Splitting them will add some extra complexity that is not necessary in 
our case.

Regards,
Benoit
