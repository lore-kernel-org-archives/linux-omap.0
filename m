From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v3 0/7] ARM: dts: omap: Add dts data for USB
Date: Fri, 15 Mar 2013 13:41:30 +0100
Message-ID: <514316FA.1090002@ti.com>
References: <1362663320-23799-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362663320-23799-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, tony@atomide.com, linux@arm.linux.org.uk, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>
List-Id: linux-omap@vger.kernel.org

+ Jon

Hi Kishon,

On 03/07/2013 02:35 PM, Kishon Vijay Abraham I wrote:
> Hi Benoit,
> 
> Here are the dt data patches to get usb device functional in OMAP platforms.
> 
> All the patches deal with modifying arch/arm/boot except one which modifies
> Documentation/../usb/omap-usb.txt
> 
> Changes from v2:
> * squashed the dt data for dwc3-omap with dwc3 core into a single patch.
> 
> Changes from v1:
> Patch *ARM: dts: omap: Add usb_otg and glue data* has some properties with
> names that has "_". It's replaced with a "-" here.
> 
> This patch is developed on Linux 3.9-rc1.

The patches looks really good. I've just had to rebase on top of my HEAD due to some conflict with GPMC patch already applied.

I cleaned as well some subject and changelog for consistency.

The patches are available here:

git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.10/dts


Jon,

You might have to rebase your series on top of the new HEAD before reposting.

Thanks,
Benoit


> Kishon Vijay Abraham I (7):
>   ARM: dts: omap: Add omap control usb data
>   ARM: dts: omap: Add omap-usb2 dt data
>   ARM: dts: omap: Add usb_otg and glue data
>   ARM: dts: omap5: Add omap control usb data
>   ARM: dts: omap5: Add ocp2scp data
>   ARM: dts: omap5: Add omap-usb3 and omap-usb2 dt data
>   ARM: dts: omap5: add dwc3 omap and dwc3 core dt data
> 
>  Documentation/devicetree/bindings/usb/omap-usb.txt |    1 +
>  arch/arm/boot/dts/omap3-beagle-xm.dts              |    6 +++
>  arch/arm/boot/dts/omap3-evm.dts                    |    6 +++
>  arch/arm/boot/dts/omap3-overo.dtsi                 |    6 +++
>  arch/arm/boot/dts/omap3.dtsi                       |   12 +++++
>  arch/arm/boot/dts/omap4-panda.dts                  |    6 +++
>  arch/arm/boot/dts/omap4-sdp.dts                    |    6 +++
>  arch/arm/boot/dts/omap4.dtsi                       |   26 +++++++++++
>  arch/arm/boot/dts/omap5.dtsi                       |   48 ++++++++++++++++++++
>  arch/arm/boot/dts/twl4030.dtsi                     |    2 +-
>  10 files changed, 118 insertions(+), 1 deletion(-)
> 
