From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] Adapt twl4030 power code to new twl4030 code
Date: Wed, 8 Oct 2008 00:22:20 -0700
Message-ID: <200810080022.21028.david-b@pacbell.net>
References: <1223390050-11499-1-git-send-email-peter.de-schrijver@nokia.com> <200810070919.55138.david-b@pacbell.net> <20081008064913.GA4542@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:45815 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751782AbYJHHWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 03:22:23 -0400
In-Reply-To: <20081008064913.GA4542@codecarver.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 07 October 2008, Peter 'p2' De Schrijver wrote:
> >=20
> > Your set of patches seems to have discarded support for quite
> > a few platforms. =A0I don't quite know the details of what these
> > PM scripts are doing ... could they be misbehaving on Beagle,
> > so that they explain why "reboot" on RC8 fails?
>=20
> It might. At least the warmreset script might cause problems on Beagl=
e.
> I'm not familiar enough with beagle to know for sure.

An RC3 kernel of mine reboots fine; RC7 and RC8 don't.  I'm
told other folk have seen the issue too.

The problem certainly doesn't kick in *before* the twl-power
code runs (as I happened to notice due to a bug), but I have
no particular reason to suspect that's an issue ... beyond it
having fingers in that reset process.

If the next version of your patches changes this behavior,
that might be some evidence.  ;)

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
