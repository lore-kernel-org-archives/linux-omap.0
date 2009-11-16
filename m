From: Gregoire Gentil <gregoire@gentil.com>
Subject: Re: [PATCH 00/19] OMAP: DSS2: Intro
Date: Sun, 15 Nov 2009 22:54:01 -0800
Message-ID: <1258354441.19798.10.camel@gregoire-laptop>
References: <1253793384-31158-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1254302501.23991.90.camel@tubuntu>
	 <94a0d4530910070157v2dd8062aheffc6345daff9e78@mail.gmail.com>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752184AbZKPGx7@vger.kernel.org>
In-Reply-To: <94a0d4530910070157v2dd8062aheffc6345daff9e78@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: tomi.valkeinen@nokia.com, ext Andrew Morton <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 2009-10-07 at 11:57 +0300, Felipe Contreras wrote:
> On Wed, Sep 30, 2009 at 12:21 PM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:
> > Hi,
> >
> > Andrew, do you have time to check out the DSS2 driver? Or suggestio=
ns
> > how should I proceed.
> >
> > I rebased DSS2 on top of today's linux-tree, and there were no
> > conflicts, so the posted patches should apply. But the rebased tree=
 is
> > also available in master branch at
> > git://gitorious.org/linux-omap-dss2/linux.git
>=20
> It's also worth noting that DSS2 is used basically on all linux-omap
> trees already, I've seen it working at least on N900 and beagleboard
> and it makes no sense to try to get some video output without it.
>=20
> P.S. I had to patch the beagleboard support from Tomi's
> 'master-before-squash'... it would be nice to get it upstream already
I second Felipe on this one. DSS2 is a very stable and an ideal video
driver for OMAP3. Hopefully, it will make upstream soon,

Gr=C3=A9goire
