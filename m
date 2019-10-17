From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH V5 2/3] dt-bindings: Add Logic PD Type 28 display panel
Date: Thu, 17 Oct 2019 09:42:25 -0500
Message-ID: <CAHCN7xJidCBmKL+BTWi_ZmiFyq-bjzzaJBYkQPyUBT+uKJVdaA@mail.gmail.com>
References: <20191016135147.7743-1-aford173@gmail.com> <20191016135147.7743-2-aford173@gmail.com>
 <20191016144018.GG5175@pendragon.ideasonboard.com> <CAHCN7xJhHHoia_o4rb0VgvCP71X94Pvem684F2quMijNNpNxVA@mail.gmail.com>
 <20191017143738.GA10960@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017143738.GA10960@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 17, 2019 at 9:37 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Oct 16, 2019 at 09:55:11AM -0500, Adam Ford wrote:
> > On Wed, Oct 16, 2019 at 9:40 AM Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > >
> > > Hi Adam,
> > >
> > > Thank you for the patch.
> > >
> > > On Wed, Oct 16, 2019 at 08:51:46AM -0500, Adam Ford wrote:
> > > > This patch adds documentation of device tree bindings for the WVGA panel
> > > > Logic PD Type 28 display.
> > > >
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > ---
> > > > V5:  Replace GPIO_ACTIVE_HIGH with 0 to fix make dt_binding_check -k
> > > > V4:  Update per Rob H's suggestions and copy other panel yaml example from 5.4-rc1
> > > > V3:  Correct build errors from 'make dt_binding_check'
> > > > V2:  Use YAML instead of TXT for binding
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
> > > > new file mode 100644
> > > > index 000000000000..2834287b8d88
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
> > > > @@ -0,0 +1,42 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/display/panel/logicpd,type28.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Logic PD Type 28 4.3" WQVGA TFT LCD panel
> > > > +
> > > > +maintainers:
> > > > +  - Adam Ford <aford173@gmail.com>
> > > > +
> > > > +allOf:
> > > > +  - $ref: panel-common.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: logicpd,type28
> > > > +
> > > > +  power-supply: true
> > > > +  enable-gpios: true
> > > > +  backlight: true
> > > > +  port: true
> > > > +
> > > > +required:
> > > > +  - compatible
> > >
> > > Should the port be required too ? Apart from that,
> >
> > I supposed that's true, but I used ampire,am-480272h3tmqw-t01h.yaml as
> > the example, and it doesn't list it as a required item.
> > Is there anything else I need to address?  I feel like I'm trying to
> > hit a moving target.
>
> 'port' can be omitted because the panel can be a child node of
> the display controller instead. That's decided by the display controller
> binding, not the panel binding.
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you.  Sorry it took a while to get there.

adam
>
> Rob
