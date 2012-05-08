From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Broken UART I/O wakeups on v3.4-rc4+
Date: Tue, 8 May 2012 10:10:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205081006480.9984@utopia.booyaka.com>
References: <alpine.DEB.2.00.1205072249090.9984@utopia.booyaka.com> <CAMrsUdL2ekriQfyM2QqK1h-Wv+r80sk38p8-NYnRJdd9x8UwCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-685390054-1336493370=:9984"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39221 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab2EHQKT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 12:10:19 -0400
In-Reply-To: <CAMrsUdL2ekriQfyM2QqK1h-Wv+r80sk38p8-NYnRJdd9x8UwCw@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1205081009570.9984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, khilman@ti.com, linux-omap@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-685390054-1336493370=:9984
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1205081009571.9984@utopia.booyaka.com>

On Tue, 8 May 2012, Raja, Govindraj wrote:

> On Tue, May 8, 2012 at 10:35 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> >
>
> The same is discussed in this thread as in here:=20
> http://www.spinics.net/lists/linux-omap/msg68659.html

OK.

> > Could you please fix this? =A0We probably aren't too far from the v3.5 =
merge
> > window opening, so there isn't much time to fix it.
>=20
> okay, one possible solution is to probe pins dynamically
> and make rx wakeup capable which myself and Tony
> discussed and came up with this patch [1]
>=20
> or to add rx wakeup pad support for each board,
> based on uart used as console.

Oh well, sounds like UART I/O wakeups are going to be broken in v3.4 :-(

Do you have a patch ready for Tony to queue for v3.5 to fix this?  From=20
the above thread, it looks like Tony had some remaining comments to be=20
addressed on your patch.


- Paul
--155748971-685390054-1336493370=:9984--
