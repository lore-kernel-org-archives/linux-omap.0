From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 4/8] ARM: OMAP2+: hwmod: revise hardreset behavior
Date: Thu, 19 Apr 2012 21:14:37 +0200
Message-ID: <4F90641D.3090208@ti.com>
References: <20120228053524.16278.59430.stgit@dusk> <20120228053654.16278.73632.stgit@dusk> <alpine.DEB.2.00.1204182253550.29048@utopia.booyaka.com> <4F90001E.8060201@ti.com> <alpine.DEB.2.00.1204191050110.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40258 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab2DSTOn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 15:14:43 -0400
In-Reply-To: <alpine.DEB.2.00.1204191050110.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Hi Paul,

On 4/19/2012 7:17 PM, Paul Walmsley wrote:
> Hi Beno=EEt,
>
> On Thu, 19 Apr 2012, Cousson, Benoit wrote:
>
>> The concern of the people doing SW in these embedded processors was =
mainly
>> because we were releasing the reset of processor without loading any=
 SW first
>> and thus the processor was executing some random instructions.
>>
>> So if we consider a better hwmods definition, we can potentially fix=
 the MMU
>> case:
>>
>>      'mmu_ipu':
>>          'rst_ipu_mmu_cache'
>>
>>      'mmu_dsp':
>>          'rst_dsp_mmu_cache'
>>
>>      'iva_config':
>>          'rst_logic'
>
> Wouldn't these still be "pseudo-hwmods?"  Or do each of these actuall=
y
> have address space, interconnect ports, etc.?

Yes, these ones are the only real IPs for MPU stand point, with=20
interconnect port and configuration registers.

> Another approach that might not require defining pseudo-hwmods is to
> define a per-hard-reset-line flag that could be used to alter the way=
 the
> hwmod code handles the hardreset line.

Yes, I think this is what Rajendra proposed long time ago...

>> But then we do have the processor resets that have to be exposed som=
ewhere.
>>
>>      'ipu':
>>          'rst_cpu0'
>>          'rst_cpu1'
>>
>>      'dsp':
>>          'rst_dsp'
>>
>>      'iva':
>>          'rst_seq1'
>>          'rst_seq2'
>>
>> None of these one should be controlled automatically.
>
> Don't we still want to put these IP blocks into reset until a driver =
for
> these IP blocks is loaded?

Yes, indeed, my point is where are we going to declare these reset line=
s=20
if we do not have any fake hwmods to store them.

>>>    	/*
>>> -	 * If an IP contains HW reset lines, then de-assert them in order
>>> -	 * to allow the module state transition. Otherwise the PRCM will
>>> return
>>> -	 * Intransition status, and the init will failed.
>>> +	 * If an IP block contains HW reset lines and any of them are
>>> +	 * asserted, we let integration code associated with that
>>> +	 * block handle the enable.  We've received very little
>>> +	 * information on what those driver authors need, and until
>>> +	 * detailed information is provided and the driver code is
>>> +	 * posted to the public lists, this is probably the best we
>>> +	 * can do.
>>
>> Maybe we should keep that with some mechanism to prevent it for some=
 IP like
>> processors .
>>
>> I guess that with that patch, we cannot enable anymore IPU/DSP and I=
VA at boot
>> time.
>
> I am probably misunderstanding your comment, but I don't think there'=
s any
> way at the moment to generically enable those IP blocks without drive=
r
> integration code assistance.

Well, for the MMU we can, these are regular IPs (almost). The real=20
issues was for the processors.

> If we leave the hardreset lines asserted in _enable(), then the PRCM
> status for those modules will be stuck in In-transition state, accord=
ing
> to the previous comments in the code.  I think this will block PM idl=
e
> transitions.  Also we have no way to restore the clockdomain idle set=
tings
> during the second part of the hwmod enable sequence, I think, since i=
t
> will need to be executed by driver integration code :-(
>
> And I don't think we can deassert the hardreset lines in _enable() ri=
ght
> now, for the reason that you mentioned in your message: unless the dr=
iver
> integration code implements a custom reset function, we don't have an=
y way
> to load code into the IP block before deasserting the hardreset.

=46ully agree, what I was trying to highlight is that we do have two ty=
pes=20
of hardreset here: the processors ones and the MMU / Logic ones.
Only the processors do require some special management because a=20
firmware has to be loaded first.

> So at this point I'd propose that we encourage these driver authors t=
o
> implement custom reset functions for their IP blocks that load firmwa=
re if
> needed, and put them into idle, similar to what omap3_iva_idle() does=
 in
> mach-omap2/pm34xx.c.  If the custom reset function takes the IP block=
 out
> of hardreset, then the subsequent hwmod enable/idle/shutdown calls sh=
ould
> work, after this patch.

=46irst they will have to release their driver :-)

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
