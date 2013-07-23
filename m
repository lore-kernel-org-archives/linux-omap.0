From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Tue, 23 Jul 2013 12:33:03 +0530
Message-ID: <51EE2AA7.5060503@ti.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57697 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab3GWHDi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:03:38 -0400
In-Reply-To: <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 23 July 2013 01:37 AM, Paul Walmsley wrote:
> On Mon, 22 Jul 2013, Russell King - ARM Linux wrote:
> 
>> Bear in mind that I'm almost at the point of not boot-testing anything
>> I sent to Linus because of the uselessness of the SDP4430 board now
>> that it's DT only - the only platform which boot-tests anything I send
>> is the 3430LDP board now.  If people care about that, maybe they can
>> assist with sorting out the issues I've raised on these lists about
>> the SDP4430 - and why the SDP4430 build remains disabled in my build
>> and boot system.
> 
> I understand completely...
> 
>> Looking at the boot log, it just stops after uboot hands over control.
>> With the lack of output from the decompressor, it's not possible to
>> tell whether it's a decompressor problem or a kernel problem.
>>
>> I think you need to turn on the LL_DEBUG option, select the appropriate
>> output option, and also get the decompressor to use the kernel's debug
>> io functions to output it's stuff (I think the option is DEBUG_UNCOMPRESS).
> 
> OK, will dig deeper here at the next opportunity.

Paul, I can take a look at the 4430sdp issue. Are you also seeing this also on
2430sdp as the subject says, or was that a typo?

> 
> 
> - Paul
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

