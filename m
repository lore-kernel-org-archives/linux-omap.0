From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [irda-users] [PATCH] OMAP IrDA driver
Date: Mon, 22 Dec 2008 16:54:19 +0530
Message-ID: <5d5443650812220324m476614bfu3936e1c2cd682660@mail.gmail.com>
References: <5d5443650812042234y6301148at6658f4855500b105@mail.gmail.com>
	 <ea9ea93a42eaf41cd9ee3ff11ad1a026@localhost>
	 <5d5443650812050148n2b3fca72m272a1af33629c478@mail.gmail.com>
	 <20081205215344.GJ18379@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:49761 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbYLVLYU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Dec 2008 06:24:20 -0500
In-Reply-To: <20081205215344.GJ18379@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: samuel@sortiz.org, linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org

Hi Felipe,

Sorry for delayed reply.

>> +
>> +     void *rx_buf_dma_virt;          /* Virtual address of RX DMA buffer */
>> +     void *tx_buf_dma_virt;          /* Virtual address of TX DMA buffer */
>
> should these two be void __iomem * ?

Agreed.

>
>> +
>> +     struct device *dev;
>> +     struct omap_irda_config *pdata;
>> +};
>> +
>> +static inline void uart_reg_out(int idx, u8 val)
>> +{
>> +     omap_writeb(val, idx);
>
> __raw_writeb(), pass a reference to struct omap_irda here so you'd have
> access to a void __iomem *base (read below).

Agreed.

>> + */
>> +static void omap_irda_rx_dma_callback(int lch, u16 ch_status, void *data)
>> +{
>> +     struct net_device *dev = data;
>> +     struct omap_irda *omap_ir = netdev_priv(dev);
>> +
>> +     printk(KERN_ERR "RX Transfer error or very big frame\n");
>
> you have a device pointer in omap_ir, use it and convert these to
> dev_dbg() calls.

Agree.


>
>> +     if (omap_ir->pdata->transceiver_mode && machine_is_omap_h2()) {
>> +             /* Is it select_irda on H2 ? */
>> +             omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7,
>> +                                     FUNC_MUX_CTRL_A);
>
> __raw_writel/__raw_readl.

Agree.

>
>> +static int omap_irda_probe(struct platform_device *pdev)
>> +{
>> +     struct net_device *dev;
>> +     struct omap_irda *omap_ir;
>> +     struct omap_irda_config *pdata = pdev->dev.platform_data;
>> +     unsigned int baudrate_mask;
>> +     int err = 0;
>> +     int irq = NO_IRQ;
>
> you should probably have a struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> and use it to ioremap() the base address. Then you can stop using the
> omap_read[bsl]/omap_write[bsl] calls and switch over to standard
> __raw_read[bsl]/__raw_write[bsl] ones.
>

Right.

>> +
>> +     dev = alloc_irdadev(sizeof(struct omap_irda));
>> +     if (!dev)
>> +             goto err_mem_1;
>> +
>> +
>
> one blank line only.
>

Ok.

>> +
>> +     /* Any better way to avoid this? No. */
>> +     if (machine_is_omap_h3() || machine_is_omap_h4())
>> +             INIT_DELAYED_WORK(&omap_ir->pdata->gpio_expa, NULL);
>
> what does this mean ? what's that gpio_expa??

gpio_expa name here is misleading now. It is work name being scheduled
of sleeping gpio/i2c operations over pcf857x expander chip. No harm
otherwise.

>> +
>> +static int omap_irda_remove(struct platform_device *pdev)
>> +{
>> +     struct net_device *dev = platform_get_drvdata(pdev);
>> +
>> +     if (pdev) {
>> +             unregister_netdev(dev);
>> +             free_netdev(dev);
>> +     }
>
> pdev is always true here, remove this if().

Ok.

>> +
>> +static char __initdata banner[] = KERN_INFO "OMAP IrDA driver initializing\n";
>> +
>> +static int __init omap_irda_init(void)
>> +{
>> +     printk(banner);
>
> you can remove this banner. No need for it.

Ok.



-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
