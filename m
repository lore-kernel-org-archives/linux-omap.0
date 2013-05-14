From: Illia Smyrnov <x0194613@ti.com>
Subject: Re: [PATCH] spi: spi-omap2-mcspi.c: Add dts for slave device configuration.
Date: Tue, 14 May 2013 12:53:31 +0300
Message-ID: <5192099B.4000203@ti.com>
References: <1364252415-3613-1-git-send-email-matthias.bgg@gmail.com> <CAB=otbTtRN9xyO0whNz-UbW+Xo0_X8XWLcWZt=7MfUfrnNqwww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAB=otbTtRN9xyO0whNz-UbW+Xo0_X8XWLcWZt=7MfUfrnNqwww@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Daniel Mack <zonque@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, ezequiel.garcia@free-electrons.com
List-Id: linux-omap@vger.kernel.org


> @@ -745,6 +781,11 @@ static int omap2_mcspi_setup_transfer(struct
> spi_device *spi,
>          mcspi = spi_master_get_devdata(spi->master);
>          spi_cntrl = mcspi->master;
>
> +       if (!cd && spi->dev.of_node) {
> +               cd = omap2_mcspi_get_slave_ctrldata(spi);
 > +               spi->controller_data = cd;

Here you call omap2_mcspi_get_slave_ctrldata function that allocate 
memory for cd structure, but this memory never freed.

Also, why do you read DT data in omap2_mcspi_setup_transfer function?
Under certain conditions the omap2_mcspi_setup_transfer function may be 
calling for each transfer and each call it will check (!cd && 
spi->dev.of_node) condition.

Consider to move DT data read code from omap2_mcspi_setup_transfer to
omap2_mcspi_setup function and free spi->controller_data pointer in 
omap2_mcspi_cleanup function.

