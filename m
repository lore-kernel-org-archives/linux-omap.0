From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] ARM: OMAP: drop "select MACH_NOKIA_RM696"
Date: Fri, 08 Mar 2013 18:20:32 +0100
Message-ID: <1362763232.5994.75.camel@x61.thuisdomein>
References: <1362738596.5994.48.camel@x61.thuisdomein>
	 <20130308161159.GE14552@blackmetal.musicnaut.iki.fi>
	 <20130308163507.GC26093@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130308163507.GC26093@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2013-03-08 at 08:35 -0800, Tony Lindgren wrote:
> I think the righ fix is to just add
> 
> config MACH_NOKIA_RM680
> 	bool

I guess you meant MACH_NOKIA_RM696.

> to the mach-omap2/Kconfig like we have for n8x0 also.

Should I draft a patch?


Paul Bolle
