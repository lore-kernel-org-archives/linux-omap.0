From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: HYP Kernel boot requirements
Date: Tue, 26 Nov 2013 09:47:13 -0500
Message-ID: <5294B471.7020205@ti.com>
References: <1385251666-27532-1-git-send-email-santosh.shilimkar@ti.com> <1385251666-27532-3-git-send-email-santosh.shilimkar@ti.com> <CAMJs5B8XX-93YcRyTiQ1JRcKUB5oer8cV7FLtMPP6SeqeB3RwQ@mail.gmail.com> <52937AB4.1060901@ti.com> <CAMJs5B9nnpqjSmT7vi9cvC4e9Fx2Bft4rRGxmVKyLP7JbGMPAg@mail.gmail.com> <529381E4.3090405@ti.com> <20131125172825.GD8396@arm.com> <5293A888.9050500@ti.com> <20131126141346.GA692@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40713 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756897Ab3KZOrw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Nov 2013 09:47:52 -0500
In-Reply-To: <20131126141346.GA692@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Tony Lindgren <tony@atomide.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Tuesday 26 November 2013 09:13 AM, Catalin Marinas wrote:
> On Mon, Nov 25, 2013 at 07:44:08PM +0000, Santosh Shilimkar wrote:
>> On Monday 25 November 2013 12:28 PM, Catalin Marinas wrote:
>>> On Mon, Nov 25, 2013 at 04:59:16PM +0000, Santosh Shilimkar wrote:
>>>> What I am saying is the platforms like OMAP5 already support PM in
>>>> mainline kernel and we can't break that for KVM. Boot-loaders
>>>> would be thrashed after boot so you need something which runs
>>>> in Kernel or along with Kernel to have equivalent of hyp
>>>> switching.
>>>>
>>>> Am not challenging the agreed direction but we need to solve the
>>>> PM problem as well before making "all CPU runs boot-loader for
>>>> HYP kernels" as a must have. At least its is a change in boot
>>>> strategy from existing kernels.
>>>
>>> Of course I recommend PSCI which covers both hotplug and suspend ;), but
>>> I guess it's not the case for OMAP5. Since OMAP has its own secondary
>>> booting protocol and CPU hotplug re-entry, can you not just use
>>> different entry point when the primary CPU was initially started in Hyp
>>> mode (e.g. omap5_hyp_secondary_startup)?
>>>
>> How will that solve the guest secondary boot failure case when using
>> the same kernel binary for guest-boot ? Even for primary CPU which
>> will be suspended it needs to resume already in HYP mode and its not
>> going to go through boot-loader. So the low power code needs to have
>> HYP switch code so that CPU resumes in HYP mode.
> 
> Is it late to rewrite the OMAP5 firmware?
> 
Well its ROM'ed unfortunately so no choice. OMAP5 ROM did implement
a secure API which lets you enter into HYP mode and thats the only
thing can be used.

> What I meant is that you have the same kernel binary but with two sets
> of entry points, or maybe a single set of entry points and some global
> variable that you set during cold boot if the primary CPU is entered in
> Hyp mode. So you change the boot loader to switch to Hyp before it
> starts the kernel and leave the additional switching to be done by the
> secondary entry points (or PM code) based on the variable you set during
> cold boot. But I would recommend rewriting the firmware.
> 
>> I will look at PSCI more closely and see what can be done here.
> 
> PSCI has a different secondary start-up and hotplug/suspend protocol and
> CPUs wake up in Hyp if available. But this requires changing your
> firmware, PSCI is not a kernel-only thing. Do you need to support both
> older and newer kernels with the OMAP5 firmware (and possibly same DT)?
>
Hmmm.. So thats rules out PSCI for OMAP5 then.

Keystone actually has nice way to deal with the problem since the
boot-monitor code can be patched up and hence I had no trouble
implementing the "CPU starts in HYP mode" requirement on it.

Regards,
Santosh


 

