From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 3/3] ARM: errata 430973: move !ARCH_MULTIPLATFORM to Kconfig
Date: Mon, 27 Jul 2015 10:59:56 +0100
Message-ID: <55B6011C.9070906@codethink.co.uk>
References: <1437612483-30160-1-git-send-email-sre@kernel.org> <1437612483-30160-4-git-send-email-sre@kernel.org> <20150723123553.GE7576@n2100.arm.linux.org.uk> <20150724001605.GA1453@earth> <20150726225145.GF7576@n2100.arm.linux.org.uk> <20150727011447.GA23087@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150727011447.GA23087@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 27/07/15 02:14, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Jul 26, 2015 at 11:51:45PM +0100, Russell King - ARM Linux 
> wrote:
>> On Fri, Jul 24, 2015 at 02:16:06AM +0200, Sebastian Reichel 
>> wrote:
>>> On Thu, Jul 23, 2015 at 01:35:53PM +0100, Russell King - ARM 
>>> Linux wrote:
>>>> On Thu, Jul 23, 2015 at 02:48:03AM +0200, Sebastian Reichel 
>>>> wrote:
>>>>> Having the !ARCH_MULTIPLATFORM dependency in the Kconfig 
>>>>> file results in one option less to think about when 
>>>>> configuring the kernel.
>>>> 
>>>>> -#if defined(CONFIG_ARM_ERRATA_430973) && 
>>>>> !defined(CONFIG_ARCH_MULTIPLATFORM) +#ifdef 
>>>>> CONFIG_ARM_ERRATA_430973 teq	r3, #0x00100000			@ only 
>>>>> present in r1p* mrceq	p15, 0, r0, c1, c0, 1		@ read aux 
>>>>> control register orreq	r0, r0, #(1 << 6)		@ set IBE to 1
>>>> 
>>>> NAK.  Please read the mailing list history, I'm not
>>>> repeating myself again on this.  Thanks.
>>> 
>>> It's a bit hard to search the mailing list history without a 
>>> bit more information.
>> 
>> You were Cc'd on the previous round of review...
> 
> But that discussion was about removing the check alltogether iirc.
>  This patch does not remove the !ARCH_MULTIPLATFORM check. It just
>  *moves* it from the sourcecode to the errata's Kconfig entry.
> 
> The intention was to hide the Kconfig option on multiplatform 
> kernels, since it's completely useless there after the N900 
> boardcode has been changed (PATCH 1/3).
> 
>>> I guess you prefer to just add the !ARCH_MULTIPLATFORM 
>>> dependency to the Kconfig entry without removing the
>>> additional check in the code?
>> 
>> I was referring to the above change.
>> 
>> However, having discussed with Will Deacon and checked the 
>> manuals, I think the change is okay after all: the auxillary 
>> control register is banked on secure parts, and the bit we'll be 
>> trying to change will be read-only in non-secure mode - and 
>> importantly won't fault.
>> 
>> So, the change is fine, thanks.
> 
> I think you missed the part adding the !ARCH_MULTIPLATFORM 
> dependency in Kconfig for ARM_ERRATA_430973. I only removed the 
> check in the sourcecode, since it is no longer required with the 
> dependency being in Kconfig.
> 
> So I guess there are 3 options now:
> 
> 1. Add !ARCH_MULTIPLATFORM dependency to Kconfig, keep extra check 
> in the sourcecode 2. Add !ARCH_MULTIPLATFORM dependency to Kconfig,
> remove extra check in the sourcecode 3. Remove !ARCH_MULTIPLATFORM
> dependency alltogether
> 
> I will send an appropriate patch, if you tell me your preferred 
> option.

This isn't the only place ARM_ERRATA_430973 is used, and if
you make it configurable on !ARCH_MULTIPLATFORM then it makes
it impossible to use a ARCH_MULTIPLATFORM kernel on something
that is an Cortex-A8.

See arch/arm/mm/proc-v7-2level.S

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
