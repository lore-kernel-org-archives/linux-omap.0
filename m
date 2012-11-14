From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Wed, 14 Nov 2012 15:57:40 -0600
Message-ID: <50A413D4.7000405@gmail.com>
References: <20121114185335.GU6801@atomide.com> <50A3EBCD.3040801@ti.com> <20121114202244.GE3332@n2100.arm.linux.org.uk> <20121114203221.GA6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41161 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480Ab2KNV5o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 16:57:44 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so1008020obb.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Nov 2012 13:57:43 -0800 (PST)
In-Reply-To: <20121114203221.GA6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dave Martin <dave.martin@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 11/14/2012 02:32 PM, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121114 12:24]:
>> On Wed, Nov 14, 2012 at 01:06:53PM -0600, Jon Hunter wrote:
>>>
>>> On 11/14/2012 12:53 PM, Tony Lindgren wrote:
>>>> Looks like enabling CONFIG_ARM_ERRATA_751472 causes omap4 blaze
>>>> to not boot when enabled. The ARM core on it is an earlier r1p2:
>>>>
>>>> CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
>>>>
>>>> Unfortunately I don't have the details of errata 751472, but I'm
>>>> guessing we need to disable it for r1p*.
>>>
>>> I checked the CA9MP errata document and this erratum impacts all
>>> r0/r1/r2 CPUs. I am wondering if the problem is because the workaround
>>> requires you to set a bit in the Diagnostic Control register and the
>>> read-modify-write sequence provided in the workaround is for secure
>>> mode. Not sure if there is a non-secure workaround available :-(
>>
>> Most likely, and there's not a lot that the kernel can sanely do about
>> that.  We have ended up deciding (through being forced to because of
>> how the security stuff works) that the stages prior to the kernel will
>> implement the work-around enables because those stages are already
>> platform specific, and the kernel will implement a "test for the
>> work-around already enabled."
>>
>> The net result is, if you enable an Errata in the kernel which your
>> earlier boot stages has not already configured, the kernel will hang.
>> Not much we can do about the hanging aspect, because the kernel takes
>> an exception which we can't trap at those early stages in the boot
>> process.
>>
>> I'm not particularly happy about that design, but that's what we've
>> ended up with through the 'design' of the security stuff forced onto
>> us.
> 
> Checking for the bit already set should work in this case, I'll post
> a patch for that shortly.

Can you actually read the state of the diagnostic register in non-secure
mode? If you can on the A9, is the same true on A8 or others?

Multi-platform kernels present a new problem in that we basically need
to enable all errata work-arounds. I've been meaning to look thru the
errata work-arounds to figure out which ones can be selected for
multi-platform kernels without side effects on unaffected parts (i.e.
set a chicken bit based on core revision). For any in runtime paths, we
may need to do runtime patching if they have performance impact.

Rob
