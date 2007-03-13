From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: OMAP5912 OSK
Date: Tue, 13 Mar 2007 15:09:38 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08002B660A9@dbde01.ent.ti.com>
References: <bd205c5f0703130229o3e8f84f9m13b7d8e99ff7736@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <bd205c5f0703130229o3e8f84f9m13b7d8e99ff7736@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Wael Adel <showairovic@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


My understanding is that OMAP device as such does not have any specific
VID/PID. It is programmable. So you will have to program your gadget
driver to provide your VID/PID.

The host should have the corresponding CLASS driver for your gadget.

Vikram=20

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Wael Adel
> Sent: Tuesday, March 13, 2007 2:59 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: OMAP5912 OSK
>=20
> hi all,
> i want to use the usb of the kit OMAP5912 ,
> i want to make a usb gadget driver for it so:
>=20
> i have downloaded linux kernel 2.6.19 on it successffuly,
> and choose omap_udc.c to be a module,
> and zero.c also to be a module,(note that it would test the omap_udc)
> but unfortunalley,the vendor id and product id is for another chip
which
> is
> net2280.
>=20
> if u dont understand anything from what i say,just check $( kernel
source
> code )/drivers/usb/gadget to see two files:
> 1. omap_udc.c         2.zero.c
>=20
> and my problem is that i want to know the product id and the vendor id
for
> the usb port in the OMAP5912?
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
