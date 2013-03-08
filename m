From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: drop "select MACH_NOKIA_RM696"
Date: Fri, 8 Mar 2013 09:55:39 -0800
Message-ID: <20130308175539.GG26093@atomide.com>
References: <1362738596.5994.48.camel@x61.thuisdomein>
 <20130308161159.GE14552@blackmetal.musicnaut.iki.fi>
 <20130308163507.GC26093@atomide.com>
 <1362763232.5994.75.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1362763232.5994.75.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Bolle <pebolle@tiscali.nl> [130308 09:24]:
> On Fri, 2013-03-08 at 08:35 -0800, Tony Lindgren wrote:
> > I think the righ fix is to just add
> > 
> > config MACH_NOKIA_RM680
> > 	bool
> 
> I guess you meant MACH_NOKIA_RM696.

Ooops yes.
 
> > to the mach-omap2/Kconfig like we have for n8x0 also.
> 
> Should I draft a patch?

Sure that would be nice.

Tony
