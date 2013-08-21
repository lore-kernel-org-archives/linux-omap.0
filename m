From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC 00/22] OMAPDSS: DT support
Date: Wed, 21 Aug 2013 23:07:02 +0200
Message-ID: <2305295.bk1TpuGLMv@avalon>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:56243 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab3HUVFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Aug 2013 17:05:49 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Hi Tomi,

I'm back from holidays and have finally found time to review your patch set.

On Friday 09 August 2013 11:38:45 Tomi Valkeinen wrote:
> Hi,
> 
> This is an RFC for OMAP Display DT support. The patches work fine, at least
> for me, but they are not perfect. I mostly don't have any clear questions
> about specific issues, but I would like to get feedback on the selected
> approaches in general, and also ideas how to proceed with the series.
> 
> This series contains the following:
> 
> DT support for the following OMAP's display subsystem devices:
> - DSS
> - DISPC
> - DPI
> - HDMI
> - VENC
> - DSI
> - (DBI/RFBI DT is not yet implemented)
> 
> DT support for the following external display devices:
> - panel-dsi-cm (Generic DSI command mode panel)
> - encoder-tfp410 (DPI-to-DVI encoder)
> - connector-dvi
> - encoder-tpd12s015 (HDMI level-shifter & ESD protection)
> - hdmi-connector
> - panel-dpi (Generic DPI panel)
> - connector-analog-tv (S-Video & Composite)
> 
> DT support for the following boards:
> - OMAP4 PandaBoard
> - OMAP4 SDP
> - OMAP3 BeagleBoard
> - OMAP3 Overo with Palo43 LCD expansion-board
> 
> The patches are not final, and many contain quite brief descriptions.
> Binding descriptions are also still missing. The code and bindings in the
> patches should be pretty straightforward, though.
> 
> The series is based on v3.11-rc2 + a couple of non-DSS fixes. The series
> can also be found from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git
> work/dss-dev-model-dt
> 
> Vocabulary
> ==========
> 
> Display Entity - a hardware entity that takes one or more video streams as
> input and outputs one or more video streams.
> 
> Upstream Entity - A display entity in the "upstream" side of the video
> stream, i.e. closer to the original video source.
> 
> Downstream Entity - A display entity in the "downstream" side of the video
> stream, i.e. closer to the panel or monitor.
> 
> Video pipeline - A chain of multiple display entities, starting from the
> SoC, going to the display device the user sees.
> 
> Display or Panel - A display entity showing the pixels to the user
> 
> Encoder - A display entity that takes video as an input and (usually)
> outputs it in some other format.
> 
> Connector - HDMI/DVI/etc Connector on the board, to which an external
> monitor is connected.
> 
> About Stable DT Bindings
> ========================
> 
> Generally speaking, the DT bindings should be stable. This brings the
> following problems:
> 
> We already have DT bindings for some OMAP4 and OMAP3 boards, and OMAP4
> boards do not even have board files anymore. There are no display bindings
> for those OMAP4 boards, but the display support is currently enabled as a
> hack, by calling board-file-like code to add the display devices for the
> selected boards. So, when we add the display bindings, we should still
> support the current DT files which do not have the display bindings. Which
> would mean that we'd need to keep the hacky code forever. Considering the
> fact that the hacky code does not work quite correct in all cases, I don't
> see keeping it as a very good option.
> 
> CDF (Common Display Framework) is in the works, and will most likely have
> different or more detailed bindings. Moving to CDF would mean we'd somehow
> need to still support the old OMAP bindings. In theory the display DT
> bindings should stay the same, as they represent the HW, not any SW
> constructs, but in practice I find it hard to believe the OMAP display
> bindings would be so perfect that there would be no need for changes.
> 
> We most likely should somehow represent DSS clock tree in DT. That is not a
> simple task, and when we manage to do it, it again means supporting the DT
> files without clock tree data.
> 
> All in all, I'm a bit scared to push the display bindings, as it's already
> clear there are changes coming. Then again, supporting the current hack for
> OMAP4 based boards is not nice at all, and has issues, so it would be really
> nice to get OMAP4 boards use proper display bindings.

