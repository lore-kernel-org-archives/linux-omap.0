From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 1 Apr 2011 09:39:38 -0700
Message-ID: <AANLkTikfBhCH5wrpYzKbws0F_UVaskhtN_SUGQ+hU8Ab@mail.gmail.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
 <201104011554.07924.arnd@arndb.de> <1301671655.28467.52.camel@e102144-lin.cambridge.arm.com>
 <201104011755.57412.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201104011755.57412.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@elte.hu>, david@lang.hm, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <Catalin.Marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 1, 2011 at 8:55 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Well, except that because of point 7, device trees are still inferior to
> having correct and complete information in hardware.

Oh, absolutely.

If you have discoverable hardware, use it.

But by "discoverable hardware" I mean something like PCI config
cycles. IOW, real hardware features. Not some code like

   if (board_signature_is(xyz)) {
     ...

that just maps some _other_ hardware knowledge (reading a SoC ID or
something) into an unrelated thing ("I know this SoC has these bits of
hardware").

So devicetree should never override actual "hardware tells me it
exists here". But you might well have a mapping from SoC ID's to a
compiled-in devicetree thing (this is largely what POWER does, iirc).

                Linus
