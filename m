From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [RFC 01/21] ARM: OMAP: Clean-up OMAP GPIO request/free
 functions
Date: Thu, 30 Oct 2008 14:58:35 +0200
Message-ID: <20081030145835.5d1e6f08.jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
	<1225280189-6559-2-git-send-email-jarkko.nikula@nokia.com>
	<200810291049.50101.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53115 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbYJ3M7f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 08:59:35 -0400
In-Reply-To: <200810291049.50101.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Wed, 29 Oct 2008 10:49:49 -0700
"ext David Brownell" <david-b@pacbell.net> wrote:

> Looks OK to me, but I think there's a missing patch:
>=20
> On Wednesday 29 October 2008, Jarkko Nikula wrote:
> > +static inline int omap_request_gpio(int gpio)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0return gpio_request(gpio, "FIXME");
> > +}
> > +
> > +static inline void omap_free_gpio(int gpio)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0gpio_free(gpio);
> > +}
> > +
>=20
> At the end of this patch series, delete these.  :)
>=20
Probably these should exist over one release cycle so that out-kernel
tree projects have time to convert their drivers? No big deal to me,
but wanted to be kind :-)


Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
