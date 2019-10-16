From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 2/3] dt-bindings: Add Logic PD Type 28 display panel
Date: Wed, 16 Oct 2019 08:15:21 -0500
Message-ID: <CAL_JsqJoPda6Oj14WTdm737Mydn+pzvdqkyCPry+zU7drheq=g@mail.gmail.com>
References: <20191001233923.16514-1-aford173@gmail.com> <20191001233923.16514-5-aford173@gmail.com>
 <20191009233130.GA1002@bogus> <CAHCN7xLCvN1v00H10KUX625awz+nea6rhA_LYnftspjaZ+od-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xLCvN1v00H10KUX625awz+nea6rhA_LYnftspjaZ+od-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 15, 2019 at 6:04 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Oct 9, 2019 at 6:31 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Oct 01, 2019 at 06:39:22PM -0500, Adam Ford wrote:
> > > This patch adds documentation of device tree bindings for the WVGA panel
> > > Logic PD Type 28 display.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > > V4:  Update per Rob H's suggestions and copy other panel yaml example from 5.4-rc1
> > > V3:  Correct build errors from 'make dt_binding_check'
> >
> > The example still fails to build here.
>
> I cannot replicate the build error on 5.4-RC3 at least for this
> binding on V4 of the patch.  I get build error on other bindings.
>
> $ make dt_binding_check ARCH=arm
> scripts/kconfig/conf  --syncconfig Kconfig
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
> /home/aford/src/linux/Documentation/devicetree/bindings/net/adi,adin.yaml:
> ignoring, error in schema 'adi,rx-internal-delay-ps'
> warning: no schema found in file:
> Documentation/devicetree/bindings/net/adi,adin.yaml
> /home/aford/src/linux/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml:
> ignoring, error in schema '0'
> warning: no schema found in file:
> Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
>   CHKDT   Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
>   ....
>   CHKDT   Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
>   CHKDT   Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.yaml
>   CHKDT   Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
>   CHKDT   Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
>  ...
>  CHKDT   Documentation/devicetree/bindings/media/allwinner,sun4i-a10-ir.yaml
>   CHKDT   Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml
> Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml:
> $id: path/filename 'arm/allwinner,sun4i-a10-csi.yaml' doesn't match
> actual filename
> Documentation/devicetree/bindings/Makefile:12: recipe for target
> 'Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.example.dts'
> failed
> make[1]: *** [Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.example.dts]
> Error 1
> Makefile:1263: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
>
> I took out some of the logs to make it less chatty.  I don't know
> anything about yaml or what the expectations are, so if there is a
> test beyond 'make dt_binding_check' please let me know.

Perhaps 'make -k' is needed because of the other failures. Or try on
top of linux-next which should all be fixed.

Rob
