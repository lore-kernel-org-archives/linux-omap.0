From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [try#1 PATCH 5/7] omap4: panda: add smsc95xx regulator and reset
 dependent on root hub
Date: Fri, 30 Nov 2012 11:35:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211301031540.1362-100000@iolanthe.rowland.org>
References: <50B8627B.20102@warmcat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43457 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758637Ab2K3QfK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Nov 2012 11:35:10 -0500
In-Reply-To: <50B8627B.20102@warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?= <andy@warmcat.com>
Cc: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, keshava_mgowda@ti.com, balbi@ti.com

On Fri, 30 Nov 2012, "Andy Green (=E6=9E=97=E5=AE=89=E5=BB=B8)" wrote:

> I have everything discussed above ready for a try#2, including the=20
> descendant matching stuff in separate patches.  The code got a lot=20
> smaller and better with the _ops struct.
>=20
> The new code can attach the assets to the targeted hub port as discus=
sed=20
> (using only "-0:1.0/port1" and only checking ehci-omap.0 descendants =
at=20
> device_add() time), but the hub port device never probes, unless I=20
> missed the point it's because it actually never binds to a driver, it=
's=20
> a very unusual standalone logical device.

That's right; it gets registered but it never binds.  It doesn't need a=
=20
driver because all the port-related activity is done by the hub driver.=
 =20

> If that's the case I could work around that by doing the probe() asse=
t=20
> stuff at device_add() time if there's no driver name on the device, b=
ut=20
> actually I am not sure that's where we wanted to end up.
>=20
> Now we got so far as to succeed to associate regulator + clock assets=
 to=20
> the logical hub port device, isn't it that we want the assets to be=20
> enabled and disabled according to hub port power state?  In that case=
 it=20
> needs to go in the direction of calling device_asset helpers in the=20
> hub.c code that handles enable and disable hub port power.  Is this=20
> sounding like the right way, or something else?

I'm not so sure about this.  Maybe we're trying to solve too many
different kinds of problem at once.

The original device asset scheme is fine if all you want to do is turn
on the regulator when ehci-omap binds and turn it off when the driver
unbinds.  But if we want to go farther, maybe the device asset approach
isn't the right way.

In particular, we would like the regulator to get turned off and on by=20
the port driver as part of its suspend/resume handling.  The most=20
straightforward way to do this is to modify the PM code in port.c.

This would be specific to USB ports.  I toyed around with the idea of a
more general-purpose approach using "PM assets" that could hook into
various PM callbacks, but it seemed to get too complicated.  And
besides, it only ended up looking like a way to put something into a PM
domain without the driver's knowledge.

So maybe something like Ming Lei's suggestion really would be best. =20
We could add code specifically for regulators and clocks to port.c.

Trying to write something that can work for all types of devices, not=20
just USB ports, may be over-reaching.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
