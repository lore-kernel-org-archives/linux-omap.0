From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [Letux-kernel] [PATCH v3 0/5] drm/panel-simple: Add panel
 parameters for ortustech-com37h3m05dtc/99dtc and sharp-lq070y3dg3b
Date: Wed, 17 Jul 2019 20:14:55 +0200
Message-ID: <20190717181455.GB6522@ravnborg.org>
References: <cover.1559905870.git.hns@goldelico.com>
 <0842FF88-D8E0-441B-837B-769C2EF6C1CB@goldelico.com>
 <20190625204356.GF18595@ravnborg.org>
 <20190626073350.GA15288@ravnborg.org>
 <CF1D9929-58D2-4E75-932A-870D11BBFBDE@goldelico.com>
 <33D92C0E-A430-4C34-A698-646F2592093D@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <33D92C0E-A430-4C34-A698-646F2592093D@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>, Belisko Marek <marek.belisko@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi Nikolaus.

> >>>> BTW: should also be applied to 5.2
> >>> The drm bits are reviewed. The DT bits needs OK from DT people.
> >>> When we have OK from DT people we can apply them all to drm-misc-next.
> >> 
> >> I got OK on irc from Rob to process these.
> >> All patches are now applied to drm-misc-next.
> > 
> > Thanks for taking care of this!
> 
> I have checked but it seems they are still not merged into linux-next.

They will appear in next merge window. They were to late to hit current
merge window, as the cut-of time is around .rc5 in the drm subsystem.
And this is not really a fix so not stable material.

	Sam
