From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/0] Power domain and clock domain patches for omap
Date: Thu, 24 Jul 2008 17:53:56 -0700
Message-ID: <200807241753.56893.david-b@pacbell.net>
References: <1216221555-18958-1-git-send-email-tony@atomide.com> <20080721222908.GF18909@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757000AbYGYAyQ@vger.kernel.org>
In-Reply-To: <20080721222908.GF18909@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 21 July 2008, Russell King - ARM Linux wrote:
> On Wed, Jul 16, 2008 at 06:19:05PM +0300, Tony Lindgren wrote:
> > I'm reposting the series to a wider audience as Russell King suspected that
> > other archs may be interested in reviewing these too, or at least some
> > parts of the code.
> 
> It would be nice to have some comment on these patches from other
> people.  My suspicions is that this infrastructure is solving a
> problem found on other SoCs in addition to OMAP,

ISTR that DaVinci is similar ... but much simpler, with fewer
power domains and more are "always on".  Not much of the DaVinci
support is upstream yet though.

I'm not sure how many non-TI parts will need similar software
support.  It's my understanding that not many vendors put
that much energy into support for leakage current management.

(Here, a key observation is that when a section of a chip has
gated all its clocks off, that leaves leakage current as the
top source of power wastage.  Cooperative drivers could then
let that section be powered down to eliminate leakage.  So the
first level of power management is clock gating, at least in
part with software support.  The power domain gating is a
second level.)


The "regulator" stuff is not unrelated ... except that this
power domain stuff *only* needs on/off switches (like almost all
power domains I've ever used), is tightly coupled to clocks,
and unlike "regulators" is more oriented towards SOC-internal
concerns than board-level ones.


> and, if this is 
> useful to other people, it should become cross-SoC infrastructure.

My two cents:  merge the OMAP stuff first, then see what kinds
of generalization would be needed before other chips could use it.

Nobody wins by holding this back ... but everyone on OMAP2/OMAP3
loses.

- Dave



> Since I don't know the answer to whether it would be useful, I'm
> trying to ensure that these patches have sufficient exposure to
> people who _may_ know the answer.
