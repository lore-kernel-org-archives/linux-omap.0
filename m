From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP Zoom kernel ALSA build problem
Date: Thu, 4 Dec 2008 11:03:08 -0800
Message-ID: <200812041103.09366.david-b@pacbell.net>
References: <23D0CDE7C386D144A4F26EB0F427F8C019A5829E@dlee04.ent.ti.com> <5d5443650812040951p33886dcchd04b11932641625b@mail.gmail.com> <BD771A35-18A7-41C7-80F5-0BC59D77597C@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:33267 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758200AbYLDTDM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 14:03:12 -0500
In-Reply-To: <BD771A35-18A7-41C7-80F5-0BC59D77597C@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Trilok Soni <soni.trilok@gmail.com>, "Smith, Stephen" <smsmith@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 04 December 2008, Koen Kooi wrote:
> >>> Perhaps that kernel should sync with newer code?
>
>  	The rest =A0
> of the beagleboards peeps wants to get things as fast as possible int=
o =A0
> mainline instead of wanting awesomely good powermanagement.

Bull hockey ... they want *BOTH* mainline support and good PM.  :)

PM support is still cooking.  Support for other OMAP goodness
can -- and does! -- evolve in parallel.


Having a ZOOM fork to help roll goodies out of TI-internal trees
into mainline is fine -- TI has OMAP hardware for a long time before=20
the chips go public -- but the goal should be to *help* and that means
both (a) tracking mainline, probably via linux-omap, and (b) pushing
goodies out of that ZOOM fork so they're more broadly available.

So for example the NAND acceleration stuff seems to have gone
nowhere ... while that ZOOM fork may have some updates, they've not
gotten into the main OMAP tree, or into mainline.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
