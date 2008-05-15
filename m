From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] CBUS: Make retu watchdog behave like a standard
	Linux watchdog
Date: Thu, 15 May 2008 14:46:41 -0700
Message-ID: <20080515214640.GV8928@atomide.com>
References: <1210638918-26644-1-git-send-email-tony@atomide.com> <1210638918-26644-2-git-send-email-tony@atomide.com> <1210638918-26644-3-git-send-email-tony@atomide.com> <1210638918-26644-4-git-send-email-tony@atomide.com> <1210639609.20589.13.camel@mort> <20080513011736.GH28999@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56472 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbYEOVql (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 17:46:41 -0400
Content-Disposition: inline
In-Reply-To: <20080513011736.GH28999@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080512 18:17]:
> * Igor Stoppa <igor.stoppa@nokia.com> [080512 17:56]:
> > Hi Tony,
> > On Mon, 2008-05-12 at 17:35 -0700, ext Tony Lindgren wrote:
> > > Make retu watchdog behave like a standard Linux watchdog.
> > >=20
> > > Let the kernel do the kicking until the watchdog device is opened=
=2E
> >=20
> > This is not always the desidered behavior: the powerdown wd is used=
 to
> > ensure that the whole sw stack is healty: doing the kicking in
> > kernelspace for free introduces the case where userspace can get st=
uck
> > and the device does not powerdown.
>=20
> That's why there's CONFIG_WATCHDOG_NOWAYOUT where the ping timer is
> not enabled at all, and the watchdog is just set to max until userspa=
ce
> watchdog software kicking starts.
>=20
> > Also the unconditional loading of the maximum value during probe is=
 not
> > aligned with the original reset logic, which was to have the powerd=
own
> > wd to allow for 2 boot attempts:
> >=20
> > -cold boot -> load max value in retu wd (63s)
> >            -> load 30s in omap wd
> > -try to kick both wds
>=20
> Well you can set those values via /dev/watchdog too, right?
> And then use CONFIG_WATCHDOG_NOWAYOUT.
>=20
> And ff CONFIG_WATCHDOG_NOWAYOUT is not set, the kernel ping timer onl=
y
> happens when /dev/watchdog is not open.
>=20
> > if fail, then omap reboots, but retu keeps counting down
> >=20
> > -warm boot -> let the retu wd untouched=EF=BB=BF
> >            -> load 30s in omap wd=EF=BB=BF
> > -try to kick both wds
> >=20
> > if fail, retu powers down
> >=20
> > That was the original idea in 770 times and i still like it.
> >=20
> > To conclude, i'd see inkernel kicking more as a debugging feature w=
hile
> > one is hacking at the kernel than a desirable quality of a stable
> > kernel.
>=20
> Considering that the /dev/watchdog interface is the standard, I see t=
his
> patch as the only way we can get this code ever merged upstream. And =
it's
> easy to patch back the non-standard if you want to.

I'll push the first two patches today, third one still needs to be
checked.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
