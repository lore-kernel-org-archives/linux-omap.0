From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Unifying cape overlays into boot .dtb for BeagleBoard.org
	boards
Date: Tue, 17 Jun 2014 18:41:28 +0100
Message-ID: <20140617174128.GG3705@n2100.arm.linux.org.uk>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com> <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com> <20140617090931.GB3705@n2100.arm.linux.org.uk> <20140617125831.GI4173@beef> <20140617131522.GD3705@n2100.arm.linux.org.uk> <C3DA6AFC-2784-4A41-BC72-EF25B2B03B41@antoniou-consulting.com> <20140617160119.GE3705@n2100.arm.linux.org.uk> <317D412E-B455-4B9D-95B3-F010C68744A3@antoniou-consulting.com> <20140617170531.GF3705@n2100.arm.linux.org.uk> <FA75104C-9D36-4EB6-BE5C-862D71E1877B@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:33198 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754825AbaFQRlh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 13:41:37 -0400
Content-Disposition: inline
In-Reply-To: <FA75104C-9D36-4EB6-BE5C-862D71E1877B@antoniou-consulting.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Matt Porter <mporter@linaro.org>, Jason Kridner <jkridner@gmail.com>, beagleboard@googlegroups.com, Robert Nelson <robertcnelson@gmail.com>, devicetree@vger.kernel.org, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

On Tue, Jun 17, 2014 at 08:10:46PM +0300, Pantelis Antoniou wrote:
> Hi Russell,
> 
> On Jun 17, 2014, at 8:05 PM, Russell King - ARM Linux wrote:
> > DRM is not hotpluggable in any shape or form, and David Airlie has
> > indicated that he does strongly opposes moving it in that direction.
> > 
> > DRM follows the "card" model, where, at probe time, the hardware is
> > known and never changes until the "card" is torn down.  No new
> > connectors can be added once the "card" is initialised, and no
> > connectors can be removed.  Any changes must be done by tearing down
> > the entire card and reconstructing it (if reconstructing it with a
> > reduced set of hardware is appropriate.)
> > 
> 
> That is a limitation of the current DRM implementation.

... an implementation which isn't going to change any time soon... and
certainly is not going to change because someone comes along with a
dynamic DT infrastructure.

> I seems to be this is born out of some kind of misunderstanding about how
> DT can (and does) support dynamic changes.
> 
> I admit that I haven't done much work on DRM (besides some tinkering with
> Rob Clark's ti_lcdc DRM driver), but knowing what DT does have a dynamic
> change notifier support, perhaps it can be made to work.

It can be made to work in the way that I described above - any change
to the hardware which makes up a DRM card would need the entire DRM
card torn down and re-created... as I said above.

The reason I know this is because I've been involved closely in dealing
with imx-drm, and Armada DRM, and the mess that people spew trying to
get their DT representations of their hardware (as multiple, separate
devices which can be probed asynchronously) to work with DT.

If DRM supported hot-plugging of components, dealing with that would
be much easier than it is, but - as I said above - this is not going
to happen.  So, if it's not going to happen for the case which we
commonly find on ARM hardware today, it's certainly not going to
happen because DT wants to become dynamic.

> As I said, the next thing coming is transactional DT support, perhaps you
> can share the DT fragment describing your use-case (before/after) and 
> I'll try to accommodate in the next patch series.

I don't have any - I'm using it as an example where a device (such as
the iMX6 SoC) which has quite a complex media infrastructure may be
extended externally via an FPGA to provide additional interfaces which
may then require dynamic changes to the DT description, thereby meaning
that we have to reconstruct the DRM "card" in its entirety.

