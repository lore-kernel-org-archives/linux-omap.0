From: "Kamat, Nishant" <nskamat@ti.com>
Subject: RE: HS USB support for 2.6.14 V4 kernel
Date: Wed, 19 Sep 2007 10:43:30 -0500
Message-ID: <6E3DC4E6E09EF440B55B7AD683608D6D01E342CE@dlee13.ent.ti.com>
References: <c04186510709190826x7d5d5c0fwf934f52b30c0136@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c04186510709190826x7d5d5c0fwf934f52b30c0136@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: sandeep prabhu <sandeep.mitian@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Sandeep,

> -----Original Message-----
> From: sandeep prabhu
> Sent: Wednesday, September 19, 2007 10:27 AM
>=20
> Hello all,
>=20
> I am using 2.6.14 V4 kernel on 2430SDP board, trying to bring=20
> up the High Speed USB (Inventra core) on ISP1504 OTG.
> I could able to configure and detect the SDP board as=20
> ethernet Gadget device, but I could not use ISP1504 as USB-Host.
>=20
> I am using the following DIP switch settings:
>=20
> S6 - 2 ------> ON
> S6 - 6 ------> OFF
> S6 - 7 ------> OFF
>=20
> I am getting "musb_hdrc.0" interrupts when I plug an USB Hub,=20
> but  no interrupts are generated when I insert a device like=20
> mouse or memory stick.
>=20

If you are using the 2.6.14 kernel from linux.omap.com, you will need to =
issue the following command on the prompt in order to enumerate the =
device:
	echo S > /proc/drivers/musb_hdrc=20

This will start the host session. Otherwise the session (and VBUS) is =
kept off.

> Could anyone able to use ISP1504 as USB host ? is there any=20
> other kernel version where the High Speed USB on ISP1504 OTG=20
> is working ?

Yes, I think the latest kernel from git works.

Regards,
Nishant

>=20
> --
> Thanks in Advance,
> Sandeep
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
