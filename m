From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Debobs and ETK padconf implementation
Date: Thu, 25 Sep 2008 13:37:53 -0700
Message-ID: <200809251337.54394.david-b@pacbell.net>
References: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com> <200809251004.12962.david-b@pacbell.net> <48DBF45F.7020601@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:25800 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753142AbYIYUh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 16:37:56 -0400
In-Reply-To: <48DBF45F.7020601@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

On Thursday 25 September 2008, Kevin Hilman wrote:
> But I'm still not sure how to best deal with the possibiltity that th=
e=20
> pin might not always be a GPIO, but might be reconfigured/re-mux'd by=
=20
> this debobs interface as a debug observability pin.=20

Some platforms have interfaces to reserve and unreserve pins.
Normally used to ensure drivers can't do things like remux
address bus pins, but I suppose it could also be used for this
sort of thing too.


> My initial thought =20
> was to have the debobs interface gpio_request() the line if it was in=
=20
> observability mode so that nobody else could use it as a GPIO line, t=
hen=20
> gpio_free() it when it was put back into GPIO mode thus making it=20
> available to other users as a GPIO. =A0While that may work, it seems=20
> counter-intuitive and rather kludgy. =A0Not sure what the best way is=
=2E.

GPIOs are all that get managed with GPIO calls.

The pinmux calls use enums for pins, which could be used as
identifiers with some reservation scheme that copes with
other non-GPIO usages.

The worst case, design wise, is OMAP1 chips where many GPIOs
can come out on several pins ... and conversely, many pins
could be connected to any of several GPIOs (or MPUIOs).

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
