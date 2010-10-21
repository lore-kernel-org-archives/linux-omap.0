From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v2] OMAP: DSS2: Add NEC NL8048HL11-01B display panel
Date: Thu, 21 Oct 2010 17:00:36 +0300
Message-ID: <AANLkTimfQ78Y+fGXCTxPaLHR7xbYonjB2iODH1cOd8Oo@mail.gmail.com>
References: <1287663940-27327-1-git-send-email-samreen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45569 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758119Ab0JUOAh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 10:00:37 -0400
In-Reply-To: <1287663940-27327-1-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samreen <samreen@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Roger Quadros <roger.quadros@nokia.com>, Mukund Mittal <mmittal@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Erik Gilling <konkers@android.com>, Rajkumar N <rajkumar.nagarajan@ti.com>, Subbu Venkatesh <subramani.venkatesh@windriver.com>

On Thu, Oct 21, 2010 at 3:25 PM, Samreen <samreen@ti.com> wrote:
> From: Erik Gilling <konkers@android.com>
>
> NEC WVGA LCD NL8048HL11-01B panel support has been added.
> This panel is being used in zoom2/zoom3/3630 sdp boards.
>

<snip>

> diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c =
b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
> new file mode 100644
> index 0000000..0327731
> --- /dev/null
> +++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c

<snip>

> +static int spi_send(struct spi_device *spi, unsigned char reg_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned char reg_data)

you could be more consistent and name it nec_8048_spi_send.

> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 unsigned int cmd =3D 0, data =3D 0;
> +
> + =A0 =A0 =A0 cmd =3D 0x0000 | reg_addr; /* register address write */
> + =A0 =A0 =A0 data =3D 0x0100 | reg_data ; /* register data write */
> + =A0 =A0 =A0 data =3D (cmd << 16) | data;
> +
> + =A0 =A0 =A0 ret =3D spi_write(spi, (unsigned char *)&data, 4);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("error in spi_write %x\n", data)=
;
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +

one blank line is enough

> +static int init_nec_8048_wvga_lcd(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 /* Initialization Sequence */
> + =A0 =A0 =A0 /* spi_send(spi, REG, VAL) */
> + =A0 =A0 =A0 spi_send(spi, 3, 0x01);
> + =A0 =A0 =A0 spi_send(spi, 0, 0x00);
> + =A0 =A0 =A0 spi_send(spi, 1, 0x01); =A0 =A0/* R1 =3D 0x01 (normal),=
 0x03 (reversed) */
> + =A0 =A0 =A0 spi_send(spi, 4, 0x00);
> + =A0 =A0 =A0 spi_send(spi, 5, 0x14);
> + =A0 =A0 =A0 spi_send(spi, 6, 0x24);

This code wastes quite a bit of space (at least 3 mov and one bl
instruction for every such write on ARM), you could better do
something like:

static const struct {
  u8 address;
  u8 value;
} nec_8048_init_seq[] =3D {
  { 3, 0x01 },
  { 0, 0x00 },
  { 1, 0x01 },
  ...
};

static int init_nec_8048_wvga_lcd(struct spi_device *spi)
{
  int i, ret;
  for (i =3D 0; i < ARRAY_SIZE(nec_8048_init_seq); i++) {
    ret =3D nec_8048_spi_send(spi, nec_8048_init_seq[i].address,
nec_8048_init_seq[i].value);
    if (ret < 0)
      break;
  }
  udelay(20);
  nec_8048_spi_send(spi, 2, 0x00);
}


> +MODULE_DESCRIPTION("Nec Driver");

could use more complete description here.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
