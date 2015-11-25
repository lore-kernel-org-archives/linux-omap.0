From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry
Date: Wed, 25 Nov 2015 22:29:53 +0100
Message-ID: <3245119.krc4KB3uae@wuerfel>
References: <20150713131902.GH26485@atomide.com> <17134653.86P3dFyQKK@wuerfel> <20151125210310.GT2517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151125210310.GT2517@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, Frank Rowand <frowand.list@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 25 November 2015 13:03:10 Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [151125 11:50]:
> > On Wednesday 25 November 2015 10:16:44 Tony Lindgren wrote:
> > > At least I don't have better solutions in mind.
> > 
> > I would be happier if we could restrict this as much as possible to the
> > boards that need it, as an opt-in. That way it doesn't become an ABI
> > for people that don't already rely in this information. How about
> > adding a check the code adds the linux,atags property to do it
> > only for a whitelist of board numbers?
> 
> Or populate /proc/atags only for the ones that need it from machine
> specific init_early?

That would also address my main concern about /proc/atags, but still
leave the atags in /proc/device-tree/chosen/linux,atags, and it would
be bad if someone who currently uses /proc/atags changes their code
to use the other file instead of finding a proper solution.

	Arnd