If you want some DT to look at...

                        ldb: ldb@020e0008 {
                                #address-cells = <1>;
                                #size-cells = <0>;
                                compatible = "fsl,imx6q-ldb", "fsl,imx53-ldb";
                                gpr = <&gpr>;
                                status = "disabled";

                                lvds-channel@0 {
                                        #address-cells = <1>;
                                        #size-cells = <0>;
                                        reg = <0>;
                                        status = "disabled";

                                        port@0 {
                                                reg = <0>;

                                                lvds0_mux_0: endpoint {
                                                        remote-endpoint = <&ipu1_di0_lvds0>;
                                                };
                                        };

                                        port@1 {
                                                reg = <1>;

                                                lvds0_mux_1: endpoint {
                                                        remote-endpoint = <&ipu1_di1_lvds0>;
                                                };
                                        };
                                };

                                lvds-channel@1 {
                                        #address-cells = <1>;
                                        #size-cells = <0>;
                                        reg = <1>;
                                        status = "disabled";

                                        port@0 {
                                                reg = <0>;

                                                lvds1_mux_0: endpoint {
                                                        remote-endpoint = <&ipu1_di0_lvds1>;
                                                };
                                        };

                                        port@1 {
                                                reg = <1>;

                                                lvds1_mux_1: endpoint {
                                                        remote-endpoint = <&ipu1_di1_lvds1>;
                                                };
                                        };
                                };
                        };

                        hdmi: hdmi@0120000 {
                                #address-cells = <1>;
                                #size-cells = <0>;
                                reg = <0x00120000 0x9000>;
                                interrupts = <0 115 0x04>;
                                gpr = <&gpr>;
                                clocks = <&clks 123>, <&clks 124>;
                                clock-names = "iahb", "isfr";
                                status = "disabled";

                                port@0 {
                                        reg = <0>;

                                        hdmi_mux_0: endpoint {
                                                remote-endpoint = <&ipu1_di0_hdmi>;
                                        };
                                };

                                port@1 {
                                        reg = <1>;

                                        hdmi_mux_1: endpoint {
                                                remote-endpoint = <&ipu1_di1_hdmi>;
                                        };
                                };
                        };

                        mipi_dsi: mipi@021e0000 {
                                #address-cells = <1>;
                                #size-cells = <0>;
                                reg = <0x021e0000 0x4000>;
                                status = "disabled";

                                port@0 {
                                        reg = <0>;

                                        mipi_mux_0: endpoint {
                                                remote-endpoint = <&ipu1_di0_mipi>;
                                        };
                                };

                                port@1 {
                                        reg = <1>;

                                        mipi_mux_1: endpoint {
                                                remote-endpoint = <&ipu1_di1_mipi>;
                                        };
                                };
                        };

                ipu1: ipu@02400000 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        compatible = "fsl,imx6q-ipu";
                        reg = <0x02400000 0x400000>;
                        interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>,
                                     <0 5 IRQ_TYPE_LEVEL_HIGH>;
                        clocks = <&clks 130>, <&clks 131>, <&clks 132>;
                        clock-names = "bus", "di0", "di1";
                        resets = <&src 2>;

                        ipu1_di0: port@2 {
                                #address-cells = <1>;
                                #size-cells = <0>;
                                reg = <2>;

                                ipu1_di0_disp0: endpoint@0 {
                                };

                                ipu1_di0_hdmi: endpoint@1 {
                                        remote-endpoint = <&hdmi_mux_0>;
                                };

                                ipu1_di0_mipi: endpoint@2 {
                                        remote-endpoint = <&mipi_mux_0>;
                                };

                                ipu1_di0_lvds0: endpoint@3 {
                                        remote-endpoint = <&lvds0_mux_0>;
                                };

                                ipu1_di0_lvds1: endpoint@4 {
                                        remote-endpoint = <&lvds1_mux_0>;
                                };
                                };

                                ipu1_di0_lvds1: endpoint@4 {
                                        remote-endpoint = <&lvds1_mux_0>;
                                };
                        };

                        ipu1_di1: port@3 {
                                #address-cells = <1>;
                                #size-cells = <0>;
                                reg = <3>;

                                ipu1_di0_disp1: endpoint@0 {
                                };

                                ipu1_di1_hdmi: endpoint@1 {
                                        remote-endpoint = <&hdmi_mux_1>;
                                };

                                ipu1_di1_mipi: endpoint@2 {
                                        remote-endpoint = <&mipi_mux_1>;
                                };

                                ipu1_di1_lvds0: endpoint@3 {
                                        remote-endpoint = <&lvds0_mux_1>;
                                };

                                ipu1_di1_lvds1: endpoint@4 {
                                        remote-endpoint = <&lvds1_mux_1>;
                                };
                        };
                };

        display-subsystem {
                compatible = "fsl,imx-display-subsystem";
                ports = <&ipu1_di0>, <&ipu1_di1>, <&ipu2_di0>, <&ipu2_di1>;
        };


ipu1, mipi_dsi, ldb and hdmi are each separate platform devices, which
are combined to look like a single DRM device.  Each device can be
enabled by the platform code.  All enabled devices must be present to
cause the DRM device to "bind".  The above connectivity is parsed via
the of_graph helpers, and enumerated by the driver(s).

Let's say that we have ipu1 and hdmi enabled, but ldb disabled.  ldb is
connected to an external FPGA.  Someone loads a bitstream after boot
into the FPGA, and then updates the DT dynamically to enable the ldb
device.

Great, so a new platform device gets spawned for the new device.  What
triggers the ipu or display subsystem level (which is what's really
needed) to tell it something changed here?

This is exactly my point - such stuff has not been thought about, because
(I reckon) not many people are even aware of DT wanting to become dynamic.
It's certainly not clear from the use model that we've been basing our
driver conversions on that DT is anything but static...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
