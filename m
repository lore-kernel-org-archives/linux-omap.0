From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Bug] v5.3-rc3: arm: omap5: omapdss: omap_fbdev_init fails with lpae config and reports dma_mask error
Date: Thu, 8 Aug 2019 11:57:56 +0200
Message-ID: <7B845956-A04D-40D8-A433-5812576A72E8@goldelico.com>
References: <14A6738F-75C6-4479-8B15-FD7395EFC55E@goldelico.com> <DF565339-14BC-411D-9301-5651FA601733@goldelico.com> <20190808072431.GA29852@lst.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808072431.GA29852@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi Christoph,

> Am 08.08.2019 um 09:24 schrieb Christoph Hellwig <hch@lst.de>:
>=20
> Hi Nikolaus,
>=20
> please try the patch below:
>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c =
b/drivers/gpu/drm/omapdrm/omap_fbdev.c
> index 561c4812545b..2c8abf07e617 100644
> --- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
> +++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
> @@ -232,6 +232,8 @@ void omap_fbdev_init(struct drm_device *dev)
> 	if (!priv->num_pipes)
> 		return;
>=20
> +	dma_coerce_mask_and_coherent(dev->dev, DMA_BIT_MASK(32));
> +
> 	fbdev =3D kzalloc(sizeof(*fbdev), GFP_KERNEL);
> 	if (!fbdev)
> 		goto fail;

Yes, it fixes the issue!

BR and thanks,
Nikolaus=
