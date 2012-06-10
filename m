From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: RFC: changing DMA slave configuration API
Date: Sun, 10 Jun 2012 12:22:18 +0100
Message-ID: <20120610112217.GD11404@n2100.arm.linux.org.uk>
References: <20120610102023.GC11404@n2100.arm.linux.org.uk> <CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55572 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755446Ab2FJLW1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 07:22:27 -0400
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Sun, Jun 10, 2012 at 07:19:47PM +0800, Barry Song wrote:
> 2012/6/10 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > Dan, Vinod,
> >
> > There's a change I would like to do to the DMA slave configuration.
> > It's currently a pain to have the source and destination parameters=
 in
> > the dma_slave_config structure as separate elements; it means when =
you
> > want to extract them, you end up with code in DMA engine drivers li=
ke:
> >
> > + =A0 =A0 =A0 if (dir =3D=3D DMA_DEV_TO_MEM) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_addr =3D c->src_addr;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_width =3D c->src_addr_width;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 burst =3D c->src_maxburst;
> > + =A0 =A0 =A0 } else if (dir =3D=3D DMA_MEM_TO_DEV) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_addr =3D c->dst_addr;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_width =3D c->dst_addr_width;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 burst =3D c->dst_maxburst;
> > + =A0 =A0 =A0 }
> >
> > If we redefine the structure as below, this all becomes more simple=
:
> >
> > + =A0 =A0 =A0 if (dir =3D=3D DMA_DEV_TO_MEM)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg =3D &c->dev_src;
> > + =A0 =A0 =A0 else if (dir =3D=3D DMA_MEM_TO_DEV)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg =3D &c->dev_dst;
>=20
> it seems that might mean an union in your dma_slave_cfg, but not
> co-exitense of both?

No, I want both so it's possible to select between the two when prepari=
ng
a DMA slave transfer.

> struct dma_slave_cfg {
> +       union {
>               struct dma_dev_cfg dev_src;
>               struct dma_dev_cfg dev_dst;
>        }
>        bool device_fc;
> };

If you do that, the union becomes pointless, and you might as well have=
:

struct dma_slave_cfg {
	struct dma_dev_cfg dev;
	bool device_fc;
};

instead.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
