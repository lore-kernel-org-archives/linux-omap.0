From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv6 2/2][RESEND] ASoC: TWL6040: Add twl6040 codec driver
Date: Thu, 18 Mar 2010 18:16:23 +0000
Message-ID: <20100318181623.GG6142@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCE662AC7F1@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38557 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753129Ab0CRSQ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 14:16:26 -0400
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE662AC7F1@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Mar 18, 2010 at 12:59:49PM -0500, Olaya, Margarita wrote:
> From: Misael Lopez Cruz <x0052729@ti.com>
> 
> Initial version of TWL6040 codec driver.
> 
> The TWL6040 codec uses a proprietary PDM-based digital audio interface.
> Audio paths supported are:

I'm getting exactly the same results trying to apply this.  It looks
like there's some MUA corruption going on here, the start of the
Makefile diff is:

--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -22,6 +22,7 @@ snd-soc-tlv320aic26-objs :=3D tlv320aic26.o
 snd-soc-tlv320aic3x-objs :=3D tlv320aic3x.o
 snd-soc-tlv320dac33-objs :=3D tlv320dac33.o
 snd-soc-twl4030-objs :=3D twl4030.o
+snd-soc-twl6040-objs :=3D twl6040.o
 snd-soc-uda134x-objs :=3D uda134x.o
 snd-soc-uda1380-objs :=3D uda1380.o
 snd-soc-wm8350-objs :=3D wm8350.o
@@ -85,6 +86,7 @@ obj-$(CONFIG_SND_SOC_TLV320AIC26)     +=3D snd-soc-tlv320=
aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)      +=3D snd-soc-tlv320aic3x.o
 obj-$(CONFIG_SND_SOC_TLV320DAC33)      +=3D snd-soc-tlv320dac33.o
 obj-$(CONFIG_SND_SOC_TWL4030)  +=3D snd-soc-twl4030.o

The quoted printable encoding should be fine but note that the 'aic26.o'
has been word wrapped onto a new line, which is why patch says the diff
is corrupted.  The same word wrapping issue is occurring in other places
in the diff such as:

+       /* allow registers to be accessed by i2c */
+       twl6040_write(codec, TWL6040_REG_ACCCTL, cache[TWL6040_REG_ACCCTL])=
;

Looks like MUA trouble.  From the message headers it looks like you
might be using Outlook or something, I'm not sure what to suggest for
that - enough folks at TI are submitting patches that something must've
been worked out for your mail system.

If you can't work out a solution for sending things in-line0 then
sending the patch as an attachment should resolve the issue.
