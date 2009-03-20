From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM branch rebased to 2.6.29
Date: Fri, 20 Mar 2009 11:59:27 -0700
Message-ID: <20090320185927.GR29546@atomide.com>
References: <87bprz9zju.fsf@deeprootsystems.com> <200903191520.55565.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52525 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760088AbZCTS7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 14:59:38 -0400
Content-Disposition: inline
In-Reply-To: <200903191520.55565.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [090319 15:27]:
> On Tuesday 17 March 2009, Kevin Hilman wrote:
> > - Beagle: MMC regulator: unbalanced disables. =A0This happens on bo=
ot
> > =A0 and during suspend/resume. I don't think this is related to the=
 PM
> > =A0 branch, but is probably in linux-omap HEAD also, but didn't tes=
t.
>=20
> It is.  Other boards may see that too.  Two fixes:
>=20
>  * Least hassle ... I think all these should merge to the
>    linux-omap tree in any case (and thence linux-pm):
>=20
>     http://marc.info/?l=3Dlinux-omap&m=3D123699264117846&w=3D2
>     http://marc.info/?l=3Dlinux-omap&m=3D123699340818395&w=3D2
>     http://marc.info/?l=3Dlinux-omap&m=3D123705919713239&w=3D2

Pushed these. That way we'll end up with a working
2.6.29-omap1 :)

Dave, got a version of the third patch above against the
mainline kernel? That could be added to the omap3-boards
queue for the upcoming merge window.
=20
>  * Or there are a number of regulator-framework patches
>    floating around, all of which fix the bug there...
>=20
> The root cause of this is that u-boot leaves VMMC1 active,
> and the regulator framework doesn't cope with that yet.
> The stackdump is basically caused by self-inconsistencies
> in that framework.
>=20
> The first fix lets the twl4030-power driver (not yet on
> track for mainline merge) undo that, so the regulator
> framework will no longer be confused.  That presumes a
> bunch of board-specific patches fix that issue.  (As
> well as setting up other power resources, e.g. so that
> CLKREQ behaves, which is the real goal of that patch.)
>=20
> The second fix -- in some flavor -- is IMO still needed,
> since the first fix is just avoiding regulator framework
> bugs. =20

To me it sounds like the regulator framework should eventually
handle the regulators left on by the bootloader. Just let me
know if some other patches are needed to l-o tree meanwhile.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
