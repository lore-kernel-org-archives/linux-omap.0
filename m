From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Mon, 30 Nov 2015 11:09:42 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511301041090.22569@knanqh.ubzr>
References: <20150713131902.GH26485@atomide.com> <20151129180939.GE30871@n2100.arm.linux.org.uk> <alpine.LFD.2.20.1511291902100.22569@knanqh.ubzr> <201511300115.12478@pali> <20151130152352.GY2517@atomide.com> <20151130153933.GD29576@pali>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-715320669-1448899783=:22569"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151130153933.GD29576@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Laura Abbott <lauraa@codeaurora.org>, Sebastian Reichel <sre@debian.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-715320669-1448899783=:22569
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 30 Nov 2015, Pali Rohár wrote:

> On Monday 30 November 2015 07:23:53 Tony Lindgren wrote:
> > * Pali Rohár <pali.rohar@gmail.com> [151129 16:16]:
> > > On Monday 30 November 2015 01:09:17 Nicolas Pitre wrote:
> > > > On Sun, 29 Nov 2015, Russell King - ARM Linux wrote:
> > > > > On Sat, Nov 28, 2015 at 12:34:23PM -0500, Nicolas Pitre wrote:
> > > > > > Good. And Arnd likes the idea too. So we might be converging at
> > > > > > last which is a good thing.
> > > > > 
> > > > > I disagree with the idea that there is convergence.  There might be
> > > > > convergence towards an idea, but... Here's a mail extract, from
> > > > > July 7th, from earlier in this very thread:
> > > > > 
> > > > > Pali:
> > > > > > Me:
> > > > > > > Are the ATAGs at a fixed address on the N900?
> > > > > > 
> > > > > > Yes, in board-rx51.c is:
> > > > > > 
> > > > > > .atag_offset    = 0x100
> > > > > > 
> > > > > > and Nokia Bootloader (proprietary) store them to that address.
> > > > > > 
> > > > > > > Can that be handled in
> > > > > > > some kind of legacy file for the N900 which calls save_atags()
> > > > > > > on it, so we don't end up introducing yet more stuff that we
> > > > > > > have to maintain into the distant future?  If not, what about
> > > > > > > copying a known working atag structure into a legacy file for
> > > > > > > the N900?
> > > > > > 
> > > > > > I already asked question if it is possible to read ATAGs from DT
> > > > > > booted kernel. And somebody (do not remember who) wrote to ML,
> > > > > > that it is not possible and it can be done in that uncompress
> > > > > > code.
> > > > 
> > > > Who is that somebody? If ever it happened to be me then objection is
> > > > withdrawn. Otherwise that somebody should come forth and speak up
> > > > again.
> > > > 
> > > 
> > > ... do not remember ... this discussion were in more email threads and 
> > > takes more then one year... sorry but my memory is not excellent
> > 
> > Yes this certainly seems like the best solution. I think we got into
> > the atags-to-dt track as some of the atags are already being translated.
> > 
> > In this case there's no need to translate them AFAIK. You can just
> > parse them and have them available for the user space. So as long as
> > nothing trashes the atags at the atag_offset, you should be able to
> > call a function to parse them in the n900 specific init_machine.
> > 
> > Regards,
> > 
> > Tony
> 
> In arch/arm/kernel/setup.c is function setup_arch() and it calls:
> 
>   mdesc = setup_machine_fdt(__atags_pointer);
>   if (!mdesc)
>       mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
> 
> So it looks like that on atags address is stored either atags structure
> or DT structure... so it is truth kernel uncompress code put DT blob to
> same offset where is expected atags structure?

No.  It doesn't put it anywhere. Those functions read DT/ATAGs from the 
passed address.  But you know this address won't be the one you want for 
the legacy ATAGs.

What you should do is to add a init_early hook to your mdesc structure 
and retrieve your ATAGs from there directly at PAGE_OFFSET + 0x100.

Now I suspect paging_init() marks the point where the ATAGs will be 
overwritten.  To prevent this, you might have to add an additional tweak 
in arm_mm_memblock_reserve() similar to the one already present for 
CONFIG_SA1111. Something like:

	memblock_reserve(PHYS_OFFSET, PAGE_SIZE);

And later on you can return that page back to the system.


Nicolas
--8323328-715320669-1448899783=:22569--
