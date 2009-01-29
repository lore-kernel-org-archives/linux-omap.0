From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [PATCH] OMAP3 McSPI:  Adds context save/restore
Date: Thu, 29 Jan 2009 21:06:05 +0200
Message-ID: <20090129190605.GA7792@localhost>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F535F346@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44889 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbZA2TLm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 14:11:42 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F535F346@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "V, Hemanth" <hemanthv@ti.com>

On Wed, Jan 28, 2009 at 10:11:29AM +0100, ext Nayak, Rajendra wrote:
> From: Hemanth V <hemanthv@ti.com>
> 
> This patch adds context save/restore feature to McSPI driver.
> This has been tested by instrumenting the driver code i.e by
> adding a McSPI softreset in omap2_mcspi_disable_clocks function.
> 
> This patch includes review comment fixes
> 
> Signed-off-by: Hemanth V <hemanthv@ti.com>
> 
> ---
>  drivers/spi/omap2_mcspi.c |   97 ++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 77 insertions(+), 20 deletions(-)
> 
> Index: linux-omap-2.6/drivers/spi/omap2_mcspi.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/spi/omap2_mcspi.c       2009-01-27 11:45:06.000000000 +0530
> +++ linux-omap-2.6/drivers/spi/omap2_mcspi.c    2009-01-27 11:53:16.000000000 +0530
>
> [...]
>
> +static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
> +{
> +       struct spi_master *spi_cntrl;
> +       spi_cntrl = mcspi->master;
> +
> +       /* McSPI: context restore */
> +       mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
> +                       omap2_mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl);
> +
> +       mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
> +                       omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig);
> +
> +       mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0,
> +                       omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0);

You have to restore this to the proper CHCONF register. And in the
current form you have to restore all of them.

> +
> +
> +       mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
> +                       omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
> +}
> +static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
> +{
> +       clk_disable(mcspi->ick);
> +       clk_disable(mcspi->fck);
> +}
> +
> [...]
>
> @@ -537,6 +593,8 @@
> 
>         mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
> 
> +       omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0 = l;

And here save it to a slot based on CS.

--Imre


