From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 2/5] spi: spi-ti-qspi: add mmap mode read support
Date: Mon, 30 Nov 2015 16:35:46 -0600
Message-ID: <87lh9f15fh.fsf@saruman.tx.rr.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com> <1448860515-28336-3-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448860515-28336-3-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> writes:
> ti-qspi controller provides mmap port to read data from SPI flashes.
> mmap port is enabled in QSPI_SPI_SWITCH_REG. ctrl module register may
> also need to be accessed for some SoCs. The QSPI_SPI_SETUP_REGx needs to
> be populated with flash specific information like read opcode, read
> mode(quad, dual, normal), address width and dummy bytes. Once,
> controller is in mmap mode, the whole flash memory is available as a
> memory region at SoC specific address. This region can be accessed using
> normal memcpy() (or mem-to-mem dma copy). The ti-qspi controller hardware
> will internally communicate with SPI flash over SPI bus and get the
> requested data.
>
> Implement spi_flash_read() callback to support mmap read over SPI
> flash devices. With this, the read throughput increases from ~100kB/s to
> ~2.5 MB/s.
>
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>
>  drivers/spi/spi-ti-qspi.c | 101 ++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 94 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 64318fcfacf2..cd4e63f45e65 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -56,6 +56,7 @@ struct ti_qspi {
>  	u32 dc;
>=20=20
>  	bool ctrl_mod;
> +	bool mmap_enabled;
>  };
>=20=20
>  #define QSPI_PID			(0x0)
> @@ -65,11 +66,8 @@ struct ti_qspi {
>  #define QSPI_SPI_CMD_REG		(0x48)
>  #define QSPI_SPI_STATUS_REG		(0x4c)
>  #define QSPI_SPI_DATA_REG		(0x50)
> -#define QSPI_SPI_SETUP0_REG		(0x54)
> +#define QSPI_SPI_SETUP_REG(n)		((0x54 + 4 * n))
>  #define QSPI_SPI_SWITCH_REG		(0x64)
> -#define QSPI_SPI_SETUP1_REG		(0x58)
> -#define QSPI_SPI_SETUP2_REG		(0x5c)
> -#define QSPI_SPI_SETUP3_REG		(0x60)
>  #define QSPI_SPI_DATA_REG_1		(0x68)
>  #define QSPI_SPI_DATA_REG_2		(0x6c)
>  #define QSPI_SPI_DATA_REG_3		(0x70)
> @@ -109,6 +107,16 @@ struct ti_qspi {
>=20=20
>  #define QSPI_AUTOSUSPEND_TIMEOUT         2000
>=20=20
> +#define MEM_CS_EN(n)			((n + 1) << 8)
> +
> +#define MM_SWITCH			0x1
> +
> +#define QSPI_SETUP_RD_NORMAL		(0x0 << 12)
> +#define QSPI_SETUP_RD_DUAL		(0x1 << 12)
> +#define QSPI_SETUP_RD_QUAD		(0x3 << 12)
> +#define QSPI_SETUP_ADDR_SHIFT		8
> +#define QSPI_SETUP_DUMMY_SHIFT		10
> +
>  static inline unsigned long ti_qspi_read(struct ti_qspi *qspi,
>  		unsigned long reg)
>  {
> @@ -366,6 +374,78 @@ static int qspi_transfer_msg(struct ti_qspi *qspi, s=
truct spi_transfer *t)
>  	return 0;
>  }
>=20=20
> +static void ti_qspi_enable_memory_map(struct spi_device *spi)
> +{
> +	struct ti_qspi  *qspi =3D spi_master_get_devdata(spi->master);
> +	u32 val;
> +
> +	ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
> +	if (qspi->ctrl_mod) {
> +		val =3D readl(qspi->ctrl_base);
> +		val |=3D MEM_CS_EN(spi->chip_select);
> +		writel(val, qspi->ctrl_base);
> +		/* dummy readl to ensure bus sync */
> +		readl(qspi->ctrl_base);
> +	}
> +	qspi->mmap_enabled =3D true;
> +}
> +
> +static void ti_qspi_disable_memory_map(struct spi_device *spi)
> +{
> +	struct ti_qspi  *qspi =3D spi_master_get_devdata(spi->master);
> +	u32 val;
> +
> +	ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
> +	if (qspi->ctrl_mod) {
> +		val =3D readl(qspi->ctrl_base);
> +		val &=3D ~MEM_CS_EN(spi->chip_select);
> +		writel(val, qspi->ctrl_base);
> +	}
> +	qspi->mmap_enabled =3D false;
> +}
> +
> +static void ti_qspi_setup_mmap_read(struct spi_device *spi,
> +				    struct spi_flash_read_message *msg)
> +{
> +	struct ti_qspi  *qspi =3D spi_master_get_devdata(spi->master);
> +	u32 memval =3D msg->read_opcode;
> +
> +	switch (msg->data_nbits) {
> +	case SPI_NBITS_QUAD:
> +		memval |=3D QSPI_SETUP_RD_QUAD;
> +		break;
> +	case SPI_NBITS_DUAL:
> +		memval |=3D QSPI_SETUP_RD_DUAL;
> +		break;
> +	default:
> +		memval |=3D QSPI_SETUP_RD_NORMAL;
> +		break;
> +	}
> +	memval |=3D ((msg->addr_width - 1) << QSPI_SETUP_ADDR_SHIFT |
> +		   msg->dummy_bytes << QSPI_SETUP_DUMMY_SHIFT);
> +	ti_qspi_write(qspi, memval,
> +		      QSPI_SPI_SETUP_REG(spi->chip_select));
> +}
> +
> +static int ti_qspi_spi_flash_read(struct  spi_device *spi,
> +				  struct spi_flash_read_message *msg)
> +{
> +	struct ti_qspi *qspi =3D spi_master_get_devdata(spi->master);
> +	int ret =3D 0;
> +
> +	mutex_lock(&qspi->list_lock);
> +
> +	if (!qspi->mmap_enabled)
> +		ti_qspi_enable_memory_map(spi);
> +	ti_qspi_setup_mmap_read(spi, msg);
> +	memcpy_fromio(msg->buf, qspi->mmap_base + msg->from, msg->len);
> +	msg->retlen =3D msg->len;

the way I have always expected this to work was that spi controller
would setup the mmap region (using ranges?) and pass the base address to
the SPI NOR flash instead, so that could call standard
write[bwl]/read[bwl] functions.

I mean, when we're dealing with AXI, AHB, PCI, OCP, whatever we
completely ignore these details, why should SPI be different ? If it's
memory mapped, the SW view of the thing is a piece of memory and that
should be accessible with standard {read,write}[bwl]() calls.

I really think $subject is not a good way forward because it gives too
much responsibility to the SPI controller driver; note that this driver
is the one actually accessing the memory map region, instead of simply
setting it up and passing it along.

So the way I see it, the DTS should be like so:

qspi@XYZ {
         reg =3D <XYZ foo>;
         [...]
         ranges =3D <0 0 0x30000000 $size>;

         flash@0,0 {
                   compatible =3D "mp2580";
                   reg =3D <0 0 $flash_size>;
         };
};


if you have more than one device sitting on this SPI bus using different
chip selects, that's easy too, just change your ranges property:

qspi@XYZ {
         reg =3D <XYZ foo>;
         [...]
         ranges =3D <0 0 0x30000000 0x1000
                   1 0 0x30001000 0x1000
                   2 0 0x30002000 0x1000>;

         flash@0,0 {
                 [...]
         };

         flash@1,0 {
                   [...]
         };

         flash@2,0 {
                   [...]
	};
};

and so on. From ti-qspi perspective, you should just setup the memory
map and from mp25p80 you would check if your reg property pointed to an
address that looks like memory, then ioremap it and use tradicional
{read,write}[bwl]() accessors. Any reasons why that wasn't done the way
pointed out above ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXM9DAAoJEIaOsuA1yqREuPUP+gN7XxDmE+p77RQF5l5kBcJ6
lny5AzPGx/u59M+HeOyi0SnZ2MsZNrP5PQCjWQ8Y/0QLUjB5CalZUoGTImwygbVp
C9N34yfP/WlaVQQdFJ7ByN9VIRZBw7bnW5hxxINrVuzYU5eTzNWA9pnPrPR0dSff
TQz9YckaLvQM3FqBozlOEr6vJ3iWOL9lxp+mgPvLRR0atWl4umDZGbc/+023PfUu
nkgSunCevIp5kuOYPghNy+uYCO0SdKpf1WYn1TlD3LhU/geESunzikw+V2Bcfi9Y
ASSafUXCYIBljBQ2/cggllWsuRZH5piVCpLc+jT2pxvGe/sSaNCndJqH9YhLNmBy
6vL/ZPsms9E6f8TC+2pHf/DhH+/EY1yJ9ogp1LEj3cz4rdb4WcS+0qXaDb8tzBVh
iuYtwreG+b4y4l8kEMJ2wvgq/QTVl2bPQ618b7X85BT6TUTCbs7uL1orWjGk/aiq
TmPGOj4T2UUJpVdqemPMTBjC8XbrnHfeIENOAk6jgl1PyKXcQyMukrDdKTi+hxyv
kTqfBJDy2aQLnfnMnHcmb87ueIuE/ciOBHIA6Th4qjvC+F4JrVsh13GdA2EBCkwc
sU10a6vVtbEjpSamHpMJ829mCN1152UEZ9W1vIAXw+O99Io7Ug9IB509bQb++K4K
1qpqCbXpMk8xBTdqXZ8B
=Ia4h
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
