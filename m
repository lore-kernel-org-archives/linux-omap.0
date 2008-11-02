From: David Brownell <david-b@pacbell.net>
Subject: Re: What happened to the serial console on BeagleBoard with 2.6.28-rc2?
Date: Sun, 2 Nov 2008 12:26:13 -0700
Message-ID: <200811021126.13514.david-b@pacbell.net>
References: <E1KwhIl-0001an-Ro@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:44258 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752220AbYKBT0Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Nov 2008 14:26:16 -0500
In-Reply-To: <E1KwhIl-0001an-Ro@amazonia.comcast.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rick@efn.org
Cc: linux-omap@vger.kernel.org, nmonson@gmail.com, felipe.contreras@gmail.com, tom.leiming@gmail.com

On Sunday 02 November 2008, Rick Bronson wrote:
> > Is that what you saw too?
>=20
> =A0 Yep, that's what I saw, but only if I had DEBUG_LL=3Dy. =A0Withou=
t that
> I had nothing except "Uncompressing Linux........". =A0

I don't have DEBUG_LL=3Dy ... if you had some kind of network
link configured over USB, could you SSH in?  (I can.)


> =A0 I guess we don't see this problem on the other 2 ports since they
> are mapped MT_MEMORY_SO and not MT_DEVICE (L4_34XX_PHYS).

Hmm, inconsistency is to be avoided.  :)

I wonder what the root cause is ... is the driver missing
various barriers needed to make MT_DEVICE work?  Or is the
MT_DEVICE incorrect in the first place?  "git whatchanged"
didn't show any recent changes that seemed (on a quick
glance) to affect I/O at that level.  Maybe it was one of
the other TTY changes interacting here.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
