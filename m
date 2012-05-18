From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: DSI: Support command mode interleaving during
 video mode blanking periods
Date: Fri, 18 May 2012 16:39:56 +0300
Message-ID: <1337348396.2607.19.camel@deskari>
References: <1337061738-32488-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-k07882ysNX4MfjII6a2q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:42688 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933714Ab2ERNj7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 09:39:59 -0400
Received: by lahj13 with SMTP id j13so1909378lah.25
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 06:39:56 -0700 (PDT)
In-Reply-To: <1337061738-32488-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-k07882ysNX4MfjII6a2q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2012-05-15 at 11:32 +0530, Archit Taneja wrote:
> DSI supports interleaving of command mode packets during the HSA, HFP, HB=
P and
> BLLP blanking intervals in a video mode stream. This is useful as a user =
may
> want to read or change the configuration of a panel without stopping the =
video
> stream.
>=20
> On OMAP DSI, we can queue HS or LP command mode packets in the TX FIFO, a=
nd
> the DSI HW takes care of interleaving this data during the one of the bla=
nking
> intervals. The DSI HW needs to be programmed with the maximum amount of d=
ata
> that can be interleaved in a particular blanking period. A blanking perio=
d
> cannot be used to send command mode data for it's complete duration, ther=
e is
> some amount of time required for the DSI data and clock lanes to transiti=
on
> to the desired LP or HS state.
>=20
> Based on the state of the lanes at the beginning and end of the blanking =
period,
> we have different scenarios, with each scenario having a different value =
of time
> required to transition to HS or LP. Refer to the section 'Interleaving Mo=
de' in
> OMAP TRM for more info on the scenarios and the equations to calculate th=
e time
> required for HS or LP transitions.
>=20
> We use the scenarios which takes the maximum time for HS or LP transition=
, this
> gives us the minimum amount of time that can be used to interleave comman=
d mode
> data. The amount of data that can be sent during this minimum time is cal=
culated
> for command mode packets both in LP and HS. These are written to the regi=
sters
> DSI_VM_TIMING4 to DSI_VM_TIMING6.
>=20
> The calculations don't take into account the time required of transmittin=
g BTA
> when doing a DSI read, or verifying if a DSI write went through correctly=
. Until
> these latencies aren't considered, the behaviour of DSI is unpredictable =
when
> a BTA is interleaved during a blanking period. Enhancement of these calcu=
lations
> is a TODO item.

The code in dsi_config_cmd_mode_interleaving() looks a bit long and
confusing, but I don't think it's trivial to simplify it. There's just
so many variables to consider.

In the future I think we should store the DSI configurations into
memory, so that we don't need to parse the hardware registers to find
out things like DSI timings.

I'll apply this, as it's very nice to have at least minimal interleaving
support.

 Tomi


--=-k07882ysNX4MfjII6a2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPtlEsAAoJEPo9qoy8lh7164AQALIyaDO2fbUE3bBhSmKc6YiO
UBXglrpE7FZRFr0TV4Ni4Sl1u5Eo3CjeKtnh662hp0nyJIZNnVYBsECk/JGjPzsH
AuWR+LIIUROsc91TEbZgJTXyH4qJ9KO4zw8o5os+kLZd0ocShsMPFUAMKlXGCEpf
pOTeWwIwRoXPpZEZjZH1CpMR1gC3KLx6J0JyJ6W0wk5j8+7MkaxCOljA/lX9/syM
BCuNDnQ2+vi7SPUhXkJ1si5dYoBNgPWlfD8Q8yNsENMFIiHQh7YwIKgNtYWHrK2E
/GSrP6WvnCEaPFQzR1e5FpOmqcjEIJTxE+tBpYXUHNC44G/P1ue5lXoREeee5Xe9
7dbcMe3rZHFZyE/Kd10H88Bpb5pueU/Oem/J/XyaTaH849jWZuXoiHgLY7GSJ2Fx
BZUDhEfjmYXAtbJrBfgUOsWXZ/9PLqVaYymOGXThInt4K/5yjORRmt+6GLeM0Whm
U/IxGGxCcjzKm/SmxSDri0fNyxpUhMB9jg3dL8fjBnSWSwyVpGtUatSGPBfQp5AV
7xMI2UGwLU9X6iRXvB9GFtvlIG9wE9MKUHeDQ04zc7g6JVbIp3BT+m2Q4XdfMCrg
OFSRWxDWksIo3uu/JgmkSEgfPcNd7Hs7yLxVNtbSvl/NHBuBEefdJkfKj8ORk9c/
Y/skrgEKKZlOMllduZLv
=/9mF
-----END PGP SIGNATURE-----

--=-k07882ysNX4MfjII6a2q--

