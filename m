From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update
Date: Mon, 15 Dec 2008 17:58:43 +0200
Message-ID: <1229356723.5895.348.camel@jani-desktop>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
	 <20081215134010.GA10709@mail.solidboot.com>
	 <1229352752.5895.325.camel@jani-desktop>
	 <20081215152920.GA11007@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27858 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbYLOP6f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 10:58:35 -0500
In-Reply-To: <20081215152920.GA11007@mail.solidboot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@solidboot.com>
Cc: linux-omap@vger.kernel.org

On Mon, 2008-12-15 at 17:29 +0200, ext Juha Yrj=C3=B6l=C3=A4 wrote:
> On Mon, Dec 15, 2008 at 04:52:32PM +0200, Jani Nikula wrote:
>=20
> > The switches themselves don't change (nor does this patch support
> > changing them), but different kinds of external devices may be conn=
ected
> > to the GPIO swiches. It would be useful to be able to change the
> > notification callbacks and debounce timeouts according to the devic=
e.
>=20
> Could you give an example use-case?=20

=46or example a jack that supports headsets with a button. The button
could function by simply grounding one of the lines (connected to a
GPIO, of course) or by generating some sort of an interrupt pulse. The
jack might support other kinds of accessories as well. And the required
actions and settling times might differ vastly.

> If the gpio-switch framework starts
> getting extended and used more, it might be sensible to convert it to
> the general GPIO API, as Trilok suggested.

I agree with this, but I'm afraid I don't have the time to extend the
scope of my work that much right now.


BR,
Jani.


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
