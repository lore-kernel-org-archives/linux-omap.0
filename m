From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCHv2] drivers: mtd: spinand: Add generic spinand frameowrk.
Date: Thu, 04 Jul 2013 08:21:59 +0100
Message-ID: <1390226.n8Vjs1lthe@lenovo>
References: <1372851110-580-1-git-send-email-sourav.poddar@ti.com> <CAGVrzcbuK-xBeCVTsXhgEbX9CRqt8Dj7++ikoNZW8bY24Uz2Zg@mail.gmail.com> <51D4FD7F.3020104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51D4FD7F.3020104@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: artem.bityutskiy@linux.intel.com, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, manonuevo@micron.com, tqnguyen@micron.com, balbi@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello,

Le jeudi 4 juillet 2013 10:13:43 Sourav Poddar a =E9crit :
> >=20
> > Can this somehow be made a runtime thing?
>=20
> Ahh..I think we might opt for a device tree entry and based on that
> check for ECC.

Ok, sounds good too.

>=20
> > [snip]
> >=20
> >> +               if (count<  oob_num&&  ops->oobbuf&&  chip->oobbuf=
) {
> >> +                       int size;
> >> +                       int offset, len, temp;
> >> +
> >> +                       /* repack spare to oob */
> >> +                       memset(chip->oobbuf, 0,
> >> info->ecclayout->oobavail);
> >> +
> >> +                       temp =3D 0;
> >> +                       offset =3D info->ecclayout->oobfree[0].off=
set;
> >> +                       len =3D info->ecclayout->oobfree[0].length=
;
> >> +                       memcpy(chip->oobbuf + temp,
> >> +                               chip->buf + info->page_main_size +
> >> offset, len);>=20
> > Sounds like a for look might be useful here
>=20
> I dont think so, there is a while loop above under which it happens.
> We are increasing count at the bottom of the while loop. So, I think
> this should work fine.

What I meant here, is that you could use a for loop to repeat 4 times t=
he same=20
following pattern, such that it becomes:

for (j =3D 0; j < 4; j++0 {
	temp +=3D len;
	offset =3D info->ecclayout->oobfree[j].offset;
	len =3D info->ecclayout->oobfree[j].length;
	memcpy(chip->oobbuf + temp,
		chip->buf + info->page_main_size + offset, len);
}

Or even make it a helper function which is inlined if that is deemed mo=
re=20
elegant.
--=20
=46lorian
