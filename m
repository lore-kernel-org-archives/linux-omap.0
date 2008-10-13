From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: git pull request for minimal omap3 support one more time
Date: Mon, 13 Oct 2008 14:32:56 +0100
Message-ID: <20081013133256.GA3510@flint.arm.linux.org.uk>
References: <1223035779-26306-1-git-send-email-tony@atomide.com> <dbdb2ea60810030852h67b898a8p13b716f2e6c746e6@mail.gmail.com> <20081004070534.GB30190@muru.com> <20081009145436.GI435@flint.arm.linux.org.uk> <20081009151724.GK26230@atomide.com> <20081010073251.GN435@flint.arm.linux.org.uk> <20081010091557.GI3044@atomide.com> <20081010092520.GK3044@atomide.com> <20081010113533.GU3044@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36436 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489AbYJMNdN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2008 09:33:13 -0400
Content-Disposition: inline
In-Reply-To: <20081010113533.GU3044@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: twebb <taliaferro62@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Oct 10, 2008 at 02:35:34PM +0300, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [081010 12:41]:
> > * Tony Lindgren <tony@atomide.com> [081010 12:15]:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [081010 11:42=
]:
> > > > On Thu, Oct 09, 2008 at 06:17:25PM +0300, Tony Lindgren wrote:
> > > > > Sure, I'll post a minimal LDP patch separately tomorrow. I do=
n't have
> > > > > an LDP so I can't verify it boots though.
> > > >=20
> > > > Unfortunately, Linus has been unpredictable, and released 2.6.2=
7 last
> > > > night, rather than the usual one week after -rc9.
> > > >=20
> > > > What this means is that the merge window is now open, and I sho=
uldn't
> > > > be accepting anything else into my kernel tree.
> > > >=20
> > > > However, if you can get LDP in by this evening, I'll pull it in=
to the
> > > > tree.  That will be the final devel code merged into my tree fo=
r 2.6.28.
> > >=20
> > > Sure. Here's the minimal board patch for LDP with it's defconfig
> > > in the following mail. Also added to the omap3-upstream queue.
> >=20
> > Here's the defconfig.
>=20
> And here's the updated pull request for you with the LDP patches adde=
d.
>=20
> I also changed the title of the Overo patches to say OMAP3 instead of
> OMAP2 for consistency.
>=20
> Note that this will also pull the already posted omap2-upstream as
> omap3-upstream is based on that.

There's something wrong with one of the sets I've pulled from you:

arch/arm/mach-omap2/mcbsp.c:253: error: =E2=80=98INT_24XX_MCBSP3_IRQ_RX=
=E2=80=99 undeclared here (not in a function)
arch/arm/mach-omap2/mcbsp.c:254: error: =E2=80=98INT_24XX_MCBSP3_IRQ_TX=
=E2=80=99 undeclared here (not in a function)
arch/arm/mach-omap2/mcbsp.c:262: error: =E2=80=98INT_24XX_MCBSP4_IRQ_RX=
=E2=80=99 undeclared here (not in a function)
arch/arm/mach-omap2/mcbsp.c:263: error: =E2=80=98INT_24XX_MCBSP4_IRQ_TX=
=E2=80=99 undeclared here (not in a function)
arch/arm/mach-omap2/mcbsp.c:271: error: =E2=80=98INT_24XX_MCBSP5_IRQ_RX=
=E2=80=99 undeclared here (not in a function)
arch/arm/mach-omap2/mcbsp.c:272: error: =E2=80=98INT_24XX_MCBSP5_IRQ_TX=
=E2=80=99 undeclared here (not in a function)

Please take a look and resolve ASAP.  Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
