From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] USB: Generalize usb initialization for omap hw
Date: Thu, 24 Apr 2008 12:02:56 -0700
Message-ID: <200804241202.56650.david-b@pacbell.net>
References: <1209044786-9244-1-git-send-email-felipe.balbi@nokia.com> <200804241129.28213.david-b@pacbell.net> <20080424183240.GU23350@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:28856 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756211AbYDXTC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2008 15:02:59 -0400
In-Reply-To: <20080424183240.GU23350@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Tony Lindgren <tony@atomide.com>, "ext Gadiyar, Anand" <gadiyar@ti.com>, linux-omap@vger.kernel.org, "Syed Mohammed, Khasim" <khasim@ti.com>

On Thursday 24 April 2008, Felipe Balbi wrote:
>=20
> > > Sorry, I missed this post. I suggested separating out EHCI stuff =
to
> > > usb-ehci.c as they can be compiled in separately.
> >=20
> > Sounds right to me. =A0Dis-entangle that stuff.
>=20
> How about the header, introduce usb-musb.h and usb-ehci.h or usb.h is
> enough ??

Your call.



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
