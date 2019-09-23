From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: omap2plus_defconfig: Update for removed items
Date: Mon, 23 Sep 2019 11:30:55 -0700
Message-ID: <20190923183055.GC5610@atomide.com>
References: <20190911145226.21088-1-aford173@gmail.com>
 <20190911165021.qr5i37mpnua3fvw5@earth.universe>
 <CAHCN7xKin45Hqr1fgoOmbBKaM_hM_xnvrs2_5nnxAifHL2Sz0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xKin45Hqr1fgoOmbBKaM_hM_xnvrs2_5nnxAifHL2Sz0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, Russell King <linux@armlinux.org.uk>, arm-soc <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [190911 17:14]:
> On Wed, Sep 11, 2019 at 11:50 AM Sebastian Reichel <sre@kernel.org> wrote:
> >
> > Hi,
> >
> > On Wed, Sep 11, 2019 at 09:52:25AM -0500, Adam Ford wrote:
> > > The omap panel-dpi driver was removed in
> > > Commit 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")
> > >
> > > The tFP410 and DVI connector was remove in
> > > Commit be3143d8b27f ("drm/omap: Remove TFP410 and DVI connector drivers")
> > >
> > > This patch removes these items from the omap2plus_defconfig.
> >
> > The omapdrm specific drivers have generic replacements, that
> > should be added to the defconfig instead:
> >
> > DRM_OMAP_PANEL_DPI -> DRM_PANEL_SIMPLE
> > DRM_OMAP_ENCODER_TFP410 -> DRM_TI_TFP410
> >
> > Nothing should be required for DRM_OMAP_CONNECTOR_DVI.
> 
> The DPI panel was already done.
> 
> https://patchwork.kernel.org/patch/11119569/
> 
> I'll submit a patch for the TFP410

I picked that one into fixes, will apply the rest
of defconfig changes into omap-for-v5.5/defconfig.
Not planning on pushing it out until after -rc1
though.

Regards,

Tony
