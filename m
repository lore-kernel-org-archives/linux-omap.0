From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v10 04/10] mtd: nand: omap: fix device scan:
 NAND_CMD_READID, NAND_CMD_RESET, CMD_CMD_PARAM use only x8 bus
Date: Wed, 23 Oct 2013 10:24:58 -0300
Message-ID: <20131023132457.GD2458@localhost>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
 <1382172254-12448-5-git-send-email-pekon@ti.com>
 <20131022201624.GL23337@ld-irv-0074.broadcom.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA29DB8@DBDE04.ent.ti.com>
 <5267690C.9080005@gmail.com>
 <20131023125516.GA2458@localhost>
 <20980858CB6D3A4BAE95CA194937D5E73EA2A0CB@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA2A0CB-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "Pawel.Moll-5wv7dgnIgG8@public.gmane.org" <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "jp.francois-JOfcSVQZ0GHQT0dZR+AlfA@public.gmane.org" <jp.francois-JOfcSVQZ0GHQT0dZR+AlfA@public.gmane.org>, "dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org" <ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dwmw2@i
List-Id: linux-omap@vger.kernel.org

Hi Gupta,

On Wed, Oct 23, 2013 at 01:15:20PM +0000, Gupta, Pekon wrote:
> Hi,
>=20
> > From: Ezequiel Garcia [mailto:ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org]
> [...]
> > FWIW, I have a Beaglebone with a 16-bit bus NAND attached to it.
> >=20
> > Coincidentally, yesterday I was doing some tests as I'm ramping up =
the
> > NAND and I found that weird double nand_scan_ident() call.
> > The whole thing looks buggy to me, so I'm happy to help, review, te=
st
> > and patches to take care of this.
> >=20
> Yes, thanks .. that would be of great help..=20
> And may be your experience of Atmel drivers would help me here..
>=20

It's not Atmel, but Marvell :-)

> *Correct, should not be double calls to nand_scan_ident()..*
> But there is a constrain in nand_base.c, that it does not allow ONFI
> page reading in x16 mode.. So how to overcome that..
>=20
> I see the similar implementation in your ATMEL driver, it does not us=
e
> NAND_BUSWIDTH_AUTO so how do you perform ONFI read
> for x16 devices ?
> drivers/mtd/nand/atmel_nand.c @@atmel_nand_probe()
> /* here you move to x16 mode based on your DT or platform data */
> 	if (host->board.bus_width_16)	/* 16-bit bus width */
> 		nand_chip->options |=3D NAND_BUSWIDTH_16;
> /* And then you call nand_scan_ident */
> /* first scan to find the device and get the page size */
> 	if (nand_scan_ident(mtd, 1, NULL)) {
> 		res =3D -ENXIO;
> 		goto err_scan_ident;
> 	}
>=20
> Wouldn't this fail, _unless_ your device is listed in nand_flash_id[]=
 ?
> because it would not be able to read ONFI params..=20
> Refer below commit..=20
> commit 0ce82b7f7b7373b16ecf7b5725e21e2975204500
> Author:     Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
> AuthorDate: 2013-01-16
>=20
>=20

Not my driver, but I'm taking a look at it now. Not sure if I'll get
into something here.

>=20
>=20
> > I'm using some TI SDK with some ancient v3.2.x (with no git history=
!),
> > but from this discussion it seems the issue is still present in
> > mainline.
> >=20
> Aah sorry, then you might have some problem here in rebasing the
> patches. But still if you can, thanks much ..
>=20

I'm currently trying mainline (just for this issue not for my product).
I just need some time to prepare the bootargs and write a DT node for
the NAND cape.

Again, not sure if I'll make some progress, but I'll give it a shot :-)
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
