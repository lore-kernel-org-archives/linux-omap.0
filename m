From: Christoph Hellwig <hch@lst.de>
Subject: Re: [Bug] v5.3-rc3: arm: omap5: omapdss: omap_fbdev_init fails
 with lpae config and reports dma_mask error
Date: Thu, 8 Aug 2019 09:24:31 +0200
Message-ID: <20190808072431.GA29852@lst.de>
References: <14A6738F-75C6-4479-8B15-FD7395EFC55E@goldelico.com> <DF565339-14BC-411D-9301-5651FA601733@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DF565339-14BC-411D-9301-5651FA601733@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, Christoph Hellwig <hch@lst.de>, Vignesh Raghavendra <vigneshr@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi Nikolaus,

please try the patch below:

diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index 561c4812545b..2c8abf07e617 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -232,6 +232,8 @@ void omap_fbdev_init(struct drm_device *dev)
 	if (!priv->num_pipes)
 		return;
 
+	dma_coerce_mask_and_coherent(dev->dev, DMA_BIT_MASK(32));
+
 	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
 	if (!fbdev)
 		goto fail;
