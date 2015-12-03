From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: Re: [PATCH v4 3/5] mtd: devices: m25p80: add support for mmap read
 request
Date: Thu, 3 Dec 2015 10:42:19 +0100
Message-ID: <56600E7B.8010208@atmel.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
 <1448860515-28336-4-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448860515-28336-4-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, hramrach@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>
List-Id: linux-omap@vger.kernel.org

Hi Vignesh,

Le 30/11/2015 06:15, Vignesh R a =E9crit :
> Certain spi controllers may provide accelerated interface to read fro=
m
> m25p80 type flash devices. This interface provides better read
> performance than regular SPI interface.
> Call spi_flash_read(), if supported, to make use of such interface.
>=20
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>=20
> v4:=20
>  * Use spi_flash_read_message struct to pass args.
>  * support passing of opcode/addr/data nbits.
>=20
>  drivers/mtd/devices/m25p80.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p8=
0.c
> index fe9ceb7b5405..00094a668c62 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -131,6 +131,26 @@ static int m25p80_read(struct spi_nor *nor, loff=
_t from, size_t len,
>  	/* convert the dummy cycles to the number of bytes */
>  	dummy /=3D 8;
> =20
> +	if (spi_flash_read_supported(spi)) {
> +		struct spi_flash_read_message msg;
> +		int ret;
> +
> +		msg.buf =3D buf;
> +		msg.from =3D from;
> +		msg.len =3D len;
> +		msg.read_opcode =3D nor->read_opcode;
> +		msg.addr_width =3D nor->addr_width;
> +		msg.dummy_bytes =3D dummy;
> +		/* TODO: Support other combinations */
> +		msg.opcode_nbits =3D SPI_NBITS_SINGLE;
> +		msg.addr_nbits =3D SPI_NBITS_SINGLE;
> +		msg.data_nbits =3D m25p80_rx_nbits(nor);

I wanted to let you know that the support of other SPI protocols has al=
ready
been implemented by this series:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/37=
1170.html

patches 2 & 3 handle the probing of the (Q)SPI memory in spi_nor_scan()=
 and
select the right protocols for register read/write, memory read, memory=
 write,
and memory erase operations. The choice is done according to both the m=
emory
and SPI controller capabilities.

patch 4 updates the m25p80 driver to take advantage of the bandwidth in=
crease
allowed by QSPI protocols. For instance, the Atmel QSPI controller, lik=
e TI
one, maps the SPI NOR memory to the system bus. Yesterday I ran mtd_spe=
edtest
to compare Fast Read 1-1-1 (0x0b) and Fast Read 1-1-4 (0x6b). The SPI c=
lock
frequency was limited to 83MHz. The QSPI memory is a Micron n25q128a13.

I only had to change the mode argument of spi_nor_scan() from SPI_NOR_Q=
UAD to
SPI_NOR_FAST in the atmel_quadspi driver (based on fsl-quadspi driver f=
rom
=46reescale since Atmel's driver also uses the system bus mapping for m=
emory
write operations) to force the spi-nor framework to choose the SPI 1-1-=
1
protocol instead of the SPI-1-1-4.

1 - Fast Read 1-1-1

mtd_speedtest: testing eraseblock write speed
mtd_speedtest: eraseblock read speed is 9319 KiB/s
[...]
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 6649 KiB/s
[...]
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 7757 KiB/s

2 - Fast Read 1-1-4

mtd_speedtest: testing eraseblock read speed
mtd_speedtest: eraseblock read speed is 30117 KiB/s
[...]
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 13096 KiB/s
[...]
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 18224 KiB/s

So the performance improvements are:
eraseblock read speed (65536 bytes) : +223%
page read speed (512 bytes)         :  +97%
2 page read speed (1024 bytes)      : +135%


That's why I believe that you could take advantage of these performance
improvements in the TI (Q)SPI controller driver.


Also please note that you may have to add in the struct spi_flash_read_=
message
two other fields for the number of option/mode cycles and their value.
Option/mode cycles are sent between the address and dummy cycles. They =
are
used by some memory manufacturers such as Spansion, Micron and Macronix=
 to
enter/leave their continuous read mode.
So if uninitialized dummy cycles are interpreted by the QSPI memory as
option/mode cycles, depending on the actual value, the memory may enter=
 by
mistake in continuous mode. Once in continuous mode, the command op cod=
e byte
must not be sent and is not expected by the memory: the memory implicit=
ly uses
the read op code sent in the SPI message which triggered the memory to =
enter
continuous read mode. Next SPI messages start from the address cycles u=
ntil
the right option/mode cycles are sent to leave the continuous read mode=
=2E

Currently the mtd layer doesn't use this feature but it should be aware=
 of it.
That's why I believe we'll have to address this point in spi_nor_scan()=
 and the
"regular" m25p80() sooner or later.

> +
> +		ret =3D spi_flash_read(spi, &msg);
> +		*retlen =3D msg.retlen;
> +		return ret;
> +	}
> +
>  	spi_message_init(&m);
>  	memset(t, 0, (sizeof t));
> =20
>=20

Best regards,

Cyrille
