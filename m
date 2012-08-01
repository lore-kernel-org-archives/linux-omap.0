From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Wed, 1 Aug 2012 13:17:55 -0500
Message-ID: <501972D3.7070606@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com> <50045D17.9050704@ti.com> <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com> <50171841.40309@ti.com> <501760BF.8070801@ti.com> <5018210A.1040902@ti.com> <50187644.40308@ti.com> <alpine.DEB.2.00.1208010906470.21488@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39836 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368Ab2HASSJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 14:18:09 -0400
In-Reply-To: <alpine.DEB.2.00.1208010906470.21488@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On 08/01/2012 10:08 AM, Paul Walmsley wrote:
> Hi Jon,
> 
> On Tue, 31 Jul 2012, Jon Hunter wrote:
> 
>> Sorry for all the emails. However, I wanted to get this out to you as
>> I am due to be out for a couple weeks. 
>>
>> So I have updated your patch [1] with the following changes ...
>>
>> 1. Re-based on top of your omap3 clock domain fix [2]
>> 2. Modified the above change I mentioned to check for
>>    CLKDM_MISSING_IDLE_REPORTING in omap_pm_clkdms_setup() instead of
>>    the omap2_clkdm_clk_enable(). This is to prevent the clock domain
>>    being placed in HW_AUTO on boot if enabled early.
>> 3. Made the other change I mentioned earlier [3].
>>
>> This is now working well for me on OMAP3/4.
> 
> Your changes look good to me.  Do you have a strong preference as to 
> whether that patch should go in as part of 3.6-rc or 3.7?  I'd be inclined 
> to queue it for 3.7 based on the size of the patch.

Thanks for the feedback. 3.7 is fine with me, I don't expect the PMU
changes I have will be in before that.

Cheers
Jon
