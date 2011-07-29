From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Fri, 29 Jul 2011 07:45:10 +0300
Message-ID: <20110729044508.GY9069@legolas.emea.dhcp.ti.com>
References: <1311138718-5072-1-git-send-email-vikram.pandita@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2KGcTUzwJ+J1jnia"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:46359 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751535Ab1G2EpO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 00:45:14 -0400
Content-Disposition: inline
In-Reply-To: <1311138718-5072-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, gadiyar@ti.com, linux-omap@vger.kernel.org, Moiz Sonasath <m-sonasath@ti.com>


--2KGcTUzwJ+J1jnia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 19, 2011 at 10:11:58PM -0700, Vikram Pandita wrote:
> From: Anand Gadiyar <gadiyar@ti.com>
>=20
> This patch enables the DMA mode1 RX support.
> This feature is enabled based on the short_not_ok flag passed from
> gadget drivers.
>=20
> This will result in a thruput performance gain of around
> 40% for USB mass-storage/mtp use cases.
>=20
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Tested-by: Vikram Pandita <vikram.pandita@ti.com>

applied this one, but I changed commit log and code comment a little
bit. Here's updated commit:

commit e9c281b174f188adb7950ea8f6a55ca07be69914
Author: Anand Gadiyar <gadiyar@ti.com>
Date:   Tue Jul 19 22:11:58 2011 -0700

    usb: musb: Enable DMA mode1 RX for transfers without short packets
   =20
    This patch enables DMA mode1 for the RX patch when we know
    there won't be any short packets. We check that by looking
    into the short_no_ok flag, if it's true we enable mode1, otherwise
    we use mode0 to transfer the data.
   =20
    This will result in a throughput performance gain of around
    40% for USB mass-storage/mtp use cases.
   =20
    [ balbi@ti.com : updated commit log and code comments slightly ]
   =20
    Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
    Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
    Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
    Tested-by: Vikram Pandita <vikram.pandita@ti.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index b67a062..d314f58 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -634,6 +634,7 @@ static void rxstate(struct musb *musb, struct musb_requ=
est *req)
 	u16			len;
 	u16			csr =3D musb_readw(epio, MUSB_RXCSR);
 	struct musb_hw_ep	*hw_ep =3D &musb->endpoints[epnum];
+	u8			use_mode_1;
=20
 	if (hw_ep->is_shared_fifo)
 		musb_ep =3D &hw_ep->ep_in;
@@ -683,6 +684,18 @@ static void rxstate(struct musb *musb, struct musb_req=
uest *req)
=20
 	if (csr & MUSB_RXCSR_RXPKTRDY) {
 		len =3D musb_readw(epio, MUSB_RXCOUNT);
+
+		/*
+		 * Enable Mode 1 on RX transfers only when short_not_ok flag
+		 * is set. Currently short_not_ok flag is set only from
+		 * file_storage and f_mass_storage drivers
+		 */
+
+		if (request->short_not_ok && len =3D=3D musb_ep->packet_sz)
+			use_mode_1 =3D 1;
+		else
+			use_mode_1 =3D 0;
+
 		if (request->actual < request->length) {
 #ifdef CONFIG_USB_INVENTRA_DMA
 			if (is_buffer_mapped(req)) {
@@ -714,37 +727,41 @@ static void rxstate(struct musb *musb, struct musb_re=
quest *req)
 	 * then becomes usable as a runtime "use mode 1" hint...
 	 */
=20
-				csr |=3D MUSB_RXCSR_DMAENAB;
-#ifdef USE_MODE1
-				csr |=3D MUSB_RXCSR_AUTOCLEAR;
-				/* csr |=3D MUSB_RXCSR_DMAMODE; */
-
-				/* this special sequence (enabling and then
-				 * disabling MUSB_RXCSR_DMAMODE) is required
-				 * to get DMAReq to activate
-				 */
-				musb_writew(epio, MUSB_RXCSR,
-					csr | MUSB_RXCSR_DMAMODE);
-#else
-				if (!musb_ep->hb_mult &&
-					musb_ep->hw_ep->rx_double_buffered)
+				/* Experimental: Mode1 works with mass storage use cases */
+				if (use_mode_1) {
 					csr |=3D MUSB_RXCSR_AUTOCLEAR;
-#endif
-				musb_writew(epio, MUSB_RXCSR, csr);
+					musb_writew(epio, MUSB_RXCSR, csr);
+					csr |=3D MUSB_RXCSR_DMAENAB;
+					musb_writew(epio, MUSB_RXCSR, csr);
+
+					/*
+					 * this special sequence (enabling and then
+					 * disabling MUSB_RXCSR_DMAMODE) is required
+					 * to get DMAReq to activate
+					 */
+					musb_writew(epio, MUSB_RXCSR,
+						csr | MUSB_RXCSR_DMAMODE);
+					musb_writew(epio, MUSB_RXCSR, csr);
+
+				} else {
+					if (!musb_ep->hb_mult &&
+						musb_ep->hw_ep->rx_double_buffered)
+						csr |=3D MUSB_RXCSR_AUTOCLEAR;
+					csr |=3D MUSB_RXCSR_DMAENAB;
+					musb_writew(epio, MUSB_RXCSR, csr);
+				}
=20
 				if (request->actual < request->length) {
 					int transfer_size =3D 0;
-#ifdef USE_MODE1
-					transfer_size =3D min(request->length - request->actual,
-							channel->max_len);
-#else
-					transfer_size =3D min(request->length - request->actual,
-							(unsigned)len);
-#endif
-					if (transfer_size <=3D musb_ep->packet_sz)
-						musb_ep->dma->desired_mode =3D 0;
-					else
+					if (use_mode_1) {
+						transfer_size =3D min(request->length - request->actual,
+								channel->max_len);
 						musb_ep->dma->desired_mode =3D 1;
+					} else {
+						transfer_size =3D min(request->length - request->actual,
+								(unsigned)len);
+						musb_ep->dma->desired_mode =3D 0;
+					}
=20
 					use_dma =3D c->channel_program(
 							channel,

--=20
balbi

--2KGcTUzwJ+J1jnia
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMjrUAAoJEAv8Txj19kN1ICgIAKkS6UPYovub9Mj8Af/5zMgt
EvQZ1HWmOOjI1rwR1A/JBSL3K7M/nyWKRlMp1NNeNEVANGr+Jr9fCnUowdblfLUz
rNIDVjQMNx8kR6Rrfuzy+9zADYskXXqJhSikd9bp1s2XzB+7yOS2r4ISOUFrUkqw
zpYbXoYfzcT5y26BgkVJJj8qFfdRO9hcvwVLQaylPunE+Od8ZGjcg7jOeGPlKj+1
YENstSVO3q/yMn3dYQYB2q+WOMCKXxWqrcN5GUw4X2VVGX5M7zZ6bq5SLii8vC+6
UnmJbSlCGld0MMxi9xFo8IgEvHCv8wKsDRo/7pJzL0/dkuLME7S3Z8C3JLWrl14=
=QkYZ
-----END PGP SIGNATURE-----

--2KGcTUzwJ+J1jnia--
