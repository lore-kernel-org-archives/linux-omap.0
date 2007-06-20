From: "Sriram, Kannan" <ksriram@ti.com>
Subject: RE: Help regarding X-loader
Date: Wed, 20 Jun 2007 10:22:30 +0530
Message-ID: <0A50DBE80DD6674E94F7269DC964A7B6093E65@dbde01.ent.ti.com>
References: <c656a4d20706192149s47252c52q6e44d9701be1001c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20706192149s47252c52q6e44d9701be1001c@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: arun c <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Arun,

 You need the X-loader only in case of a NAND based system. For NOR
flash based systems, you don't need an X-loader.

 The X-loader is typically a "pre-boot" boot-loader, whose only job is
to perform basic platform setup (clock setup, pin-muxing, and memory
configuration), and load the u-boot from NAND flash -> external SDRAM.
This is because u-boot cannot do XIP on NAND based systems.

Regards,
Sriram.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of arun c
> Sent: Wednesday, June 20, 2007 1:50 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: Help regarding X-loader
>=20
> Hi all,
>=20
> I am a new guy stepping into the world of porting.
>=20
> My aim is to port linux to omap2430SDP with pop memory processor
board.
> I want to use U-boot as my bootloader.But i came to know that it
> requires one more
> thing called X-loader. I don't understand why it need X-loader. Does
> anybody here
> know the answer please help me. It will be very helpful if somebody is
> giving me
> a brief description about the working of x-loader.
>=20
>=20
> Thanks in advance
> Arun
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
