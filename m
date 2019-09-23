From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: Add Logic PD Type 28 display panel
Date: Mon, 23 Sep 2019 08:31:18 -0500
Message-ID: <CAHCN7x+j9dsn8R202Y_rQUzO8g3SFatt8TzWUYsgADqCnTR=-Q@mail.gmail.com>
References: <20190917161214.2913-1-aford173@gmail.com> <20190917161214.2913-2-aford173@gmail.com>
 <20190921190708.GB32133@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190921190708.GB32133@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 21, 2019 at 2:07 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Adam.
>
> Good with even more panels.
> But for new bindings please use meta-schema (.yaml) format.
> This is what we use for new bindings as it allows better
> validation.

I don't know that syntax, but I'll try to piece together a few
different examples to come up with something.  I should have a V2
today.

adam
>
>         Sam
>
> On Tue, Sep 17, 2019 at 11:12:12AM -0500, Adam Ford wrote:
> > This patch adds documentation of device tree bindings for the WVGA panel
> > Logic PD Type 28 display.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/logicpd,type28.txt b/Documentation/devicetree/bindings/display/panel/logicpd,type28.txt
> > new file mode 100644
> > index 000000000000..829fc5210e06
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/logicpd,type28.txt
> > @@ -0,0 +1,26 @@
> > +Logic PD Type 28 4.3" WQVGA TFT LCD panel
> > +
> > +This binding is compatible with the simple-panel binding, which is specified
> > +in simple-panel.txt in this directory.
> > +
> > +Required properties:
> > +- compatible: should be "logicpd,type28"
> > +
> > +Optional properties:
> > +- power-supply: regulator to provide the supply voltage
> > +- enable-gpios: GPIO pin to enable or disable the panel
> > +- backlight: phandle of the backlight device attached to the panel
> Is it correct that these are optional for the descrivbed panel?
>
> > +
> > +Optional nodes:
> > +- Video port for RGB input.
> > +
> > +Example:
> > +     lcd0: display {
> > +             compatible = "logicpd,type28";
> > +             enable-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;
> > +             port {
> > +                     lcd_in: endpoint {
> > +                             remote-endpoint = <&dpi_out>;
> > +                     };
> > +             };
> > +     };
> > --
> > 2.17.1
