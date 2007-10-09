From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] OMAP: Asynchronous clock disable
Date: Tue, 9 Oct 2007 17:17:42 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429022666FB@dlee13.ent.ti.com>
References: <20071005125028.GA32101@angel.research.nokia.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429021E0463@dlee13.ent.ti.com>
	<20071008035124.GA11220@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <20071008035124.GA11220@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> From: Tony Lindgren
> Sent: Sunday, October 07, 2007 10:51 PM
> > This might apply more to say power domains, but one point is, if the
> > display is on and the user is interacting the touch screen, it is
> > impossible to hit _chip_ OFF modes anyway.  This will only happen =
after
> > the screen has blanked.  Thus for some timers having them =
approximately
> > set to user input speeds might be ok.  Once these major events have
> > happened (screen blank and no input activity), it now becomes about
> > optimizing duty cycle of chip low power modes.  In this case shorter
> > timer outs are better as they are more impacting in that system =
mode.
> >
> > I'll try to look at actual code a bit more later on.
>=20
> Sounds like this could also allow the same performance as keeping =
clocks
> on all the time for some drivers.

Hopefully.

> We just have to take care not to use it too much with timers going off
> all the time :)

Yes.  Too many timers would kill dynamic tick.  However, the new timer =
coalescence APIs as presented at OLS2007 and probably lists might make =
that go away.  That or maybe just per clock domain.

An API change might not even be needed.  It could just activate timers =
based on some global setting.  Its not like today you depend on the =
clock really being off when you say clock_disable() (because of use =
count effects).

I did like better Yuha's clk_use/unuse which were potentially delayed =
and an always synchronous/force enable/disable.  No need for a flush.

Regards,
Richard W.
