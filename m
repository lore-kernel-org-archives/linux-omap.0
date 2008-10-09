From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: git-pull request for omap mcbsp changes (Re: [PATCH 5/5] ARM: OMAP: Fixes to omap_mcbsp_request function)
Date: Thu, 9 Oct 2008 15:29:44 +0100
Message-ID: <20081009142944.GE435@flint.arm.linux.org.uk>
References: <1222262955-13599-1-git-send-email-tony@atomide.com> <1222262955-13599-2-git-send-email-tony@atomide.com> <1222262955-13599-3-git-send-email-tony@atomide.com> <1222262955-13599-4-git-send-email-tony@atomide.com> <1222262955-13599-5-git-send-email-tony@atomide.com> <1222262955-13599-6-git-send-email-tony@atomide.com> <20081004143712.GE16636@flint.arm.linux.org.uk> <20081007184827.GI7263@flint.arm.linux.org.uk> <20081008073236.GA30831@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53318 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbYJIO36 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 10:29:58 -0400
Content-Disposition: inline
In-Reply-To: <20081008073236.GA30831@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

On Wed, Oct 08, 2008 at 10:32:37AM +0300, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [081008 04:25]:
> > On Sat, Oct 04, 2008 at 03:37:12PM +0100, Russell King - ARM Linux =
wrote:
> > > On Wed, Sep 24, 2008 at 04:29:15PM +0300, Tony Lindgren wrote:
> > > > From: Jarkko Nikula <jarkko.nikula@nokia.com>
> > > >=20
> > > > Bootloader may let McBSP logic running so make sure that block =
is idle
> > > > before requesting IRQs. Also make sure that TX and RX waitqueue=
s are
> > > > initialized before request_irq.
> > > >=20
> > > > Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >=20
> > > Ok.
> >=20
> > The other question to ask about these patches is: does it finally a=
llow
> > mainline to reach parity with your tree on the McBSP code?
>=20
> Yes.
>=20
> > If not, is it possible to have a set of patches which brings the Mc=
BSP
> > code completely up to date in mainline?
>=20
> There are no other McBSP patches pending right now.
>=20
> Here's the pull request for you for these patches:
>=20
> The following changes since commit 56f68556d7bbb51dd158c74deb09c78334=
5bfbbd:
>   Russell King (1):
>         Merge unstable branch 'omap-rmk'
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6=
=2Egit omap-upstream
>=20
> Chandra Shekhar (2):
>       ARM: OMAP: Allocate McBSP devices dynamically
>       ARM: OMAP: Add support for McBSP devices 3 - 5 on 34xx
>=20
> Jarkko Nikula (2):
>       ARM: OMAP: Add support for OMAP2430 in McBSP
>       ARM: OMAP: Fixes to omap_mcbsp_request function
>=20
> Uwe Kleine-K=F6nig (1):
>       Fix sections for omap-mcbsp platform driver

Pulled.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
