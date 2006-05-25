From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Question about USB mass storage on omap2420
Date: Thu, 25 May 2006 18:30:57 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A505E49D7F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kyungmin.park@samsung.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> What do you mean real disks?
>=20
> =3D> When attaching USB flash drive to windows, we can see the =
contents
of
> flash drivers. like this, apollon also has same behavior as removable
disk
> Now I only concern with the usb gadget, especialy "File-backed Storage
> Gadget"

I've seen this work here on my H4-2430 and SDP2430 using our older
kernels.

> At the 2.6.9 -> 2.6.10 level as can be found on the web I initially
did
> some amount of checking for usb-device only and usb-host only.  I
don't
> think the OTG was fully working with the public code.  Others have
touched
> that code since then so it might be working more, but I'm don't recall
it.
>=20
> =3D> Is there's some change? from 2.6.9 to 2.6.10?

There was some amount of sync'ing with later kernels (back porting of
some features and fixes).

If you have an H4 try the version from our website and see if it works
for you as is, several months back it surly did.  I've not tried the
latest git kernel to see if it works in this regard.  It wouldn't be
surprising if some aspect does is not correct.

Regards,
Richard W.