Getting bindings right on the very first try is a very difficult, if not 
impossible, task. We now have dedicated DT bindings reviewers and maintainers 
to help here, and all DT bindings in mainline will likely go through extensive 
review in the not too distant future. I don't know if there has been any 
formal agreement on that, but one idea that seemed generally well approved was 
to first mark new DT bindings as experimental before promoting them to stable.

On the other hand, having experimental bindings in mainline should help 
stabilizing them, but that's obviously not a reason not to think them properly 
from the start.

> General description of the DT bindings
> ======================================
> 
> All the display entities are represented as DT nodes of their own, and have
> a matching Linux driver. The display entities are organized by their control
> bus; that is, if a display entity is not controlled via any bus, it's a
> platform device, and if, say, it's controlled via i2c device, it's an i2c
> device.

I very much like that approach, and I think it's generally agreed upon.

> The exception to the above are DSI and DBI. DSI and DBI are combined control
> and video busses, but the use of the busses for control purposes is not
> independent of the video stream. Also, the the busses are, in practice,
> one-to-one links. And last, DSI and DBI display entities are often also
> controllable via, say, i2c. For these reasons there is no real Linux bus
> for DSI and DBI and thus the DSI and DBI devices are either platform
> devices or i2c devices.

That's something I'm less convinced about, but I don't have a too strong 
feeling. The best implementation should get to mainline, I won't nack this 
architecture just for theoretical reasons.

> The display entities are connected via "video-source" property. The video-
> source points to the upstream display entity where the video data comes
> from, and a chain of display entities thus form a full video pipeline. All
> video pipelines end with either a panel or a connector.

This is the part that bothers me the most, as I find it too limiting. In a 
purely linear pipeline entities will have at most one video source, but linear 
pipelines won't be enough for the future (and are actually not enough today 
already). We need to support entities with more than one sink pad in the DT 
bindings.

