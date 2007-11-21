From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH-REWORKED] OMAP: MUSB: MUSB gadget fix
Date: Wed, 21 Nov 2007 17:53:55 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08003E80033@dbde01.ent.ti.com>
References: <5DF83221BE20114E9C331F665ACBC08003E7F771@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08003E7F771@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Vikram Pandita <vikram.pandita@ti.com>

REWORKED:=20
This fix gets MUSB Gadget Isochronous IN/OUT transfers working

1) Isochronous IN transfers working for File Storage Gadget
   TXCSR register write was wrongly erasing all bits
=09
2) Isochronous OUT transfers working for File Storage Gadget
   Minor fix:
   ./testusb -a -t15 -c1 -s512 -g8
   Testing with -g8 option will always case OVERFLOW condition which =
should not be a problem for ISO mode. So check for that condition and =
not report it as error in gadgetfs test application


Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

Index: linux-omap/drivers/usb/musb/musb_gadget.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/drivers/usb/musb/musb_gadget.c	2007-11-19 =
18:04:25.000000000 +0530
+++ linux-omap/drivers/usb/musb/musb_gadget.c	2007-11-21 =
16:15:50.000000000 +0530
@@ -111,7 +111,8 @@
 	req =3D to_musb_request(request);
=20
 	list_del(&request->list);
-	if (req->request.status =3D=3D -EINPROGRESS)
+	if (req->request.status =3D=3D -EINPROGRESS ||
+		(ep->type =3D=3D USB_ENDPOINT_XFER_ISOC && req->request.status =3D=3D =
-EOVERFLOW))
 		req->request.status =3D status;
 	musb =3D req->musb;
=20
@@ -499,9 +500,10 @@
=20
 					DBG(4, "sending zero pkt\n");
 					musb_writew(epio, MUSB_TXCSR,
-							MUSB_TXCSR_MODE
+							csr | MUSB_TXCSR_MODE
 							| MUSB_TXCSR_TXPKTRDY);
 					request->zero =3D 0;
+					break;
 				}
=20
 				/* ... or if not, then complete it */

---

>-----Original Message-----
>From: =
linux-omap-open-source-bounces+vikram.pandita=3Dti.com@linux.omap.com =
[mailto:linux-omap-open-
>source-bounces+vikram.pandita=3Dti.com@linux.omap.com] On Behalf Of =
Pandita, Vikram
>Sent: Monday, November 19, 2007 6:33 PM
>To: linux-omap-open-source@linux.omap.com
>Subject: [PATCH] OMAP: MUSB: MUSB gadget fix
>
>From: Vikram Pandita <vikram.pandita@ti.com>
>
>This fix gets MUSB Gadget Isochronous IN transfers working for File =
Storage Gadget
>
>Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>---
>
>Index: linux-omap/drivers/usb/musb/musb_gadget.c
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>--- linux-omap.orig/drivers/usb/musb/musb_gadget.c	2007-11-19 =
17:49:41.000000000 +0530
>+++ linux-omap/drivers/usb/musb/musb_gadget.c	2007-11-19 =
17:50:31.000000000 +0530
>@@ -499,7 +499,7 @@
>
> 					DBG(4, "sending zero pkt\n");
> 					musb_writew(epio, MUSB_TXCSR,
>-							MUSB_TXCSR_MODE
>+							csr | MUSB_TXCSR_MODE
> 							| MUSB_TXCSR_TXPKTRDY);
> 					request->zero =3D 0;
> 				}
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
