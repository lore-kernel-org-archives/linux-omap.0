From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OneNAND: OMAP2: Switch to generic gpio calls
Date: Fri, 5 Dec 2008 10:14:49 -0800
Message-ID: <200812051014.50439.david-b@pacbell.net>
References: <1228289844-5897-1-git-send-email-jarkko.nikula@nokia.com> <1228289844-5897-3-git-send-email-jarkko.nikula@nokia.com> <49391D78.90407@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:36576 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752783AbYLESOx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 13:14:53 -0500
In-Reply-To: <49391D78.90407@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mtd Mailing List <linux-mtd@lists.infradead.org>, Jarkko Nikula <jarkko.nikula@nokia.com>

On Friday 05 December 2008, Adrian Hunter wrote:
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if ((r =3D omap_request=
_gpio(c->gpio_irq)) < 0) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if ((r =3D gpio_request=
(c->gpio_irq, "OneNAND irq")) < 0) {

Worth noting that this depends on the OMAP patches which=20
make those calls be equivalent.  Those patches are going
into 2.6.29-early via the ARM tree, as I recall; getting
the merge order wrong would break bisectability -- but
not buildability.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
