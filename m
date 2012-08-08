From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 08/17] OMAPDSS: DSI: Maintain own copy of timings in
 driver data
Date: Wed, 08 Aug 2012 09:15:08 +0300
Message-ID: <1344406508.17575.12.camel@lappyti>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	  <1343817088-29645-9-git-send-email-archit@ti.com>
	 <1344348462.7216.77.camel@lappyti> <5021FFDC.6080006@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-epbkvtOSibkEEycEgHNK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:39204 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757457Ab2HHGPR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 02:15:17 -0400
Received: by lahe6 with SMTP id e6so182990lah.10
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 23:15:14 -0700 (PDT)
In-Reply-To: <5021FFDC.6080006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com


--=-epbkvtOSibkEEycEgHNK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-08 at 11:27 +0530, Archit Taneja wrote:

> I am a bit unclear about resolution when it comes to command mode panels.

Right, it's a bit confusing. And I'm not 100% sure how to manage the
rotation.

> For command mode panels, we can perform rotation at the panel side. That=
=20
> is, the panel refreshes itself by fetching pixels from it's buffer in a=
=20
> rotated way. Is that right?

Yes. Well, actually I think the panel stores the pixels in rotated
manner when it receives them from OMAP, but it's practically the same.

One thing to realize is that this kind of rotation is a bit limited:
because there's only one buffer, OMAP will write pixels to the buffers
at the same time as the panel shows them. When rotating, this leads to
tearing.

If the panel has double buffer, that solves the problem, but I haven't
seen such panels. Another option is to update the panel in two parts,
like N9 does, but that's timing sensitive and a bit tricky.

> If the original resolution is 864x480, and we set rotation at panel side=
=20
> to make the rotation 480x864, the DISPC manager size should also be=20
> configured at 480x864 right?

Yep. When we use the panel rotation, from OMAP's point of view the panel
resolution has changed.

> We seem to be setting the manager timings only once when DSI is enabled.=
=20
> After that, setting rotation doesn't impact manager size.

Hmm, previously the mgr size was set before each update. I wonder if
that code has been dropped, probably because we removed the support for
partial updates at one point. Without partial updates, the size stays
the same, except obviously with rotation. I think I just forgot about
rotation at that time.

> I am asking this to understand if we need to keep resolution as a=20
> separate parameter than timings. That is, timings represents the initial=
=20
> width and height of the panel, and resolution represents the current=20
> width and height of the panel.

I'm not sure. I think that OMAP doesn't really need to know about the
initial resolution. It doesn't really matter from OMAP's point of view.

I think I originally kept timings and resolution separately, and the
idea was that timings represent the panel's timings, i.e. how it updates
the screen from its own memory. And resolution represents the usable
resolution, from OMAP's point of view.

While I haven't seen such a cmd mode panel, there could be a command
sent to the panel to configure its timings. For this we need real
timings, not the rotated resolution.

However, even in that case the DISPC doesn't need to know about those
timings, they would be handled by the panel driver (which could,
perhaps, reconfigure the DSI bus speed to match the new timings). So I
think that inside omapdss, we don't need separate timings and resolution
for DSI cmd mode panels.

 Tomi


--=-epbkvtOSibkEEycEgHNK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIgPsAAoJEPo9qoy8lh71EoMP/0KkOL8okCVp+iEhXuzvAboI
zun1WkTCp3zuK2WHzN0HPThgmXZnMA2edAkDxVtgiYoZpZmynBwV51PgDFCtwsl9
Nn5wE1sJR+rxHmqVH2DexK6GXz2fPN5qaIFLTo/mStfAtgRMKwoH5rc5pZ+cSreL
049Sjz/q/bBIuyRQweG5gqvYC32JIgAS7V+3wI8xirm4CtpQ8B7BkU/JR6bdbn7M
7WTmAzsClCO9azCPMo3E3CgUET3HfXEVtwslXn4lJf+Tsh5bOE7ELAUL/RmE6r9q
tkAUW7RePYrvY+UzAR+fcCNSlDHBTcCNIyL6JaLZ24NNzFN1WcwoQ6KmzxmRx6nc
bBbMRtJKFxFfyRaInH7Q7Rkl1CvYmXNYfOHHCaFBNPxcnXOsfx5CMwHk3Rxt7C7T
PrKql6dN3Czpt7dA5fUSKcSwzr9up8prJ8gfSG3KHssZfMDXvTgiz6IhzoqTDZM1
KiRj6KrxI7srkrEGvt1LM8fsbvJEzIAAL1NXFkZFYTLw5sjLS/tzYMjsHW6qBmdX
EYfrSyINVfdkOfKK/F/MPzWbACdLVzpPVSEVrFI737+M6oCtwMui7l5dcy89T+1O
wmfQ5SRit1LlEzGB2DM7Qk6vJyvLTfcRUl6yX5TbghT1q75obhIbWcyXLm7/1DBw
4T/BHM2ANJ8Ra+rbLzEm
=ct0T
-----END PGP SIGNATURE-----

--=-epbkvtOSibkEEycEgHNK--