I've posted the third version of the Common Display Framework RFC 
(https://lwn.net/Articles/563157/). While not formally documented, the DT 
bindings are described in the cover letter. They're based on the V4L2 DT 
bindings and can express arbitrary display pipelines in DT. The patch set also 
provides helper functions to parse the DT bindings.

Could you please have a look at the bindings and tell me whether you can use 
them for the OMAPDSS (even if you don't use the CDF helpers to start with) ?

> All the data related to a display entity, and how it is connected on the
> given board, is defined in the DT node of the display entity. This means
> that the DT node of the upstream entity does not have to be modified when
> adding support for new boards.
>
> As an example, consider OMAP3's DPI and two boards using it for panels.
> omap3.dtsi contains a node for the DPI, and the board dts files contain
> nodes for their panels. The board dts files do not change anything in the
> included DPI node. So:
> 
> omap3.dtsi:
> 
> dpi: encoder@0 {
> 	compatible = "ti,omap3-dpi";
> };
> 
> omap3-board1.dts:
> 
> 	lcd0: display@0 {
> 		compatible = "samsung,lte430wq-f0c", "panel-dpi";
> 		video-source = <&dpi>;
> 		data-lines = <24>;
> 	};
> 
> omap3-board2.dts:
> 
> 	lcd0: display@0 {
> 		compatible = "samsung,lte430wq-f0c", "panel-dpi";
> 		video-source = <&dpi>;
> 		data-lines = <16>;
> 	};
> 
> The logic here is that the boards may have multiple panels that are
> connected to the same source, even if the panels can only be used one at a
> time. Each panel may thus have different properties for the bus, like the
> number of data-lines.
> 
> Video bus properties
> ====================
> 
> One question I've been pondering for a long time is related to the bus
> between two display entities. As an example, DPI (parallel RGB) requires
> configuring the number of datalines used. As described above, the properties
> of the video bus are represented in the downstream entity.
> 
> This approach has one drawback: how to represent features specific to the
> upstream entity? Say, if OMAP's DSI has a bus-related foo-feature, which can
> be used in some scenarios, the only place where this foo-feature can be
> specified is the OMAP DSI's properties. Not in the DSI Panel's properties,
> which in the current model contains properties related to the bus.
> 
> So Laurent has proposed to use V4L2-like ports, as described in
> Documentation/devicetree/bindings/media/video-interfaces.txt. I have not
> implemented such feature for OMAP DSS for the following reasons:
> 
> - The current supported displays we use work fine with the current method
> - If I were to implement such system, it'd most certainly be different than
>   what CDF will have.
> 
> That said, the port based approach does sound good, and it would also remove
> the design issue with OMAP DPI and SDI modules as described later. So maybe
> I should just go forward with it and hope that CDF will do it in similar
> manner.

I believe we should go for the port-based approach, even if you don't use the 
CDF helpers (possibly at first only).

> DSI Module ID
> =============
> 
> On OMAP4 we have two DSI modules. To configure the clock routing and pin
> muxing, we need to know the hardware module ID for the DSI device, i.e. is
> this Linux platform device DSI1 or DSI2. The same issue exists with other
> SoCs with multiple outputs of the same kind.
> 
> With non-DT case, we used the platform device's ID directly. With DT, that
> doesn't work. I don't currently have a good solution for this, so as a
> temporary solution the DSI driver contains a table, from which it can find
> the HW module ID by using the device's base address.

You could add two output ports to the DSS, one for each DSI, and link the DSI 
modules to the DSS output ports in DT. That would represent the hardware 
topology, and would allow the DSI driver to know its ID based on the DSS 
output port it's connected to. It's still a bit hackish in the sense that the 
DSI driver will use information provided by the DSS (the output port number), 
but not more than the current method.

> I believe, but I am not totally sure, that we can remove the concept of DSI
> module ID if we have a good representation of the DSS clock tree and DSI pin
> muxing in DT. The clock tree is probably a huge undertaking, but the pin
> muxing should be much easier. However, pinmuxing also is some
> complications, like the pins requiring a regulator to be enabled.
>
> Display names and aliases
> =========================
> 
> With the board-file based model each display was given a name in the board
> file. Additionally, each display was given an alias in the style "displayX",
> where X is in incrementing number.
> 
> The name could be used by the user to see which display device is what, i.e.
> on Pandaboard there are displays names "dvi" and "hdmi".
> 
> The DT bindings do not have such a name. It would be simple to add a
> "nickname" property to each display node, but it just looked rather ugly so
> I have left it out.
> 
> Additionally, as there's no clear order in which the displays are created,
> and thus the number in "displayX" alias could change semi-randomly, I added
> the displays to "aliases" node. This keeps the display number the same over
> boots, and also gives us some way to define a default display, i.e. which
> display to use initially if the user has not specified it.
> 
> omapdss virtual device
> ======================
> 
> In addition to the DSS devices matching to DSS hardware modules, we have a
> "virtual" omapdss device which does not match to any actual HW module. The
> device is there mostly for legacy reasons, but it has also allowed us to
> easily pass platform callbacks. The same device is also present in DT
> solution. It is created in code, and not present in DT bindings.
> 
> Obviously, this omapdss virtual device is on the hack side, and nobody would
> mind if it would disappear.
> 
> The following data is passed via omapdss device's platform data:
> 
> - OMAP DSS version. In theory, the DSS revision registers should tell us
>   which features the HW supports. In practice, the HW people have not
>   bothered to change the revision number each time they've made changes. So
>   we pass a DSS version from the platform code, based on OMAP revision
>   number.
> 
> - omap_dss_set_min_bus_tput() and omap_pm_get_dev_context_loss_count() to
>   manage PM
> 
> - DSI pin muxing functions.
> 
> I have some ideas how to deduce the DSS version by poking to certain DSS
> registers, but it is not yet tested so I don't know if it will work.

That might be a stupid question, but can't you just encode the version in the 
compatible string of the DSS DT node (the one currently compatible with 
"ti,omap[34]-dss") ?

Version information might also need to be split/duplicated in several of the 
DSS DT nodes. A quick grep through the driver source code shows that the 
version is used by the submodules to infer SoC glue information. For instance 
dsi_get_channel() uses the version to find the DSI module channel ID. That 
information could possibly be retrieved from the links between the DSS DT 
nodes.

> We could do altogether without omap_pm_get_dev_context_loss_count(), so that
> should be removable with some work. I am not sure if
> omap_dss_set_min_bus_tput() is supported via standard PM calls or not.
> 
> However, the use of set_min_bus_tput() is actually a hack, as we're not
> really setting min bus tput. What we want to do is prevent OPP50. DSS clocks
> have different maximums on OPP100 and OPP50. So if DSS uses a clock over
> OPP50 limit, OPP50 cannot be entered. We prevent OPP50 by setting an
> arbitrarily high min bus tput.
> 
> The DSI pin muxing should also be solvable with DT based solution, but is
> not the most trivial task and needs some work.
> 
> So, I presume that at some point we can remove the omapdss device, but in
> the current solution it exists for the above reasons.
> 
> DSS submodules in DT bindings
> =============================
> 
> The OMAP DSS modules are accessed via L4 or L3, and in that sense they
> should be on the same level in the DT bindings. However, we do not have them
> in the same level, but there is a main "dss" node, under which all the
> other DSS modules reside. The main reason for this is that the main DSS
> device needs to be enabled for the other modules to work properly, and
> having this structure makes runtime PM handle enabling DSS automatically.
> 
> If I recall right, somebody (Paul?) mentioned that in the hardware there is
> actually some DSS internal bus, and thus the DT structure is good in that
> sense also.
> 
> We also have nodes (and matching Linux devices) for DPI and SDI. Neither of
> them are actuall a separate IP block in the hardware, but are really more
> parts of DSS and maybe DISPC. They are still represented in the same way as
> the other DSS modules, to have similar architecture for all DSS outputs. But
> as they do not have an address-space of their own, the DT nodes use 0 and 1
> as "addresses", i.e. "dpi: encoder@0".
> 
> That is rather ugly, and maybe could use some cleaning up. A V4L2 port style
> approach would probably allow us to add DPI and SDI ports as part of DSS.

I think that would really be a good idea. The DPI and SDI code could be moved 
to the DSS module (it can of course still be kept in separate files as today), 
and the DISPC (if I'm not mistaken) entity would just have several output 
ports.

> Some of the DSS modules are actually a combination of multiple smaller
> modules. For example, the DSI module contains DSI protocol, DSI PHY and DSI
> PLL modules, each in their own address space. These could perhaps be
> presented as separate DT nodes and Linux devices, but I am not sure if that
> is a good approach or not.

What are the chances that one of those block will be upgraded and/or replaced 
independently of the others in the future (I know it's a tricky question) ? It 
might not be worth it going to a too fine-grained approach at the moment, but 
we need to make sure that the DT bindings will allow an easy path forward if 
needed.

> DT Node Names
> =============
> 
> I have used the following naming conventions with DT nodes:
> 
> - Panels are named "display"
> - Connectors are named "connector"
> - Encoders are named "encoder"
> - DSS and DISPC are "dss" and "dispc", as they don't really match any of the
> above
> 
> When appropriate, the address part of the node is the base address, as in
> "dsi1: encoder@58004000". For platform devices, I have used an increasing
> number for the address, as in "tpd12s015: encoder@1".
> 
> Final words
> ===========
> 
> So as is evident, I have things in my mind that should be improved. Maybe
> the most important question for short term future is:
> 
> Can we add DSS DT bindings for OMAP4 as unstable bindings? It would give us
> some proper testing of the related code, and would also allow us to remove
> the related hacks (which don't even work quite right). However, I have no
> idea yet when the unstable DSS bindings would turn stable.
> 
> If we shouldn't add the bindings as unstable, when should the bindings be
> added? Wait until CDF is in the mainline, and use that?

What about using the CDF bindings, without waiting for CDF to be in mainline ? 
I believe the bindings should be upstreamed as unstable to start with anyway.

> I have not explained every piece of DSS in detail, as that would result in a
> book instead of this email, so feel free to ask for more details about any
> part.
> 
> And last but not least (for me, at least =), I'm on vacation for the next
> two weeks, so answers may be delayed.

Enjoy your holidays and recharge your batteries, you will need energy when 
you'll come back :-)

> Tomi Valkeinen (22):
>   ARM: OMAP: remove DSS DT hack
>   OMAPDSS: remove DT hacks for regulators
>   ARM: OMAP2+: add omapdss_init_of()
>   OMAPDSS: if dssdev->name==NULL, use alias
>   OMAPDSS: get dssdev->alias from DT alias
>   OMAPFB: clean up default display search
>   OMAPFB: search for default display with DT alias
>   OMAPDSS: Add DT support to DSS, DISPC, DPI, HDMI, VENC
>   OMAPDSS: Add DT support to DSI
>   ARM: omap3.dtsi: add omapdss information
>   ARM: omap4.dtsi: add omapdss information
>   ARM: omap4-panda.dts: add display information
>   ARM: omap4-sdp.dts: add display information
>   ARM: omap3-tobi.dts: add lcd (TEST)
>   ARM: omap3-beagle.dts: add display information
>   OMAPDSS: panel-dsi-cm: Add DT support
>   OMAPDSS: encoder-tfp410: Add DT support
>   OMAPDSS: connector-dvi: Add DT support
>   OMAPDSS: encoder-tpd12s015: Add DT support
>   OMAPDSS: hdmi-connector: Add DT support
>   OMAPDSS: panel-dpi: Add DT support
>   OMAPDSS: connector-analog-tv: Add DT support
> 
>  arch/arm/boot/dts/omap3-beagle.dts                 | 29 ++++++++
>  arch/arm/boot/dts/omap3-tobi.dts                   | 33 ++++++++
>  arch/arm/boot/dts/omap3.dtsi                       | 43 +++++++++++
>  arch/arm/boot/dts/omap4-panda-common.dtsi          | 48 ++++++++++++
>  arch/arm/boot/dts/omap4-sdp.dts                    | 70 +++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi                       | 59 +++++++++++++++
>  arch/arm/mach-omap2/board-generic.c                | 13 +---
>  arch/arm/mach-omap2/common.h                       |  2 +
>  arch/arm/mach-omap2/display.c                      | 34 +++++++++
>  arch/arm/mach-omap2/dss-common.c                   | 23 ------
>  arch/arm/mach-omap2/dss-common.h                   |  2 -
>  .../video/omap2/displays-new/connector-analog-tv.c | 70 +++++++++++++++++
>  drivers/video/omap2/displays-new/connector-dvi.c   | 49 ++++++++++++
>  drivers/video/omap2/displays-new/connector-hdmi.c  | 36 +++++++++
>  drivers/video/omap2/displays-new/encoder-tfp410.c  | 54 ++++++++++++++
>  .../video/omap2/displays-new/encoder-tpd12s015.c   | 62 +++++++++++++++
>  drivers/video/omap2/displays-new/panel-dpi.c       | 75 +++++++++++++++++++
>  drivers/video/omap2/displays-new/panel-dsi-cm.c    | 87 +++++++++++++++++++
>  drivers/video/omap2/dss/dispc.c                    |  7 ++
>  drivers/video/omap2/dss/display.c                  | 23 +++++-
>  drivers/video/omap2/dss/dpi.c                      |  8 ++
>  drivers/video/omap2/dss/dsi.c                      | 58 +++++++++++++--
>  drivers/video/omap2/dss/dss.c                      | 10 +++
>  drivers/video/omap2/dss/hdmi.c                     | 11 +--
>  drivers/video/omap2/dss/venc.c                     |  7 ++
>  drivers/video/omap2/omapfb/omapfb-main.c           | 67 ++++++++++++-----
>  26 files changed, 915 insertions(+), 65 deletions(-)

-- 
Regards,

Laurent Pinchart

