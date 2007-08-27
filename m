From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: wake up from a serial port
Date: Mon, 27 Aug 2007 07:21:11 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901B8CFED@dlee13.ent.ti.com>
References: <57314e840708251538l188c6ab1m6c568716c95d4ed1@mail.gmail.com><20070827070626.GA30978@atomide.com><57314e840708270138y2c270362i54fd928538a80a87@mail.gmail.com>
	<20070827111405.GD13538@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070827111405.GD13538@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > > You also need to use the omap serial wake-up events, or mux rx pin
> > > temporarily to a wake-up capable GPIO pin.
> >
> > Are there any examples how to do either of these ?

This is necessary to get a wake up on the RX ball if you are in
retention. IE non-functional mode.  In effect it is a GPIO wake up not a
serial one.

If you want to wake up from UART from a functional mode, then having
that patch is fine, but you still need to do some work on the OMAP side
to link the module wake up into the PRCM wake up mechanism.

Then needs parallel what is necessary for the GPIO wake up.  The same
kind of thing can be said for USB.  If you want to go to a low power
state but have USB still able to respond to events, you need to make USB
bus suspend work so its capable of asserting its mstandby signal
properly and you must also do the linkage into the PRCM.

> Well it used to work at least for 5912OSK. Maybe grep for
> CONFIG_OMAP_SERIAL_WAKE.
>=20
> > If I mux the rx pin to a wake-up capable GPIO pin - should I still
apply
> the
> > patch I mentioned above ?

I doubt it would be necessary.  It really depends on what level you how
to sleep to and what functionally you need at wake up.

If its ok to loose the first character perhaps two and consider them
wake up events then going GPIO is likely fine.  You must think about how
its all connected.  You may need your DMA handsake lines set with
something similar.

> That means you still have to have the functional clock for the UART
> on, which will block omap retention. So using the async GPIO wake-up
> events will be better.
>=20
> > (And how can I do this muxing ? Is there an API for that ?>=20
> See CONFIG_OMAP_SERIAL_WAKE.
>=20
> > Thank you very much Tony.
>=20
> No problem, if you get it working on 2430, please send patches :)
>=20
> BTW, I never got the 2420 serial wake events to work, maybe they
> need separate interrupt handlers registered. But the GPIO trick
> should still work even if the serial wake-up events won't work.

These in 2420 can't wake core from RETETION.  They can wake the core
from  clockstop.

I'll throw rough numbers out for (chip) each domain has its own
combination.  Each lower state requires the previous state to be hit all
at 1.05v. clcokstop=3D~1.2mA, ~retention=3D150uA, off=3D~50uA.  Clock =
stop can
be higher depending on the 'partial' activity necessary, and perhaps
also lower.

Regards,
Richard W.
