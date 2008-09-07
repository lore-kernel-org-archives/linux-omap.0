From: David Brownell <david-b@pacbell.net>
Subject: Re: musb broken, was [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Sun, 7 Sep 2008 10:37:39 -0700
Message-ID: <200809071037.40094.david-b@pacbell.net>
References: <5e088bd90809061449l5b9d2d2dm1920301b70e6e5bf@mail.gmail.com> <200809062223.10845.david-b@pacbell.net> <yw1xsksc7zm1.fsf@thrashbarg.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:29240 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754023AbYIGRhm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2008 13:37:42 -0400
In-Reply-To: <yw1xsksc7zm1.fsf@thrashbarg.mansr.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: linux-omap@vger.kernel.org

On Sunday 07 September 2008, M=E5ns Rullg=E5rd wrote:
> I've also had to revert the "usb: musb: pass configuration specifics
> via pdata" commits:
>=20
>   ffd60d49c70b31d26430a1098edf0eef5e4dfac8 in linux-omap
>   ca6d1b1333bc2e61e37982de1f28d8604c232414 in mainline
>=20
> I suspect there are simply some tables missing for the Beagle board,
> but I haven't a clue what should go in them.

Odd, that's in the RC3 code and it works for me.

I did need some tweaks to improve fault recovery though,
one of which I've posted (but it's not yet been merged):

  http://marc.info/?l=3Dlinux-omap&m=3D122038390701430&w=3D2

Another patch is more diagnostic-oriented, and doesn't
change any behaviors.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
