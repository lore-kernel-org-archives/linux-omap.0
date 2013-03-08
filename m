From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] ARM: OMAP: drop "select MACH_NOKIA_RM696"
Date: Fri, 08 Mar 2013 19:02:44 +0100
Message-ID: <1362765764.5994.87.camel@x61.thuisdomein>
References: <1362738596.5994.48.camel@x61.thuisdomein>
	 <20130308161159.GE14552@blackmetal.musicnaut.iki.fi>
	 <20130308163507.GC26093@atomide.com>
	 <1362763232.5994.75.camel@x61.thuisdomein>
	 <20130308175539.GG26093@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130308175539.GG26093@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2013-03-08 at 09:55 -0800, Tony Lindgren wrote:
> * Paul Bolle <pebolle@tiscali.nl> [130308 09:24]:
> > Should I draft a patch?
> 
> Sure that would be nice.

One thing I couldn't determine is how the generated mach-types.h header
handles multiple CONFIG_MACH_* macros.

If both CONFIG_MACH_FOO and CONFIG_MACH_BAR are defined, and these both
have a line in */mach-types, will the machine_is_foo() and
machine_is_bar() macros both behave as one would expect?


Paul Bolle
