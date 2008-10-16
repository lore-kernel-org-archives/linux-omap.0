From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.27, some issues remain
Date: Thu, 16 Oct 2008 12:43:40 -0700
Message-ID: <200810161243.41079.david-b@pacbell.net>
References: <20081010120427.GZ3044@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:29998 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751255AbYJPTnn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Oct 2008 15:43:43 -0400
In-Reply-To: <20081010120427.GZ3044@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Friday 10 October 2008, Tony Lindgren wrote:
> Let's try to get the pending issues sorted out and then tag -omap1
> at the end of next week. So far it looks like we still have the follo=
wing
> issues remaining:
>=20
> - i2c transfers not working because of i2c-omap.c PM (These also make
> =A0 musb init fail at least on 3430sdp)

Resolved ...


> - 24xx/34xx write posting issue
>=20
> - 34xx spurious interrupts about 1/20 reboots

=2E.. I think I saw patches for at least the posting issue
get sent ...

=20
> Anything else not working right now?

The MUSB transceiver-level issues I was aware of (mostly
on Overo, but minor glitches on Beagle) now seem to be
fixed by the combination of the IRQ patches I sent last
week, plus the twl4030-usb patch I just sent.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
