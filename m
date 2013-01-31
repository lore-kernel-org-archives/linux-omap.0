From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: Failure to boot...
Date: Thu, 31 Jan 2013 20:13:10 +0530
Message-ID: <510A82FE.6050803@ti.com>
References: <20130131030203.GA8374@quad.lixom.net> <alpine.LFD.2.02.1301302312030.6300@xanadu.home> <20130131092024.GN2637@n2100.arm.linux.org.uk> <20130131104044.GO2637@n2100.arm.linux.org.uk> <510A6877.9080307@ti.com> <20130131130437.GP2637@n2100.arm.linux.org.uk> <510A78E1.8010308@ti.com> <20130131141320.GQ2637@n2100.arm.linux.org.uk> <20130131141635.GR2637@n2100.arm.linux.org.uk> <510A7D9F.7040507@ti.com> <20130131142758.GS2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56670 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339Ab3AaOmL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 09:42:11 -0500
In-Reply-To: <20130131142758.GS2637@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 31 January 2013 07:57 PM, Russell King - ARM Linux wrote:
> On Thu, Jan 31, 2013 at 07:50:15PM +0530, Santosh Shilimkar wrote:
>> On Thursday 31 January 2013 07:46 PM, Russell King - ARM Linux wrote:
>>> On Thu, Jan 31, 2013 at 02:13:20PM +0000, Russell King - ARM Linux wrote:
>>>> On Thu, Jan 31, 2013 at 07:30:01PM +0530, Santosh Shilimkar wrote:
>>>>> Linus' tip(commit: 04c2eee5) + arm-soc for-next boots fine as well.
>>>>> The pull request from Tony [1] fixed the multi-platform boot issue
>>>>> for OMAP.
>>>>>
>>>>> Now trying to merge your for-next and test.
>>>>
>>>> Well, my tip (which is based on Linus' 6abb7c25) also builds and
>>>> boots fine.
>>>>
>>>> Hang on...
>>>>
>>>> # CONFIG_ARCH_OMAP2PLUS is not set
>>>> CONFIG_ARCH_VEXPRESS=y
>>>>
>>>> which of course won't boot, and this happens on both oldconfigs because
>>>> of the change to multiplatform support.
>>>
>>> And no, the instructions given last time around to add:
>>>
>>> # 13 Jan 2013: Update for OMAP moving to multiplatform
>>> CONFIG_ARCH_MULTIPLATFORM=y
>>> CONFIG_ARCH_MULTI_V7=y
>>>
>>> don't fix it either, it needs more options defined...
>>>
>> Linus' tip + Tony's pull [1] request also makes things work
>> on OMAP.
>
> Thanks to all this multiplatform stuff, the autobuilder has been building
> nothing but Versatile Express kernels for the last 20 days.  That totally
> explains why it won't boot.
>
> The only thing I was told is to add the above two config symbols.  That
> is not the complete story.  There's also other symbols which need adding
> too.  It also looks like Versatile Express support _can't_ be disabled in
> a multiplatform kernel, which is ludicrous.
>
> And... fixing the config finally results in something that boots on the
> SDP4430.
>
Great. Thanks for the confirmation.

Regards,
Santosh
