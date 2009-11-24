From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 1/2] ARM: Implemented support for VFP PM context saving
Date: Tue, 24 Nov 2009 15:05:35 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2236DA1C1AB@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1259059024-23719-1-git-send-email-tero.kristo@nokia.com>
	 <1259059024-23719-2-git-send-email-tero.kristo@nokia.com>
	 <20091124114836.GA10510@n2100.arm.linux.org.uk>
 <1259068826.13956.22.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17559 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929AbZKXOGT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 09:06:19 -0500
In-Reply-To: <1259068826.13956.22.camel@pc1117.cambridge.arm.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: catalin.marinas@arm.com, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cestes@quicinc.com

 

>-----Original Message-----
>From: ext Catalin Marinas [mailto:catalin.marinas@arm.com] 
>Sent: 24 November, 2009 15:20
>To: Russell King - ARM Linux
>Cc: Kristo Tero (Nokia-D/Tampere); linux-omap@vger.kernel.org; 
>linux-arm-kernel@lists.infradead.org; Dave Estes
>Subject: Re: [PATCH 1/2] ARM: Implemented support for VFP PM 
>context saving
>
>On Tue, 2009-11-24 at 11:48 +0000, Russell King - ARM Linux wrote:
>> On Tue, Nov 24, 2009 at 12:37:03PM +0200, Tero Kristo wrote:
>> > In some ARM architectures, like OMAP3, the VFP context can 
>be lost during
>> > dynamic sleep cycle. For this purpose, there is now a function
>> > vfp_pm_save_context() that should be called before the VFP 
>is assumed to
>> > lose context. Next VFP trap will then restore context 
>automatically.
>> >
>> > We need to have the last_VFP_context[cpu] cleared after 
>the save in idle,
>> > else the restore would fail to restore when it sees that 
>the last_VFP_context
>> > is same as the current threads vfp_state. This happens 
>when the same
>> > process/thread traps an exception post idle.
>> >
>> > Main work for this patch was done by Peter and Rajendra. 
>Some cleanup and
>> > optimization by Tero.
>> 
>> Why not re-use vfp_pm_suspend() ?  Haven't you shown that 
>vfp_pm_suspend
>> may be buggy since it doesn't save in the VFP-disabled case?
>BTW, the two patches below were mentioned to me some time ago but I
>haven't got the time to look at them:
>
>[ARM] vfp: Fix bug in vfp_pm_suspend
>https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=c
>ommit;h=88984c9b2d69c222ee1e2afc948ca73f597d40ff
>
>[ARM] vfp: Add additional vfp interfaces
>https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=c
>ommit;h=393e4bfaaf79377d29cd6bb2228f87601aeca668

These look pretty much like the same thing we have attempted on the omap3 patches, I could try these out and check if they work for omap3 also. They fix the potentially broken suspend also.

-Tero
