From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Thu, 10 Mar 2011 17:06:20 +0200
Message-ID: <1299769580.2017.235.camel@deskari>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53584 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab1CJPG0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 10:06:26 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2AF6NUL029299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 09:06:23 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p2AF6NiC002577
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 09:06:23 -0600 (CST)
In-Reply-To: <1299753858-12222-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Mythri,

On Thu, 2011-03-10 at 04:44 -0600, K, Mythri P wrote:
> Adding HDMI support on OMAP4.
> 
> HDMI is a driver that is similar to the VENC or the DSI driver to support
> HDMI/DVI sink device.
> 
> The current design adheres to the DSS2 architecture.

I was testing this on Blaze, with VENC enabled in Kconfig and a small
hack in venc.c which skips registering the venc device on omap4.

I haven't seen these earlier, so it may just be I've been lucky, or
enabling VENC affected this.

I've seen this twice when loading the modules:

[   23.007690] omapdss HDMI: no valid timing found , falling back to VGA
[   23.040161] omapdss HDMI error: PLL GO bit not set
[   23.045196] omapdss HDMI error: failed to power on device
[   23.050964] omapdss error: failed to power on
[   23.055572] omapfb omapfb: Failed to enable display 'hdmi'
[   23.066162] omapfb omapfb: failed to setup omapfb
[   23.071166] omapfb: probe of omapfb failed with error -5

And I've seen this once when unloading modules:

[  126.473419] omapdss DISPC error: SYNC_LOST_DIGIT, disabling TV
[  126.569244] omapdss DISPC error: timeout waiting for EVSYNC
[  126.670776] omapdss DISPC error: timeout waiting for EVSYNC
[  126.773376] omapdss HDMI: no valid timing found , falling back to VGA
[  126.881896] omapdss DISPC error: timeout waiting for EVSYNC
[  126.983367] omapdss DISPC error: timeout waiting for EVSYNC
rmmod: can't unload 'omapdss': Resource temporarily unavailable

This looks a bit bad, as it sounds to me that when an error happened,
some code path returned too early and the omapdss driver could not
unload.

There is this code in dss.c:

#ifdef CONFIG_OMAP2_DSS_VENC
        REG_FLD_MOD(DSS_CONTROL, 1, 4, 4);      /* venc dac demen */
        REG_FLD_MOD(DSS_CONTROL, 1, 3, 3);      /* venc clock 4x enable */
        REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);      /* venc clock mode = normal */
#endif

They don't sound like they would affect HDMI, but that was the only
difference I found (between VENC enabled and disabled) with a quick
search.

 Tomi


