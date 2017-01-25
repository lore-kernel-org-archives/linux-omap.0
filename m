From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 19:39:21 +0000
Message-ID: <20170125193921.GA1832@remoulade>
References: <20170125000641.25520-1-furquan@chromium.org>
 <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
 <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
 <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
 <20170125182319.GB25470@leverpostej>
 <20170125182955.uznr5ehpx4dabcon@sirena.org.uk>
 <20170125183420.GC25470@leverpostej>
 <20170125184949.x2wkoo7kbaaajkjk@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125184949.x2wkoo7kbaaajkjk@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Furquan Shaikh <furquan@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, ACPI
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 25, 2017 at 06:49:49PM +0000, Mark Brown wrote:
> On Wed, Jan 25, 2017 at 06:34:20PM +0000, Mark Rutland wrote:
> > On Wed, Jan 25, 2017 at 06:29:55PM +0000, Mark Brown wrote:
> 
> > > > Mark, this was added in this cycle; can we please rip that out for now?
> 
> > > If it's instantiated directly we probably should.
> 
> > I think that given the larger problem that needs to be addressed here,
> > and how the us of DSD properties muddies the water, it would be
> > preferable to remove it until we have some consensus.
> 
> Can you send a patch with a writeup please?

Sure. I've sent [1].

Thanks,
Mark.

[1] http://lkml.kernel.org/r/1485372609-2498-1-git-send-email-mark.rutland@arm.com
