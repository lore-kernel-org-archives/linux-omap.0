From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 8/9] twl4030 uses gpiolib
Date: Fri, 26 Sep 2008 11:57:09 -0700
Message-ID: <200809261157.09485.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809261010.50409.david-b@pacbell.net> <20080926174745.GB9890@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:26300 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752400AbYIZS5L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Sep 2008 14:57:11 -0400
In-Reply-To: <20080926174745.GB9890@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Friday 26 September 2008, Felipe Balbi wrote:
>=20
> > Err, strike the "NYET-" for me. =A0Editing mistake, that
> > should have been removed before. =A0;)
>=20
> There were a few comments in the patch header that sugested me this
> patch wasn't finished yet :-)

This patch is done.  The other work will be done later.

=46or example, all the existing users of these APIs are
in the hsmmc init logic.  That's kind of in flux now
(at least semi-broken).  When it works again, several
parts will change.

Likewise there are dependencies on some gpiolib features
that aren't yet merged.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
