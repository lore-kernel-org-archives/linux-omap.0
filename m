From: Paolo Pisati <p.pisati@gmail.com>
Subject: Re: [PATCH v2] ARM/dts: hdmi-codec: panda/es dt entries
Date: Wed, 19 Feb 2014 11:54:34 +0100
Message-ID: <20140219105434.GA5738@luxor.wired.org>
References: <1392716606-7436-1-git-send-email-paolo.pisati@canonical.com>
 <5304681C.4010106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:47605 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbaBSKyi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 05:54:38 -0500
Content-Disposition: inline
In-Reply-To: <5304681C.4010106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Paolo Pisati <paolo.pisati@canonical.com>, bcousson@baylibre.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Feb 19, 2014 at 10:15:24AM +0200, Peter Ujfalusi wrote:
> > diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> > index 88c6a05..f4aeaa1 100644
> > --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> > +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> > @@ -36,9 +36,15 @@
> >  		};
> >  	};
> >  
> > +	hdmi_audio: hdmi_audio@0 {
> > +		compatible = "linux,hdmi-audio";
> > +		status = "okay";
> > +	};
> > +
> >  	sound: sound {
> >  		compatible = "ti,abe-twl6040";
> >  		ti,model = "PandaBoard";
> > +		ti,audio-codec = <&hdmi_audio>;
> 
> I don't think this is going to work. The omap-abe-twl6040 machine driver only
> handles mcpdm and dmic right know.
> 'ti,audio-codec' is not even supported and it is kind of misleading naming in
> this context since twl6040 is also a codec, so why only the dummy-hdmi codec
> deserves to be called as codec.

i see what you mean: i thought that hdmi_audio to actually work had to be
referenced inside the sound node (hence my inclusion there) but i was wrong and
it had nothing to do with twl6040,
would this one be ok for you?

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 88c6a05..b6dd458 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -36,6 +36,11 @@
                };
        };
 
+       hdmi_audio: hdmi_audio@0 {
+               compatible = "linux,hdmi-audio";
+               status = "okay";
+       };
+
        sound: sound {
                compatible = "ti,abe-twl6040";
                ti,model = "PandaBoard";


> Furthermore: we have the omap-hdmi-card machine driver to handle the HDMI
> audio. It lacks DT support AFAIK but should not be a big deal to add the bindings.
> To get the hdmi audio working you also need to have phandle for the omap-hdmi
> DAI, the codec alone is not enough.
>
 
you mean sound/soc/omap/omap-hdmi-card.c? that's exactly what i'm trying to fix.

With the above patch, plus:

-CONFIG_DISPLAY_CONNECTOR_HDMI=m
+CONFIG_DISPLAY_CONNECTOR_HDMI=y
 CONFIG_DISPLAY_ENCODER_TFP410=m
-CONFIG_DISPLAY_ENCODER_TPD12S015=m
+CONFIG_DISPLAY_ENCODER_TPD12S015=y

to make the omap-hdmi-audio-dai attach (sound/soc/omap/omap-hdmi.c)
and something like this (that is not upstreamable as i understand
but is an unfortunate fallout from the board removal[*]):

--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -335,6 +335,11 @@ static struct platform_device omap_hdmi_audio = {
        .id     = -1,
 };
 
+static struct platform_device hdmi_audio_codec = {
+       .name   = "hdmi-audio-codec",
+       .id     = -1,
+};
+
 static void __init omap_init_hdmi_audio(void)
 {
        struct omap_hwmod *oh;
@@ -349,6 +354,7 @@ static void __init omap_init_hdmi_audio(void)
             "Can't build omap_device for omap-hdmi-audio-dai.\n");
 
        platform_device_register(&omap_hdmi_audio);
+       platform_device_register(&hdmi_audio_codec);
 }
 #else
 static inline void omap_init_hdmi_audio(void) {}

i finally get my OMAPHDMI device back:

flag@panda:~$ cat /proc/asound/cards 
 0 [OMAPHDMI       ]: OMAPHDMI - OMAPHDMI
                      OMAPHDMI
 1 [PandaBoardES   ]: PandaBoardES - PandaBoardES
                      PandaBoardES

[*]: in arch/arm/mach-omap2/board-omap4panda.c we had:

-static struct platform_device panda_hdmi_audio_codec = {
-       .name   = "hdmi-audio-codec",
-       .id     = -1,
-};

-static struct platform_device *panda_devices[] __initdata = {
...
-       &panda_hdmi_audio_codec,
...
-};

that was registered as part of omap4_panda_init():

-       platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));

-- 
bye,
p.
