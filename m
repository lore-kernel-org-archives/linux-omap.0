From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 04/25] i2c: move twl4030_keypad to new style
	registration
Date: Wed, 1 Oct 2008 01:30:21 +0300
Message-ID: <20080930223000.GR2445@frodo>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com> <1222800189-29737-4-git-send-email-me@felipebalbi.com> <1222800189-29737-5-git-send-email-me@felipebalbi.com> <200809301442.48086.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58180 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbYI3War (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 18:30:47 -0400
Content-Disposition: inline
In-Reply-To: <200809301442.48086.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Tue, Sep 30, 2008 at 02:42:47PM -0700, David Brownell wrote:
> On Tuesday 30 September 2008, Felipe Balbi wrote:
> > +struct twl4030_keypad_data {
> > +=A0=A0=A0=A0=A0=A0=A0int rows;
> > +=A0=A0=A0=A0=A0=A0=A0int cols;
> > +=A0=A0=A0=A0=A0=A0=A0int *keymap;
> > +=A0=A0=A0=A0=A0=A0=A0int irq;
> > +=A0=A0=A0=A0=A0=A0=A0unsigned int keymapsize;
> > +=A0=A0=A0=A0=A0=A0=A0unsigned int rep:1;
> > +};
>=20
> To fix later:  "irq" should be a standard platform resource.
>=20
> Those references in board init code to TWL4030_MODIRQ_KEYPAD
> should vanish, and add_children() should just pass the right
> number the standard way.

Cool, could you take a look at twl4030-bci changes ?? They request both
irqs, which seems ok, but then we won't be able to get rid of
TWL4030_MODIRQ_BCI.

If you can come up with an idea to change that, i'd be glad.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
