From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] arm: omap3: am35x: Add Davinci EMAC/MDIO hwmod
 support
Date: Wed, 27 Jun 2012 15:24:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206271520580.27496@utopia.booyaka.com>
References: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com> <1337105642-22711-2-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44249 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab2F0VYg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 17:24:36 -0400
In-Reply-To: <1337105642-22711-2-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi

one comment on this one

On Tue, 15 May 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Add hwmod support for the EMAC (and MDIO)
> ethernet controller that's on the am35x
> family of SoC's.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

> +static struct omap_hwmod_ocp_if am35xx_mdio__l3 = {
> +	.master		= &am35xx_mdio_hwmod,
> +	.slave		= &omap3xxx_l3_main_hwmod,
> +	.clk		= "emac_fck",
> +	.user		= OCP_USER_MPU,
> +};

...

> +/* l4_core -> davinci mdio  */
> +static struct omap_hwmod_ocp_if am35xx_l4_core__mdio = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &am35xx_mdio_hwmod,
> +	.clk		= "emac_fck",
> +	.addr		= am35xx_mdio_addrs,
> +	.user		= OCP_USER_MPU,
> +};

...

> +/* l4_core -> davinci emac  */
> +static struct omap_hwmod_ocp_if am35xx_l4_core__emac = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &am35xx_emac_hwmod,
> +	.clk		= "emac_ick",
> +	.addr		= am35xx_emac_addrs,
> +	.user		= OCP_USER_MPU,
> +};

As I understand it, these devices are actually directly connected to the 
IPSS.  However, for such a topology to work correctly, we'll probably need 
some changes in the hwmod core.  I had hoped to have this done for 3.6, 
but that's looking pretty unlikely.  So instead, will drop some comments 
in the data to note that this will need to be fixed.


- Paul
