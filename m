From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next: manual merge of the arm tree
Date: Tue, 14 Oct 2008 13:08:05 -0700
Message-ID: <20081014200805.GF8150@atomide.com>
References: <20081014132745.051f6418.sfr@canb.auug.org.au> <20081014075950.GA22855@flint.arm.linux.org.uk> <200810140107.14647.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200810140107.14647.david-b@pacbell.net>
Sender: linux-next-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Russell King <rmk@arm.linux.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-omap@vger.kernel.org, Richard Woodruff <r-woodruff2@ti.com>, linux-next@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Wim Van Sebroeck <wim@iguana.be>, Syed Mohammed Khasim <khasim@ti.com>
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081014 11:53]:
> On Tuesday 14 October 2008, Russell King wrote:
> > Since the OMAP updates I merged from Tony are already broken due to
> > missing definitions, and I'm not getting any response from Tony on
> > fixing those,

I just sent you a fix for that few hours ago.

> Probably has to do with his travel plans, which he mentioned
> last week (Thursday?).  I think he's back online in the next
> day or two.
>=20
>=20
> > I will be dropping the problematical updates so we can=20
> > at least keep mainline OMAP in a buildable state. =A0That seems to =
mean
> > dropping the new OMAP3 support.

Yes, I'm back online. And please don't drop these patches, sounds
like this is a trivial merge issue.

Regards,

Tony
