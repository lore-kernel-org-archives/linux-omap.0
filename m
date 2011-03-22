From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH-v2.6.39] spi/omap_mcspi: Fix broken last word xfer
Date: Tue, 22 Mar 2011 12:06:35 +0530
Message-ID: <AANLkTikWeT_7fZYVDs78rc1yev-Djg2BLd7XpCum4Wgs@mail.gmail.com>
References: <1300717650-28953-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:41069 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751884Ab1CVGgh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Mar 2011 02:36:37 -0400
Received: by yxn22 with SMTP id 22so3731613yxn.20
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 23:36:35 -0700 (PDT)
In-Reply-To: <1300717650-28953-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Michael Jones <michael.jones@matrix-vision.de>

On Mon, Mar 21, 2011 at 7:57 PM, Jarkko Nikula <jhnikula@gmail.com> wro=
te:
> Commit adef658 "spi/omap_mcspi: catch xfers of non-multiple SPI word =
size"
> broke the transmission of last word in cases where access is multiple=
 of
> word size and word size is 16 or 32 bits.
>
> Fix this by replacing the test "c > (word_len>>3)" in do-while loops =
with
> "c >=3D 'pointer increment size'". This ensures that the last word is
> transmitted in above case and still allow to break the loop and preve=
nt
> variable c underflow in cases where word size !=3D 'pointer increment=
 size'.
>
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Michael Jones <michael.jones@matrix-vision.de>
> ---
> I noticed the issue with wl1251 WLAN driver on Nokia N900 using today=
's
> vanilla head a44f99c7efdb88fa41128065c9a9445c19894e34.
> ---
> =A0drivers/spi/omap2_mcspi.c | =A0 =A06 +++---
> =A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 3a5ed06..6f86ba0 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -517,7 +517,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, stru=
ct spi_transfer *xfer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_vd=
bg(&spi->dev, "read-%d %02x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0word_len, *(rx - 1));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (c > (word_len>>3));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (c);
> =A0 =A0 =A0 =A0} else if (word_len <=3D 16) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 *rx;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const u16 =A0 =A0 =A0 *tx;
> @@ -564,7 +564,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, stru=
ct spi_transfer *xfer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_vd=
bg(&spi->dev, "read-%d %04x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0word_len, *(rx - 1));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (c > (word_len>>3));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (c >=3D 2);
> =A0 =A0 =A0 =A0} else if (word_len <=3D 32) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 *rx;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const u32 =A0 =A0 =A0 *tx;
> @@ -611,7 +611,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, stru=
ct spi_transfer *xfer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_vd=
bg(&spi->dev, "read-%d %08x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0word_len, *(rx - 1));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (c > (word_len>>3));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (c >=3D 4);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* for TX_ONLY mode, be sure all words have shifted ou=
t */
> --
> 1.7.4.1

Latest mainline when booted on Omap4 was not booting up.
It crashes showing something like this:

[    2.581634] ks8851 spi1.0: (unregistered net_device): spi_sync() fai=
led
[    2.589843] ks8851 spi1.0: (unregistered net_device): spi_sync() fai=
led
[    2.597900] ks8851 spi1.0: (unregistered net_device): read: spi_sync=
() failed
[    2.605499] ks8851 spi1.0: failed to read device ID

The above patch when applied to the mainline solves the problem and the
kernel boots fine on Omap4.

Tested-by: Sourav Poddar<sourav.poddar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
