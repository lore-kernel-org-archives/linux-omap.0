From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 5 Jun 2010 20:16:33 +0300
Message-ID: <AANLkTil4DLUciWMVmCiiygS2Y1vLZu0Lnfys-w4q3L7W@mail.gmail.com>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<1275149418.4503.128.camel@mulgrave.site>
	<1275156734.1645.496.camel@laptop>
	<201005312314.12391.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49310 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab0FERQf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Jun 2010 13:16:35 -0400
In-Reply-To: <201005312314.12391.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, tytso@mit.edu, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Tue, Jun 1, 2010 at 12:14 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Do you realistically think that by hurting the _user_ you will make t=
he
> _developer_ write better code? =C2=A0No, really.

As an application writer, if my users complain that their battery is
being drained (as it happened), they stop using it, and other people
see there are problems, so they stop using it, if people get angry
about it they will vote it down.

New users will see it has low score; they will not install it. That's
a network effect.

Having users is the quintessential reason people write code.

> If the user likes the app very much (or depends on it or whatever mak=
es him
> use it), he will rather switch the platform to one that allows him to=
 run that
> app without _visible_ problems than complain to the developer, becaus=
e _the_
> _user_ _doesn't_ _realize_ that the app is broken. =C2=A0From the use=
r's
> perspective, the platform that has problems with the app is broken, b=
ecause
> the app apparently runs without problems on concurrent platforms.

Yeah, right. I don't think anybody has every bought an iPhone because
of Tweetie. People care how the applications run on their phones, not
how their phone's platform runs their favorite application, in fact,
most probably it became their favorite application because it was
running great on their phone, and they wouldn't expect it to run on
phones with other platforms. Either applications run on S60, iPhone
OS, Android, or Maemo, but not in a combination of those. And if their
certain app that runs on multiple platforms, and the user actually
knows that (probably a geek), then he knows he can't expect it to work
exactly the same.

> The whole "no reason to tolerate broken apps" midset is simply misgui=
ded IMO,
> because it's based on unrealistic assumptions. =C2=A0That's because i=
n general users
> only need the platform for running apps they like (or need or whateve=
r). =C2=A0If
> they can't run apps they like on a given platform, or it is too painf=
ul to them
> to run their apps on it, they will rather switch to another platform =
than stop
> using the apps.

You seriously think people switch high-end phones just to run their
favorite apps? It's much cheaper to switch apps, and that's what users
do.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
