From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Wed, 30 Mar 2011 19:31:07 -0500
Message-ID: <AANLkTikPqkxUGPAAjHRTg2pSn5DfDFp14gO0AKX-d+ZF@mail.gmail.com>
References: <20110317183048.GW7258@atomide.com>
	<AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
	<20110318101512.GA15375@n2100.arm.linux.org.uk>
	<201103301906.42429.arnd@arndb.de>
	<AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
	<alpine.LFD.2.00.1103301531420.28032@xanadu.home>
	<AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com>
	<alpine.LFD.2.00.1103301814250.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1103301814250.28032@xanadu.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Nico:

On Wed, Mar 30, 2011 at 6:31 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> But X86 is peanuts. =A0Really.

Finally, a voice of reason!

> On ARM there is simply not such thing as a single machine design to
> clone, and a closed source test bench to design for.

... and there almost certainly won't ever be.

I recognize the problems present in the ARM code.  But any attempt to
homogenize the ARM platform code just doesn't fit with reality.  ARM
machines are created to solve different problems from PCs, and the
diversity in the ARM platform community is a reflection of that.

I don't think that all the chaos in the ARM kernel code comes from
shite programming; I think it comes from the chaos that is ARM
hardware.

And I'm highly skeptical that any of these problems can be simply
pushed into a bootloader.  Most of my clients struggle with the
bare-minimum that is required of bootloaders now, and I don't think
they are in any way out of the ordinary.

I think that the ARM beast has to be tamed with kernel code, because
kernel programmers are the best minds available to do it.


b.g.
-- =

Bill Gatliff
bgat@billgatliff.com
