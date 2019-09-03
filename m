From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv3 01/10] dt-bindings: omap: add new binding for PRM
 instances
Date: Tue, 3 Sep 2019 09:10:42 +0100
Message-ID: <CAL_Jsq+AJj1bgOQYG=c86A5HC_g2UZph387oVEKZyP4M18kURw@mail.gmail.com>
References: <20190830121816.30034-1-t-kristo@ti.com>
 <20190830121816.30034-2-t-kristo@ti.com>
 <20190902042631.GA22055@bogus> <e8d700cd-8f3c-5cea-a022-b20a595fc1e1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e8d700cd-8f3c-5cea-a022-b20a595fc1e1@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Philipp Zabel <p.zabel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 3, 2019 at 8:26 AM Tero Kristo <t-kristo@ti.com> wrote:
>
> On 02/09/2019 16:39, Rob Herring wrote:
> > On Fri, Aug 30, 2019 at 03:18:07PM +0300, Tero Kristo wrote:
> >> Add new binding for OMAP PRM (Power and Reset Manager) instances. Each
> >> of these will act as a power domain controller and potentially as a reset
> >> provider.
> >>
> >
> > Converting this to schema would be nice.
>
> Do you have documentation about schema somewhere? Basically what I need
> to do to fix this.

Documentation/devicetree/writing-schema.md (.rst in -next)
Documentation/devicetree/bindings/example-schema.yaml

> >> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >> ---
> >>   .../devicetree/bindings/arm/omap/prm-inst.txt | 31 +++++++++++++++++++
> >
> > bindings/reset/
>
> I did not put this under reset, because this is basically a
> multi-purpose function. Reset just happens to be the first functionality
> it is going to provide. It will be followed by power domain support
> later on.
>
> Any thoughts?

I prefer that bindings be complete as possible even if driver support
is not there yet. Adding power domain support may only mean adding
'#power-domain-cells'.

The location is fine then.

> >>   1 file changed, 31 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/arm/omap/prm-inst.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/omap/prm-inst.txt b/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
> >> new file mode 100644
> >> index 000000000000..7c7527c37734
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
> >> @@ -0,0 +1,31 @@
> >> +OMAP PRM instance bindings
> >> +
> >> +Power and Reset Manager is an IP block on OMAP family of devices which
> >> +handle the power domains and their current state, and provide reset
> >> +handling for the domains and/or separate IP blocks under the power domain
> >> +hierarchy.
> >> +
> >> +Required properties:
> >> +- compatible:       Must be one of:
> >> +            "ti,am3-prm-inst"
> >> +            "ti,am4-prm-inst"
> >> +            "ti,omap4-prm-inst"
> >> +            "ti,omap5-prm-inst"
> >> +            "ti,dra7-prm-inst"
> >
> > '-inst' seems a bit redundant.
>
> ti,xyz-prm is already reserved by the parent node of all these.
>
> The hierarchy is basically like this (omap4 as example):
>
> prm: prm@4a306000 {
>    compatible = "ti,omap4-prm";
>    ...
>
>    prm_dsp: prm@400 {
>      compatible = "ti,omap4-prm-inst";
>      ...
>    };
>
>    prm_device: prm@1b00 {
>      compatible = "ti,omap4-prm-inst";
>      ...
>    };
>
>    ...
> };

Okay. Then you need to state this binding must be a child of PRM. The
schema would need to take this into account too, so probably best to
not convert this yet.

Rob
