From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] OMAP clock: implement clock rate/parent change
 notifiers
Date: Thu, 8 Dec 2011 12:26:12 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112081222240.6289@utopia.booyaka.com>
References: <20090325160759.31866.49722.stgit@localhost.localdomain> <87tz5hwks8.fsf@deeprootsystems.com> <CAMP44s0qzSoDJbvzVOHNDbROPPWQH328LYKXSoLav+49vv-z_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-194036678-1323372372=:6289"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33821 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab1LHT0N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 14:26:13 -0500
In-Reply-To: <CAMP44s0qzSoDJbvzVOHNDbROPPWQH328LYKXSoLav+49vv-z_g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-194036678-1323372372=:6289
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Felipe,

I'm really sorry about the long delay in responding,

On Sun, 14 Aug 2011, Felipe Contreras wrote:

> On Wed, Mar 25, 2009 at 7:54 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
> > Paul Walmsley <paul@pwsan.com> writes:
> >> This series allows core code and driver code to register for
> >> notification when a clock's rate or parent changes. =C2=A0This is curr=
ently
> >> used by driver code that must be notified whenever power management
> >> code (e.g., CPUFreq) causes system rate changes that affect the driver=
's
> >> clock.
> >
> > I will be re-basing the PM branch onto today's linux-omap HEAD which
> > is v2.6.29 based. =C2=A0As I do this, I'll be dropping all the previous
> > notifier patches and replacing them with this series.
>=20
> What happened to this series? I don't see it anywhere.

Unforunately It got postponed for a long time for a variety of reasons. =20
The good news is that it seems that others are starting to realize that=20
something like this is needed, so hopefully it will finally go in as=20
part of the common clock stuff.

Just out of curiosity: you are interested in them from the DSPBridge=20
perspective?  Or do you have another use-case in mind?

regards

- Paul
--155748971-194036678-1323372372=:6289--
