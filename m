From: Michael Welling <mwelling@ieee.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Tue, 21 Jul 2015 19:17:41 -0500
Message-ID: <20150722001741.GA7950@deathstar>
References: <201507111405.06048@pali>
 <201507132234.22082@pali>
 <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
 <20150720204647.GA11931@deathstar>
 <20150721093441.GA23241@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150721093441.GA23241@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 21, 2015 at 11:34:41AM +0200, Pavel Machek wrote:

This code has my head spinning.

I found that the errors do not occur when the driver is built into the kernel.

I also found that with the patch below the errors go away.

Not sure if it is acceptible but see if it fixes things on your side.


diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cf8b91b..3164d13 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1801,11 +1801,11 @@ int spi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		spi->max_speed_hz = spi->master->max_speed_hz;
 
-	spi_set_cs(spi, false);
-
 	if (spi->master->setup)
 		status = spi->master->setup(spi);
 
+	spi_set_cs(spi, false);
+
 	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
