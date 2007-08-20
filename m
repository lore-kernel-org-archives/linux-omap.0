From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clockautoidling
	viathe clock framework
Date: Mon, 20 Aug 2007 08:48:17 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901AD7CEC@dlee13.ent.ti.com>
References: <20070820095347.933473149@pwsan.com>
	<20070820095532.728389316@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD7C91@dlee13.ent.ti.com>
	<1187616613.7307.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <1187616613.7307.10.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> From: Igor Stoppa [mailto:igor.stoppa@nokia.com]
> On Mon, 2007-08-20 at 08:18 -0500, ext Woodruff, Richard wrote:
> > One further note is in the 'ideal' model you should never have to
> > control your I-CLK at all just your F-CLK.  I'm sure our hardware
people
> > would be very pleased if the code moved in that direction (me too if
it
> > turned out to all work).  They generally dislike the idea of the
clock
> > frame work as they feel it allows duplication of work the hardware
can
> > do if setup properly.  Its APIs open up some choices which can
nullify
> > or reduce understanding of hardware capabilities. For OMAP1 there
was no
> > other way.  For OMAP2/3 there are some options. I do very much like
the
> > frame work but do understand their points.
> >
> > Ideally, you set all idles at all levels and all async interrupt
wake
> > and use the PRCM interrupt to clear status at wake up time, then the
> > system can handle all clocks based on dependency.  Iclocks can be
> > managed automatically.  Fclocks should be dynamically controlled by
> > drivers on a demand basis.  This means some activity timers.
>=20
> I'm not new to these concepts, however I find extremely hard to accept
> the idea of using timers, since they assume to know what the duration
of
> the activity will be.

Activity timers on your FCLKS.  Many of the Fclks can be tied to input
activity and screen blanking.  The rest of the clocks are set to driver
activity.  For some drivers like MMC this isn't so bad as you talk to
the device.  The main issue with these is making the clock usage well
behaved.

The last set of drivers like UART (or Irda) are a bit more tricky as you
much make sure the protocol can send a 'wakeup' packet.  If the
peripheral and its firmware work to spec and all code is right there is
a chance.  There are just a lot of details.  Many of them can sort out
such that it can work.

> Could that work on an internet tablet?

You can still optimized for some big usecases which you know about.
Screen blanking type things.  MP3 is a favorite one to talk about.
Other things can only be as good as they can be.

One catch in some of these like low power refresh is you much recognize
when you are there and adjust some parameters (like FIFO).  Once you do
this you are at really good power.  This kind of activity timer is ok.
What is needed is some notion of cost around some of these
optimizations.  Latency API and some extension can help make the choice
for the few major cases it matters at.

> For the tablet there is not really a set of use-cases like on a phone,
> where you can have a closed set of fapplications and do some serious
> profiling.

You can't compete with a closed system for sure in optimizations.  But
because you can't be a 200uA all the time doesn't mean you should settle
for 200mA when you could be a 10mA.

Applying such control in fast moving open source is another level of
challenge.

> >  When this
> > does work the savings are really massive and dramatic.  The catch in
it
> > is that one dependency break from a bad driver (sw or hw) at any of
the
> > multiple levels will stop it from working.
>=20
> And how easy is it to trace that? All the refcounting seems to be done
> in HW ...

Not so easy.  This was one of the arguments of using a lower layer below
the clock frame work.  You can catch traces going in and out and send
them off to simulation.

Hitting the states has been prototyped and proven on HLOS's so it can
happen.  It is not just a completely static validation level test.

Regards,
Richard W.
