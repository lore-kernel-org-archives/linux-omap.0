From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 15:39:40 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1103311411090.22418@localhost6.localdomain6>
References: <20110317183048.GW7258@atomide.com> <AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com> <20110318101512.GA15375@n2100.arm.linux.org.uk> <201103301906.42429.arnd@arndb.de> <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
 <20110331001502.GB6680@n2100.arm.linux.org.uk> <AANLkTinE7EDbV8hrYZWBxgvwOxdPMLoS0Y57PSm04rvM@mail.gmail.com> <AANLkTik-BFTzyPLuYVdhCJPocc0wPY0rKvO7BQS4Fg1S@mail.gmail.com> <AANLkTikd_JRxmB_OWZqq178=K3bnxhdDqcNbgFNRtTyU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463795968-327262446-1301574738=:22418"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikd_JRxmB_OWZqq178=K3bnxhdDqcNbgFNRtTyU@mail.gmail.com>
Content-ID: <alpine.LFD.2.00.1103311534310.22418@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bill Gatliff <bgat@billgatliff.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795968-327262446-1301574738=:22418
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LFD.2.00.1103311534311.22418@localhost6.localdomain6>

On Wed, 30 Mar 2011, Linus Torvalds wrote:

> On Wed, Mar 30, 2011 at 6:15 PM, Bill Gatliff <bgat@billgatliff.com> wrote:
> >
> > I'm not sure this metric is completely fair to ARM.  If you want to
> > level the field, I think you have to divide each result by the number
> > of SoC's
> 
> But that's the problem with ARM. Hardware companies that do one-off
> stuff, with no sense of compatibility.
> 
> And calling it an "opportunity" is just stupid.
> 
> There's nothing good about causing extra work just because ARM hasn't
> had the sense to standardize on one (or a couple) of interrupt
> controllers etc.

Well, ARM is not the only one there, it's the top one, but mips and
power are not less crazy. Here are the top five architectures counted
in number of irq_chip implementations.

      arch/arm     139
      arch/mips    75
      arch/powerpc 44
      arch/alpha   21
      arch/x86     15

Thanks,

	tglx
---1463795968-327262446-1301574738=:22418--
