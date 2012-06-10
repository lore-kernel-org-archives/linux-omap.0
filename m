From: Barry Song <21cnbao@gmail.com>
Subject: Re: RFC: changing DMA slave configuration API
Date: Sun, 10 Jun 2012 19:19:47 +0800
Message-ID: <CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com>
References: <20120610102023.GC11404@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40041 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab2FJLUI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 07:20:08 -0400
Received: by yhmm54 with SMTP id m54so2032199yhm.19
        for <linux-omap@vger.kernel.org>; Sun, 10 Jun 2012 04:20:07 -0700 (PDT)
In-Reply-To: <20120610102023.GC11404@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

2012/6/10 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> Dan, Vinod,
>
> There's a change I would like to do to the DMA slave configuration.
> It's currently a pain to have the source and destination parameters i=
n
> the dma_slave_config structure as separate elements; it means when yo=
u
> want to extract them, you end up with code in DMA engine drivers like=
:
>
> + =C2=A0 =C2=A0 =C2=A0 if (dir =3D=3D DMA_DEV_TO_MEM) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_addr =3D c->sr=
c_addr;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_width =3D c->s=
rc_addr_width;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst =3D c->src_m=
axburst;
> + =C2=A0 =C2=A0 =C2=A0 } else if (dir =3D=3D DMA_MEM_TO_DEV) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_addr =3D c->ds=
t_addr;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_width =3D c->d=
st_addr_width;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst =3D c->dst_m=
axburst;
> + =C2=A0 =C2=A0 =C2=A0 }
>
> If we redefine the structure as below, this all becomes more simple:
>
> + =C2=A0 =C2=A0 =C2=A0 if (dir =3D=3D DMA_DEV_TO_MEM)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg =3D &c->dev_sr=
c;
> + =C2=A0 =C2=A0 =C2=A0 else if (dir =3D=3D DMA_MEM_TO_DEV)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg =3D &c->dev_ds=
t;

it seems that might mean an union in your dma_slave_cfg, but not
co-exitense of both?

struct dma_slave_cfg {
+       union {
              struct dma_dev_cfg dev_src;
              struct dma_dev_cfg dev_dst;
       }
       bool device_fc;
};

>
> and then we can access the data through cfg->{element} rather than ha=
ving
> to cache each individual elements value in a local variable.
>
> Thoughts?
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 56377df..e6519f7 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -367,6 +367,18 @@ struct dma_slave_config {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool device_fc;
> =C2=A0};
>
> +struct dma_dev_cfg {
> + =C2=A0 =C2=A0 =C2=A0 dma_addr_t addr;
> + =C2=A0 =C2=A0 =C2=A0 enum dma_slave_buswidth width;
> + =C2=A0 =C2=A0 =C2=A0 u32 maxburst;
> +};
> +
> +struct dma_slave_cfg {
> + =C2=A0 =C2=A0 =C2=A0 struct dma_dev_cfg dev_src;
> + =C2=A0 =C2=A0 =C2=A0 struct dma_dev_cfg dev_dst;
> + =C2=A0 =C2=A0 =C2=A0 bool device_fc;
> +};
> +
> =C2=A0static inline const char *dma_chan_name(struct dma_chan *chan)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return dev_name(&chan->dev->device);
>
Thanks
barry
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
