From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: HYP Kernel boot requirements
Date: Wed, 27 Nov 2013 14:38:54 +0000
Message-ID: <20131127143854.GB10411@e102568-lin.cambridge.arm.com>
References: <CAMJs5B8XX-93YcRyTiQ1JRcKUB5oer8cV7FLtMPP6SeqeB3RwQ@mail.gmail.com>
 <52937AB4.1060901@ti.com>
 <CAMJs5B9nnpqjSmT7vi9cvC4e9Fx2Bft4rRGxmVKyLP7JbGMPAg@mail.gmail.com>
 <529381E4.3090405@ti.com>
 <20131125172825.GD8396@arm.com>
 <5293A888.9050500@ti.com>
 <20131126141346.GA692@arm.com>
 <5294B471.7020205@ti.com>
 <20131126173751.GF2355@e103592.cambridge.arm.com>
 <52951756.9000206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55038 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab3K0Oi7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 09:38:59 -0500
In-Reply-To: <52951756.9000206@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Dave P Martin <Dave.Martin@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>, linux-omap <linux-omap@vger.kernel.org>, Christoffer Dall <christoffer.dall@linaro.org>

On Tue, Nov 26, 2013 at 09:49:10PM +0000, Santosh Shilimkar wrote:
> On Tuesday 26 November 2013 12:37 PM, Dave Martin wrote:
> > On Tue, Nov 26, 2013 at 09:47:13AM -0500, Santosh Shilimkar wrote:
> >> On Tuesday 26 November 2013 09:13 AM, Catalin Marinas wrote:
> >>> On Mon, Nov 25, 2013 at 07:44:08PM +0000, Santosh Shilimkar wrote:
> >>>> On Monday 25 November 2013 12:28 PM, Catalin Marinas wrote:
> >>>>> On Mon, Nov 25, 2013 at 04:59:16PM +0000, Santosh Shilimkar wrote:
> >>>>>> What I am saying is the platforms like OMAP5 already support PM in
> >>>>>> mainline kernel and we can't break that for KVM. Boot-loaders
> >>>>>> would be thrashed after boot so you need something which runs
> >>>>>> in Kernel or along with Kernel to have equivalent of hyp
> >>>>>> switching.
> >>>>>>
> >>>>>> Am not challenging the agreed direction but we need to solve the
> >>>>>> PM problem as well before making "all CPU runs boot-loader for
> >>>>>> HYP kernels" as a must have. At least its is a change in boot
> >>>>>> strategy from existing kernels.
> >>>>>
> >>>>> Of course I recommend PSCI which covers both hotplug and suspend ;), but
> >>>>> I guess it's not the case for OMAP5. Since OMAP has its own secondary
> >>>>> booting protocol and CPU hotplug re-entry, can you not just use
> >>>>> different entry point when the primary CPU was initially started in Hyp
> >>>>> mode (e.g. omap5_hyp_secondary_startup)?
> >>>>>
> >>>> How will that solve the guest secondary boot failure case when using
> >>>> the same kernel binary for guest-boot ? Even for primary CPU which
> >>>> will be suspended it needs to resume already in HYP mode and its not
> >>>> going to go through boot-loader. So the low power code needs to have
> >>>> HYP switch code so that CPU resumes in HYP mode.
> >>>
> >>> Is it late to rewrite the OMAP5 firmware?
> >>>
> >> Well its ROM'ed unfortunately so no choice. OMAP5 ROM did implement
> >> a secure API which lets you enter into HYP mode and thats the only
> >> thing can be used.
> > 
> > If the ROM is capable of loading some additional signed Secure World
> > firmware after the ROM itself has booted, PSCI could be implemented
> > in the second, resident firmware payload.
> > 
> > Some SoCs ship with boot ROMs that can do that -- is this not the case
> > for OMAP5?
> > 
> On OMAP, the secure devices there is a way to do this but not for 
> general purpose devices. General purpose devices once you
> exit the ROM code, we exit out of security and only way to
> re-enter secure word is via ROM implemented monitor/secure
> APIs.

As last resort, you can still write a bunch of instructions acting as
warm-bootloader, reserve a page and add them there. Code required is just
a shim layer and should not require more than few bytes, after all
it has just to check some variables and jump accordingly (+ calling
smc if required).

Not pretty, agreed, but still better than patching the kernel IMHO
(basically you will end up patching the bootloader - and possibly the
dtb - instead, to install the shim mentioned above).

Lorenzo

