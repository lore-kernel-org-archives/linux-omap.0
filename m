From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Debobs and ETK padconf implementation
Date: Thu, 25 Sep 2008 10:04:12 -0700
Message-ID: <200809251004.12962.david-b@pacbell.net>
References: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com> <20080925115256.GD4654@codecarver.research.nokia.com> <87vdwkmmof.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:32844 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756087AbYIYREP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 13:04:15 -0400
In-Reply-To: <87vdwkmmof.fsf@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

On Thursday 25 September 2008, Kevin Hilman wrote:
>=20
> >> In that case, what is the proposed method for other kernel code to=
 use
> >> the debobs lines?
> >
> > Hmm, good point :) My idea was to use the gpiolib calls on GPIO12 -
> > GPIO29, but then there is no way for a user to know if the GPIO was
> > assigned to debobs or not... Maybe debobs should register as gpioli=
b
> > 'chip' and reexport those lines ? Would that make sense ?
>=20
> I think debobs should simply 'gpio_export' each pin. =A0It does not n=
eed
> to hold them.

Peter said the right abstraction here was pads (pins/balls?) not
GPIOs, so I'm not sure this is relevant any more, but ...

You can't gpio_export() to userspace, via sysfs, without having
first done a gpio_request().  And then later a gpio_free() will
release that export.  So that won't work.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
