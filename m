From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v2 1/2] omap3 nand: cleanup for not to use GPMC virtual
 address
Date: Mon, 17 May 2010 11:18:58 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D8FB825@dbde02.ent.ti.com>
References: <s-ghorai@ti.com>
 <1273850591-19040-1-git-send-email-s-ghorai@ti.com>
 <1273850591-19040-2-git-send-email-s-ghorai@ti.com>
 <20100514235852.GN3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53069 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753068Ab0EQFtS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 01:49:18 -0400
In-Reply-To: <20100514235852.GN3428@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "sakoman@gmail.com" <sakoman@gmail.com>, "mike@compulab.co.il" <mike@compulab.co.il>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>

Tony,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: 2010-05-15 05:29
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org;
> sakoman@gmail.com; mike@compulab.co.il; Artem.Bityutskiy@nokia.com
> Subject: Re: [PATCH v2 1/2] omap3 nand: cleanup for not to use GPMC
> virtual address
> 
> Few more comments below.
> 
> * Sukumar Ghorai <s-ghorai@ti.com> [100514 08:18]:
> > +
> > +/**
> > + * gmpc_ecc_init - Initialize the HW ECC for NAND flash in GPMC
> controller
> > + * @cs: Chip select number
> > + * @ecc_size: bytes for which ECC will be generated
> > + */
> > +void gpmc_ecc_init(int cs, int ecc_size)
> > +{
> > +	unsigned int val = 0x0;
> > +
> > +	/* Read from ECC Control Register */
> > +	val = gpmc_read_reg(GPMC_ECC_CONTROL);
> > +
> > +	/* Clear all ECC | Enable Reg1 */
> > +	val = ((0x00000001<<8) | 0x00000001);
> > +	gpmc_write_reg(GPMC_ECC_CONTROL, val);
> > +
> > +	/* Read from ECC Size Config Register */
> > +	val = gpmc_read_reg(GPMC_ECC_SIZE_CONFIG);
> > +	/* ECCSIZE1=512 | Select eccResultsize[0-3] */
> > +	val = ((((ecc_size >> 1) - 1) << 22) | (0x0000000F));
> > +	gpmc_write_reg(GPMC_ECC_SIZE_CONFIG, val);
> > +}
> 
> There should be some locking as only one chipselect can use
> the ECC or prefetch engine at a time. If you have NAND in
> two chipselects, bad things would happen..
> 
> Maybe something like:
> 
> int gpmc_ecc_request(int cs);
> void gpmc_ecc_free(int cs);
> int gpmc_prefetch_request(int cs);
> void gpmc_prefetch_free(int cs);
> 
> Other than that, looks like a good clean-up so we can easily
> add the platform init code for all the board files.
[Ghorai] agreed.. and -
1). Adding one flag/variable for prefetch enable/reset request
2). Adding another flag/variable for ecc int/reset request

Regards,
Ghorai

> 
> Regards,
> 
> Tony
