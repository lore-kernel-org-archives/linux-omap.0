From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP Zoom kernel ALSA build problem
Date: Thu, 4 Dec 2008 14:38:50 -0800
Message-ID: <20081204223849.GH7054@atomide.com>
References: <23D0CDE7C386D144A4F26EB0F427F8C019A5829E@dlee04.ent.ti.com> <5d5443650812040951p33886dcchd04b11932641625b@mail.gmail.com> <BD771A35-18A7-41C7-80F5-0BC59D77597C@student.utwente.nl> <200812041103.09366.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51905 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbYLDWiz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 17:38:55 -0500
Content-Disposition: inline
In-Reply-To: <200812041103.09366.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, Trilok Soni <soni.trilok@gmail.com>, "Smith, Stephen" <smsmith@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [081204 11:03]:
> On Thursday 04 December 2008, Koen Kooi wrote:
> > >>> Perhaps that kernel should sync with newer code?
> >
> >  	The rest =A0
> > of the beagleboards peeps wants to get things as fast as possible i=
nto =A0
> > mainline instead of wanting awesomely good powermanagement.
>=20
> Bull hockey ... they want *BOTH* mainline support and good PM.  :)
>=20
> PM support is still cooking.  Support for other OMAP goodness
> can -- and does! -- evolve in parallel.

Paul and RMK are working on getting the omap clock patches into
mainline. After that we can work on getting Kevin's PM branch into
mainline.

> Having a ZOOM fork to help roll goodies out of TI-internal trees
> into mainline is fine -- TI has OMAP hardware for a long time before=20
> the chips go public -- but the goal should be to *help* and that mean=
s
> both (a) tracking mainline, probably via linux-omap, and (b) pushing
> goodies out of that ZOOM fork so they're more broadly available.

Yes, the upstream feedback seems to be still missing from zoom.

> So for example the NAND acceleration stuff seems to have gone
> nowhere ... while that ZOOM fork may have some updates, they've not
> gotten into the main OMAP tree, or into mainline.

That is frustrating. People at TI _should_ be working on sending
patches from zoom to upstream. Sure the other people can also
produce patches against the mainline and linux-omap kernel out
of the zoom tree.

In general, here's how the patch flow needs to happen:

- All driver patches need to be posted to the right driver mailing
  lists with linux-omap mailing list Cc'd. The patches need need
  to be against the mainline kernel tree. The recent developments
  with the ASoC and the new fb/v4l code is a good example how this
  is working.

- All core omap code needs to be posted to linux-omap for review
  and will then be queued up into going into the mainline tree.
  For any patches that apply already into the mainline kernel,
  the patches need to be against the mainline kernel. For any
  more complex patches, also linux-arm-kernel and maybe LKML lists
  should be Cc'd.

Soonish the linux-omap tree will become just a queue for patches
for the merge windows. So essentially we'll be using the mainline
kernel with some branches automerged hopefully real-soon-now.

I think the right time to make that switch after Paul's clock
patches are integrated into the mainline kernel. Then we'll move
the non-mainline code into their own branches, or just drop it
if nobody wants to maintain it.

In general, people are encouraged to maintain their own branches
for more larger patches, like we already have for pm, clocks,
dspbridge, mmc, i2c. Then I can mirror these branches and automerge
them branches on daily basis.

Cheers,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
