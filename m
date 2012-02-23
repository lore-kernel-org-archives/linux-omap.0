From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Questions about DSS device tree adaptation
Date: Thu, 23 Feb 2012 12:43:20 +0100
Message-ID: <4F462658.9080404@ti.com>
References: <1329912443.2070.58.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50977 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766Ab2BWLnX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 06:43:23 -0500
In-Reply-To: <1329912443.2070.58.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap mailing list <linux-omap@vger.kernel.org>

Hi Tomi,

On 2/22/2012 1:07 PM, Tomi Valkeinen wrote:
> Hi,
>
> I'd like to get some feedback for the DSS DT work.
>
> I have currently this in omap4.dtsi, under ocp. It's still a hack, for
> example there's sdi for testing even though omap4 doesn't have SDI
> output.
>
> dss {
> 	compatible = "ti,omap4-dss";
> 	ti,hwmods = "dss_core";
>
> 	dispc {
> 		compatible = "ti,omap4-dispc";
> 		ti,hwmods = "dss_dispc";
> 	};
>
> 	dpi: dpi {
> 		compatible = "ti,omap4-dpi";
> 	};
>
> 	sdi: sdi {
> 		compatible = "ti,omap3-sdi";
> 	};
>
> 	dsi1: dsi@1 {
> 		compatible = "ti,omap4-dsi";
> 		ti,hwmods = "dss_dsi1";
> 		id =<0>;

Fixed id should be avoided. In theory you should not need that, and if 
it is needed like for the UART because Linux is expecting a tty<id>, you 
should create an alias to map the node to the numbered alias. Just check 
what was done for UART.

> 		vdds_dsi-supply =<&vcxio>;
> 	};
>
> 	dsi2: dsi@2 {
> 		compatible = "ti,omap4-dsi";
> 		ti,hwmods = "dss_dsi2";
> 		id =<1>;
> 		vdds_dsi-supply =<&vcxio>;
> 	};
>
> 	hdmi {
> 		compatible = "ti,omap4-hdmi";
> 		ti,hwmods = "dss_hdmi";
>
> 		hpd_gpio =<0>;
> 		ls_oe =<0>;
> 	};
>
> 	rfbi: rfbi {
> 		compatible = "ti,omap4-rfbi";
> 		ti,hwmods = "dss_rfbi";
> 	};
>
> 	venc {
> 		compatible = "ti,omap4-venc";
> 		ti,hwmods = "dss_venc";
> 	};
> };
>
> And in omap4-panda.dtsi I have:
>
> &dpi {
> 	dvi {
> 		compatible = "ti,tfp410";
> 		data-lines =<24>;
> 		channel =<2>;
> 		enable-gpio =<0>;
> 		ddc =<&dviddc>;
> 	};
> };
>
>
> A few notes/questions about the above:
>
> dispc is not an output interface (so it won't have any children), it
> doesn't have anything to customize in the dt data, and it's present on
> all OMAPs. Should it still be present in the DT data, or should the
> device be created dynamically in platform code?

For consistency, it is still better to have it. You will then be able to 
use the DT compatible mechanism to identify properly the various DISPC 
version if needed.

Don't you have a functional dependency between the DISPC and some other 
nodes like DSI, SDI, DPI?

At some point most OMAP devices will probably be created using DT just 
to avoid having two different device creation mechanisms.
It is true that the main priority today is to expose the ones that are 
configurable at board level.

> dpi and sdi are not hwmods as the rest of the nodes. They are, from HW
> point of view, more or less parts of DSS or perhaps DISPC.

This is fine, hwmod is really needed only for the IP under PRCM control 
mostly. Other device can then be regular platform_device.

I even think that I will get rid of the other hwmod as soon as the clock 
binding will be there in DT. Because for the PRCM point of view, there 
is only one DSS node. The other ones were created artificially to expose 
the clocks to the proper device. They should not be there.

> dsi nodes have the id property, which is used by the driver to choose
> between DSI1 and DSI2 HW modules. Is there a better way to do this than
> a custom property?

Yes, as explained before.

> Who/where/when should the devices for dss submodules be created? The
> device for dss-node is created automatically by the of-platform code(?),
> but the rest of the submodules need to be handled by me somehow.

Yes.

> I'm currently using of_platform_populate() in the probe of ti,omap4-dss
> driver to create the subdevices, but this approach doesn't feel right.
> Shouldn't the devices be created already at the boot time by platform
> code, not by the driver code?

No, this is correct thing to do. It is even much more inlined with the 
regular way of creating device dynamically in a x86 platform after based 
on bus enumeration. This is that whole static platform_device that was 
*wrong* so far.
In this case, it will allow you to have different definition of the DSS 
and to rely on the sub nodes to discover what are the sub IPs in your 
DSS. Whereas today you have to build an array that contains the 
definition of the DSS for OMAP2, OMAP3 and OMAP4.

> Is the "simple-bus", that ocp node also uses, something that I could use
> here? If I define the dss node to be compatible with simple-bus also,
> does it mean that the of-platform code creates the submodules for me?
> Are there any side-effects?

You should not use simple_bus if you already have a driver to probe that 
device, otherwise the is the main DT core iterator that will create the 
device, and you might not want to do that if you have something to do 
during probe like enabling the clock in order to access the sub modules.

> How about the actual panel devices. Above there's the "ti,tfp410"
> device. The panel devices are not plain platform devices, so I need to
> handle those myself. Can I somehow handle that in the platform code,
> creating omap_dss_devices at boot time, or do I need to create those
> devices in, for example in this case, dpi-driver's probe?

That does not look right to me. Why cannot they be platform_device?

Regards,
Benoit

