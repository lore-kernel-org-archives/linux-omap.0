From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC][PATCH v2] OMAP: McBSP: Use register cache
Date: Thu, 26 Nov 2009 10:00:00 +0200
Message-ID: <20091126100000.add50e72.jhnikula@gmail.com>
References: <200908121239.26346.jkrzyszt@tis.icnet.pl>
	<20091123235355.GJ22923@atomide.com>
	<20091124095923.4f60044c.jhnikula@gmail.com>
	<200911241231.18333.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48770 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759185AbZKZH64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 02:58:56 -0500
Received: by bwz27 with SMTP id 27so333680bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 23:59:02 -0800 (PST)
In-Reply-To: <200911241231.18333.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

On Tue, 24 Nov 2009 12:31:16 +0100
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> -#define OMAP_MCBSP_READ(base, reg) \
> -			omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
> -#define OMAP_MCBSP_WRITE(base, reg, val) \
> -			omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
> +#define OMAP_MCBSP_READ(mcbsp, reg) \
> +		omap_mcbsp_read(mcbsp->io_base, OMAP_MCBSP_REG_##reg)
> +#define OMAP_MCBSP_WRITE(mcbsp, reg, val) \
> +		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, val)
> +
> +#define OMAP_MCBSP_CREAD(mcbsp, reg) \
> +		(mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1])
> +#define OMAP_MCBSP_CWRITE(mcbsp, reg, val) \
> +		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, \
> +		mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1] \
> +			= val)
> +

Have rather single write writing both the cache and actual register.
I.e. keep the OMAP_MCBSP_WRITE since writes should always go to hw and
makes the patch smaller. I also found the OMAP_MCBSP_CREAD a little
unclear so I suggest to name is as OMAP_MCBSP_READ_CACHE.

> +#define OMAP_MCBSP_BREAD(mcbsp, reg) \
> +		(mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1] \
> +			= OMAP_MCBSP_READ(mcbsp->io_base, reg))
>  
Why is this? There is nothing eating this :-)

>  	dev_dbg(mcbsp->dev, "DRR2:  0x%04x\n",
> -			OMAP_MCBSP_READ(mcbsp->io_base, DRR2));
> +			OMAP_MCBSP_READ(mcbsp, DRR2));

These changes are worth to send as a separate cleanup patch. Will make
the actual cache patch smaller and easier to follow.

> @@ -93,15 +104,15 @@ static irqreturn_t omap_mcbsp_tx_irq_han
>  	struct omap_mcbsp *mcbsp_tx = dev_id;
>  	u16 irqst_spcr2;
>  
> -	irqst_spcr2 = OMAP_MCBSP_READ(mcbsp_tx->io_base, SPCR2);
> +	irqst_spcr2 = OMAP_MCBSP_READ(mcbsp_tx, SPCR2);
>  	dev_dbg(mcbsp_tx->dev, "TX IRQ callback : 0x%x\n", irqst_spcr2);
>  
>  	if (irqst_spcr2 & XSYNC_ERR) {
>  		dev_err(mcbsp_tx->dev, "TX Frame Sync Error! : 0x%x\n",
>  			irqst_spcr2);
>  		/* Writing zero to XSYNC_ERR clears the IRQ */
> -		OMAP_MCBSP_WRITE(mcbsp_tx->io_base, SPCR2,
> -			irqst_spcr2 & ~(XSYNC_ERR));
> +		OMAP_MCBSP_CWRITE(mcbsp_tx, SPCR2,
> +			OMAP_MCBSP_CREAD(mcbsp_tx, SPCR2) & ~(XSYNC_ERR));

I was thinking that should these read+read_cache changes be a separate
patch for fixing the 1510 issues since no other OMAPs are known to
corrupt registers and plain hw read is enough for them.

> @@ -612,7 +612,6 @@ EXPORT_SYMBOL(omap_mcbsp_stop);
>  int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
>  {
>  	struct omap_mcbsp *mcbsp;
> -	void __iomem *base;
>  
>  	if (!omap_mcbsp_check_valid_id(id)) {
>  		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> @@ -620,28 +619,27 @@ int omap_mcbsp_pollwrite(unsigned int id
>  	}
>  
>  	mcbsp = id_to_mcbsp_ptr(id);
> -	base = mcbsp->io_base;
>  
> -	writew(buf, base + OMAP_MCBSP_REG_DXR1);
> +	OMAP_MCBSP_WRITE(mcbsp, DXR1, buf);
>  	/* if frame sync error - clear the error */
> -	if (readw(base + OMAP_MCBSP_REG_SPCR2) & XSYNC_ERR) {
> +	if (OMAP_MCBSP_READ(mcbsp, SPCR2) & XSYNC_ERR) {

These looks also that these are better to cover with its own separate
cleanup patch.

---

I'm not completely sure are there any code path expecting to read reset
default values from the cache or are there always explicit write or
read before it? I was thinking would it be necessary to initialize the
cache by issuing dummy reads for all registers. IRCC the OMAP2420 has
fewer registers than 2430 or OMAP3 so that should be took into account
if there is a need to do so.


-- 
Jarkko
