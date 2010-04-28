From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] DSPBRIDGE: use dm timer framework for gpt timers
Date: Wed, 28 Apr 2010 12:22:57 -0500
Message-ID: <4BD86EF1.9080207@ti.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-4-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-5-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-6-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-7-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-8-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-9-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-10-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-11-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-12-git-send-email-omar.ramirez@ti.com>	<t2j94a0d4531004280046g49d9a0f9j60a6147b86a1854f@mail.gmail.com>	<4BD8430B.80909@ti.com> <87bpd3h774.fsf@deeprootsystems.com> <4BD863FE.80804@ti.com> <4BD869A1.8070808@ti.com> <4BD86C41.3030401@nt.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32875 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987Ab0D1RXJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 13:23:09 -0400
In-Reply-To: <4BD86C41.3030401@nt.tu-darmstadt.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Pantelic <pan@nt.tu-darmstadt.de>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Omar Ramirez Luna <omar.ramirez@hotmail.com>

Vladimir Pantelic had written, on 04/28/2010 12:11 PM, the following:
> Omar Ramirez Luna wrote:
> 
>> yes, dsp side wants:
>> bios -->  GPT5 (only used during boot up ->  baseimage load)
>> load monitoring -->  GPT 6 (used while the dsp is awake)
>> AV Sync -->  GPT 8 (based on use case)
>>
>> to generate the interrupt for mmu fault case it needs one connected to
>> the dsp interrupt line and only 5, 6, 7 or 8 apply.
> 
> and it is also GPT8 for mmu fault handling atm.
> 
> So, as GPT8 is one of the PWM capable, could that functionality be moved
> to GPT7?
> 
Obvious good point instead to tell DSP BIOS which timers to use as part 
of the params we pass to the DSP similar to what we do with frequencies 
for DSP Load balancer to work.. makes it scalable and does not allow DSP 
to hog a timer which could be used for LCD backlight dimming with PWM 
for example..

-- 
Regards,
Nishanth Menon
