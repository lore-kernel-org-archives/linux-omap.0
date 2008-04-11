From: David Brownell <david-b@pacbell.net>
Subject: Re: [Help 1/2] MUSB: ZiO! CF card reader will trigger a change from MUSB host mode to MUSB peripheral mode
Date: Fri, 11 Apr 2008 09:13:50 -0700
Message-ID: <200804110913.51170.david-b@pacbell.net>
References: <386072610804070408q16c5ffa1u6a0c2e35295aa327@mail.gmail.com> <386072610804080006g588c7ad9ya4dd8c9c9c6cf827@mail.gmail.com> <386072610804100424l46273f0en9cc531dd7ec876ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:39483 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759521AbYDKQNx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Apr 2008 12:13:53 -0400
In-Reply-To: <386072610804100424l46273f0en9cc531dd7ec876ee@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: Felipe Balbi <me@felipebalbi.com>, tony@atomide.com, linux-omap@vger.kernel.org

On Thursday 10 April 2008, Bryan Wu wrote:
> > =A0And for our development board EZKIT548, it can provide 500mA cur=
rent
> > =A0at 5V as it claimed in manual
> > =A0with a external regular. So from my point of view, this bug is n=
ot
> > =A0related with 100mA current limit issue.

It's *supposed* to be able to provide that much ... steady
state.  But the issue here is current spikes that cause the
voltage to drop too low.

Did you stick a scope on that signal and *verify* that the
voltage never dropped below the valid level?


> These days I tried hard to workaround this issue, but failed:
>=20
> - When VBUS_ERR happens in OTG_A_HOST state and the OTG is in
> peripheral mode, I try to start a new session and power on VBUS.
> - CONNECT IRQ fired and OTG is switch back to host mode.

It needs to re-enumerate at this point, including USB reset.


> - In CONNECT IRQ handler, I rescan the musb->endpoint[i].in_qh or
> musb->endpoint[i].out_qh. Then resume the urb transfer which was
> stopped by the wrong VBUS_ERR mode switch IRQ. or just dequeue the ur=
b
> to call off the transfer.
> - But the ZiO does not reply anymore. No IRQ from USB hardware. World
> keeps silence.

That's compatible with the voltage actually dropping too low,
so that the peripheral AND host see the session as broken.

Sometimes it can help to put a powered hub in between the
musb host and the peripheral ...

- Dave




--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
