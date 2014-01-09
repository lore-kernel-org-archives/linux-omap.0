From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Date: Thu, 9 Jan 2014 10:21:46 +0200
Message-ID: <52CE5C1A.3070603@ti.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com>
 <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5712879579450663737=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
Cc: Tony Lindgren <tony@atomide.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============5712879579450663737==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="oGPgmg3OQno4QS60kBCq6gCNbMTPg8BfL"

--oGPgmg3OQno4QS60kBCq6gCNbMTPg8BfL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-09 07:06, Hiremath, Vaibhav wrote:

> I am seeing underflow issue on AM43x device if I use omapfb_vram argume=
nt.
> Did you see this on OMAP?
>=20
> I am using "omapfb_vram=3D10M@0xA0000000", and I believe it is correct =
way of usage.

Hmm ok... The AM4x seems to have issues anyway, as we're seeing
underflows easily in other situations also.

Well, there's a small difference in the allocation. The normal dma alloc
uses dma_alloc_attrs() and passes DMA_ATTR_WRITE_COMBINE as a flag,
whereas allocating from the absolute address just uses the piece of
memory. I couldn't find how to set write-combine for the abs memory area.=


Then again, that's for CPU caching, so I don't see why it would affect
DSS as such (but that's still something we should measure, cpu
read/write perf for normal and abs allocation).

The only thought I have is that somehow the reserved memory area is
missing some configuration that is done for the rest of the memory. But
that's purely a guess, this is totally out of my area of expertise...

Vaibhav, just to be sure, can you run both with normal dma_alloc and
with the reserve, and verify that the dispc register dumps are the same?
I don't see how they could be different, but just to be sure.

 Tomi



--oGPgmg3OQno4QS60kBCq6gCNbMTPg8BfL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzlweAAoJEPo9qoy8lh71j1YQAJ71toua5iWbpBW3l8SD/Xwu
Q0UX6cVcPpOCihYtVUWSWKQRCiSZ+gTMtrFumQNxvxDRt9Gywj4yTuOJBCuko9G9
hPeFlSFB3YusGDxcsSTaimfKQOmRwCbMM8SYk2ximM2lcuUg3CsQ2oyfMPIpdKct
unQ/2JVgO2o1axKNKNIwGdns8t3UqkBGgWcVyxgdliPBGAzqp8sUeX/5hq2Vx3/s
OLobVu+G3i2BaEV/3S4UNYVDA9g/HTXACtej8bW2z06YmqHVUU0H9g1Setiyo1TX
eH+1TDECnHJnAYNM2AtkJIN6zgC3UXyzrzcAuL8T/uIWoLvy/qMQAJbe5ijIcXKj
n7I5c1rtV7VRxSaUcdQ3UER4NSjb5AEw7xgCE7BJIWanxavJMpv1+VyorZdVIdNt
ymgwBT1Y2jc3DYqt/19o3cRCo0tOjG6w8esDvXBc7qPo9s9ao9qLeSIzPWPikA7o
n6V0V9Ii18HdOsg9iJmd//G2Boky52b+pffhcKp0frKqZ2F8fMvnI409M1Vmcslj
k0DRobamlya9PFa0ZNZpo2zfFbupt4w7zf0gb6GgWn26oYARQOm8abmPmS1manN3
8wpS6NIqhoIm7L3frFlFF9b+8ZjcvJns5EvgDX3zOf9ZsqoS0ClVoBNtq180CmU4
gM644Q+GPMWrq1MMQYVe
=u3mX
-----END PGP SIGNATURE-----

--oGPgmg3OQno4QS60kBCq6gCNbMTPg8BfL--


--===============5712879579450663737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5712879579450663737==--
