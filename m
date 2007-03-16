From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: omap_udc does not respond to SETUP transfer properly (OMAP5912)
Date: Fri, 16 Mar 2007 10:21:17 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08002B66C56@dbde01.ent.ti.com>
References: <45F993B1.9040008@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <45F993B1.9040008@css-design.us>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Steve Poulsen <spoulsen@css-design.us>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Have you tried the Interrupt mode of transfer.
In this mode you will be writing directly to the FIFO the response of
GET_DESCRIPTOR. Later you can debug the DMA path.


> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Steve Poulsen
> Sent: Friday, March 16, 2007 12:13 AM
> To: Linux-omap-open-source@linux.omap.com
> Subject: omap_udc does not respond to SETUP transfer properly
(OMAP5912)
>=20
> When I plug our device into a Windows PC, we receive the SETUP message
> (USB_REQ_GET_DESCRIPTOR).  The IRQ handler sets the EP_NUM values per
> Figure 16 of SPRU761A (EP_NUM.EPU_NUM =3D 0, EP_DIR =3D 1, EP_SEL =3D =
1,
> SETUP_SEL=3D0), then it writes the response into the fifo.  After
writing,
> FIFO_EN is set to 1, then EP_SEL to 0.  I then find it remains in this
> state forever (or at least until Windows decides the device is
> problematic and turns it off).
> I have looked at the STAT register at the start of the IRQ and it
shows
> the FIFO is empty (0x02).  After writing the STAT register shows
(0x04)
> as expected.  However, even waiting 500 ms after the write, the STAT
> still shows 0x04.
>=20
> I have confirmed the HHC and DC clocks are enabled by looking at
> SOFT_REQ_REG and MOD_CONF_CTRL_0.
>=20
> Shouldn't the STAT 0x04 bit go to zero eventually and it show the fifo
> empty once again?
>=20
>=20
> Thanks,
>=20
> Steve
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
