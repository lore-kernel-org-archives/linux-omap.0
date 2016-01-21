From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: dts: n900: Include adp1653 device
Date: Thu, 21 Jan 2016 16:54:08 +0000
Message-ID: <20160121165408.GJ5783@n2100.arm.linux.org.uk>
References: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
 <20160121091241.GS7192@pali>
 <20160121092909.GH5783@n2100.arm.linux.org.uk>
 <20160121101828.GA7411@amd>
 <20160121163857.GH19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160121163857.GH19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 21, 2016 at 08:38:57AM -0800, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [160121 02:19]:
> > On Thu 2016-01-21 09:29:10, Russell King - ARM Linux wrote:
> > > The merge window is open, which is when development code that was merged
> > > in good time prior to the merge window is sent upstream to Linus.  Linux
> > > maintainers may choose not to merge new code into their tree to avoid
> > > disrupting the utility of linux-next until the merge window has
> > > closed.
> > 
> > Support for new hardware is normally allowed after -rc1.
> 
> Yeah most maintainers avoid looking at new code until -rc1. Or until
> regresssions are out of the way. So patience please. Fixes are
> welcome any time though.

Indeed.  However, unlike Pavel's comment, many maintainers choose not
to merge code for new hardware until the merge window - it's very rare
that support for new hardware is merged during the -rc phase.

If it were otherwise, I would've been able to get the Hummingboard 2
DTS patches in, or the etnaviv team would've been able to get the
Etnaviv GPU DRM driver in during the 4.4-rc cycle, or the Dove PMU
driver, or... etc.

Practically, new code waits for merge windows, because no one wants
to de-stabilise the progression of the -rc series with new code, and
Linus wants to see -rc merges fairly quiet and be mostly bug fixes
so he can feel good about a final release around -rc6 to -rc7 time.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
