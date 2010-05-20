From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/4] fbdev: add a MIPI DSI header
Date: Thu, 20 May 2010 11:32:49 +0300
Message-ID: <1274344369.4246.28.camel@tubuntu.research.nokia.com>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
	 <Pine.LNX.4.64.1005071102440.4777@axis700.grange>
	 <1274255350.2307.159.camel@tubuntu.research.nokia.com>
	 <Pine.LNX.4.64.1005190955500.3099@axis700.grange>
	 <1274257308.2307.168.camel@tubuntu.research.nokia.com>
	 <Pine.LNX.4.64.1005200939030.26000@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005200939030.26000@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: ext Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-05-20 at 10:07 +0200, ext Guennadi Liakhovetski wrote:

> Yes, right, I should have said "they are related";) How about calling the 
> header mipi_display.h? This would then unite DSI, DCS, DBI and DPI? 
> Creating a separate header for each of these standards seems like an 
> overkill to me. We could then put MIPI CSI and CPI standards in an 
> include/media/mipi_camera.h. Not sure where to put various other MIPI 
> standards, I guess, we'll have to think about it as a need arises.

mipi_display.h sounds good to me.

> > Well, true, this is not a clear thing. MIPI DSI spec talks about "turn
> > on peripheral command". But the numbers are DSI data types, according to
> > the spec, and not all of them are commands.
> 
> Ok, how about "telegram types" then?

I wouldn't invent a new word for this =). The DSI spec talks about
commands, data types and transactions, I think we should pick one of
them.

Perhaps this is already approaching nitpicking, but:

As only some of the commands/datatypes/transactions are commands, I
think that's not proper word. All of them have a data type number, and I
guess they all are transactions. So "Turn On Peripheral Command" is a
transaction, and its data type is 0x32.

I guess if the enum is named, it should then be mipi_dsi_transaction.

But then, which one of these would be more correct:

dsi_send(enum mipi_dsi_transaction transaction)
dsi_send(u8 datatype)

As I said previously, I haven't seen any panel using custom datatypes,
but I wouldn't be surprised if some panel does. In that sense I would go
for using u8, and then perhaps leaving the enum unnamed.

What do you think?

> As others voted for unnamed enums, how about using them?

Sounds good.

> Concerning omap2 display drivers, AFAICS the only thing we want to change 
> there is to switch them too to using the common header and telegram type 

Yep, I think that's the only change for now.

> and command names? So far I don't see a need for a generic MIPI (display) 
> subsystem in the kernel with an own bus type, API etc. We could of course 
> create a simpe bus with callbacks for sending short and long packets and 
> reading data back, but do we really need it ATM?

This is something I've been thinking about for some time. I even made
some prototypes for it, but I didn't have time to go forward with it.

It would of course be nice to use the same panel driver on different
boards, so I think this is definitely something to think about in the
future.

 Tomi


