From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 1/2] ARM: omap2plus_defconfig: Update for removed items
Date: Wed, 11 Sep 2019 12:13:27 -0500
Message-ID: <CAHCN7xKin45Hqr1fgoOmbBKaM_hM_xnvrs2_5nnxAifHL2Sz0A@mail.gmail.com>
References: <20190911145226.21088-1-aford173@gmail.com> <20190911165021.qr5i37mpnua3fvw5@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190911165021.qr5i37mpnua3fvw5@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, arm-soc <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 11, 2019 at 11:50 AM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Wed, Sep 11, 2019 at 09:52:25AM -0500, Adam Ford wrote:
> > The omap panel-dpi driver was removed in
> > Commit 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")
> >
> > The tFP410 and DVI connector was remove in
> > Commit be3143d8b27f ("drm/omap: Remove TFP410 and DVI connector drivers")
> >
> > This patch removes these items from the omap2plus_defconfig.
>
> The omapdrm specific drivers have generic replacements, that
> should be added to the defconfig instead:
>
> DRM_OMAP_PANEL_DPI -> DRM_PANEL_SIMPLE
> DRM_OMAP_ENCODER_TFP410 -> DRM_TI_TFP410
>
> Nothing should be required for DRM_OMAP_CONNECTOR_DVI.

The DPI panel was already done.

https://patchwork.kernel.org/patch/11119569/

I'll submit a patch for the TFP410

adam
>
> -- Sebastian
>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > index c7bf9c493646..166b36be2ca6 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -349,12 +349,9 @@ CONFIG_OMAP5_DSS_HDMI=y
> >  CONFIG_OMAP2_DSS_SDI=y
> >  CONFIG_OMAP2_DSS_DSI=y
> >  CONFIG_DRM_OMAP_ENCODER_OPA362=m
> > -CONFIG_DRM_OMAP_ENCODER_TFP410=m
> >  CONFIG_DRM_OMAP_ENCODER_TPD12S015=m
> > -CONFIG_DRM_OMAP_CONNECTOR_DVI=m
> >  CONFIG_DRM_OMAP_CONNECTOR_HDMI=m
> >  CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV=m
> > -CONFIG_DRM_OMAP_PANEL_DPI=m
> >  CONFIG_DRM_OMAP_PANEL_DSI_CM=m
> >  CONFIG_DRM_OMAP_PANEL_SONY_ACX565AKM=m
> >  CONFIG_DRM_OMAP_PANEL_LGPHILIPS_LB035Q02=m
> > --
> > 2.17.1
> >
