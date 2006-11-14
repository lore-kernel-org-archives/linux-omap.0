From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] plat-omap changes for 2430 SDP
Date: Tue, 14 Nov 2006 06:49:57 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01DFA69A@DLEE09.ent.ti.com>
References: <200611132244.01208.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200611132244.01208.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dave,

>> That's not in current linux-omap GIT.

Sorry, its TI internal tree.

>>The basic goal is to have the musb_hdrc driver bind to that platform
>>device, with its pins muxed appropriately, and able to talk propery
>>to the external transceiver.  The approach that's been taken so far is
>>to wrap the pin muxing, transceiver setup, and platform device setup
>>into one setup routine (in "devices.c"), and call that from the
various
>>board-specific setup routines.  That's a bit more complex than fits
well
>>into the simple "add to static device list" ... or at least it has
been
>>for other USB controllers (e.g. the integrated full speed ones).

Thanks, will try to align to the approach described. Later this week I
will probably send our code for a quick review.=20

Thanks & Regards,

Khasim

-----Original Message-----
From: David Brownell [mailto:david-b@pacbell.net]=20
Sent: Tuesday, November 14, 2006 12:44 AM
To: Syed Mohammed, Khasim
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: [PATCH] plat-omap changes for 2430 SDP

On Monday 13 November 2006 9:26 pm, Syed Mohammed, Khasim wrote:
> Hi Dave,
>=20
> At present in our tree, we have "musb_plat"=20
> (musb_hdrc_platform_data musb_plat) in our board_2430sdp.c.=20

That's not in current linux-omap GIT.


> It's treated like flash or smc91.x device and added as another 2430SDP
> device to "__initdata " list. Do you see any issues with this
approach?

Does it bind to the musb_hdrc driver?

The basic goal is to have the musb_hdrc driver bind to that platform
device, with its pins muxed appropriately, and able to talk propery
to the external transceiver.  The approach that's been taken so far is
to wrap the pin muxing, transceiver setup, and platform device setup
into one setup routine (in "devices.c"), and call that from the various
board-specific setup routines.  That's a bit more complex than fits well
into the simple "add to static device list" ... or at least it has been
for other USB controllers (e.g. the integrated full speed ones).

- Dave




> I think we need to discuss more on these sorts of placements.=20
>=20
> Thanks & Regards,
> Khasim
>=20
> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]=20
> Sent: Monday, November 13, 2006 8:47 PM
> To: linux-omap-open-source@linux.omap.com
> Cc: Syed Mohammed, Khasim
> Subject: Re: [PATCH] plat-omap changes for 2430 SDP
>=20
> Someone should also add an "musb_hdrc" platform device for
> the high speed OTG controller ... I figure that would basically
> live in mach-omap2/devices.c and be called from omap2430sdp_init().
> (I'm assuming that controller is accessible on the SDP...)
>=20
> - Dave
>=20
