From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP Zoom kernel ALSA build problem
Date: Fri, 5 Dec 2008 15:35:52 -0800
Message-ID: <200812051535.52534.david-b@pacbell.net>
References: <23D0CDE7C386D144A4F26EB0F427F8C019A5829E@dlee04.ent.ti.com> <200812041103.09366.david-b@pacbell.net> <20081204223849.GH7054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:47119 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753340AbYLEXfy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 18:35:54 -0500
In-Reply-To: <20081204223849.GH7054@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, Trilok Soni <soni.trilok@gmail.com>, "Smith, Stephen" <smsmith@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 04 December 2008, Tony Lindgren wrote:
> > So for example the NAND acceleration stuff seems to have gone
> > nowhere ... while that ZOOM fork may have some updates, they've not
> > gotten into the main OMAP tree, or into mainline.
>=20
> That is frustrating. People at TI _should_ be working on sending
> patches from zoom to upstream.

Or even just getting their goodness into the linux-omap tree,
as a first step towards getting upstream.

I used the OMAP3 NAND stuff as an example, since we saw a few
(unmergeable) patches but then everything seemed to fizzle.


> Sure the other people can also=20
> produce patches against the mainline and linux-omap kernel out
> of the zoom tree.

That would require people to track the ZOOM kernels, as well
as mainline and linux-omap (and their own patch queues).
Not too realistic.


> In general, here's how the patch flow needs to happen:
>=20
> - All driver patches need to be posted to the right driver mailing
> =A0 lists with linux-omap mailing list Cc'd. The patches need need
> =A0 to be against the mainline kernel tree. The recent developments
> =A0 with the ASoC and the new fb/v4l code is a good example how this
> =A0 is working.

Yes.  And in the case of stuff like NAND, where there's a ZOOM
driver and a Linux-OMAP driver but nothing in mainline, I suggest
syncing those two *before* pushing to mainline ... though there
may well be a case for involving the relevant mainline team at
that point too, or ignoring one driver.


> - All core omap code needs to be posted to linux-omap for review
> =A0 and will then be queued up into going into the mainline tree.
> =A0 For any patches that apply already into the mainline kernel,
> =A0 the patches need to be against the mainline kernel. For any
> =A0 more complex patches, also linux-arm-kernel and maybe LKML lists
> =A0 should be Cc'd.

Yep, that's straightforward.  By "core" I presume you mean
arch/arm/plat-omap or maybe mach-omap{1,2}.


> Soonish the linux-omap tree will become just a queue for patches
> for the merge windows. So essentially we'll be using the mainline
> kernel with some branches automerged hopefully real-soon-now.

That sounds like an interesting plan.  It'll cause some level
of disruption ... which we probably need to have, since without
it folk seem to have little incentive to track mainline.

A slightly different spin:  treat every divergence from mainline
as a bug that needs fixing.  Those branches should mostly have
fairly short lifespans...


> I think the right time to make that switch after Paul's clock
> patches are integrated into the mainline kernel. Then we'll move
> the non-mainline code into their own branches, or just drop it
> if nobody wants to maintain it.

Sounds like a plan.  Let's see how different the OMAP tree is
from mainline at that point, and see what the branches will be.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
