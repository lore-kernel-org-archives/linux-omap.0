From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] video: omap2: Compile omap2 support only when
 needed
Date: Mon, 20 Jun 2011 16:06:41 +0300
Message-ID: <1308575201.2076.57.camel@deskari>
References: <1308566761-2850-1-git-send-email-tushar.behera@linaro.org>
	 <1308566761-2850-3-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308566761-2850-3-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tony@atomide.com, lethal@linux-sh.org, linaro-dev@lists.linaro.org, patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 2011-06-20 at 16:16 +0530, Tushar Behera wrote:
> Currently display support for omap2 is selected by default and
> it gets built for all the configurations.
> 
> Instead of it being a built-in feature, it's compilation should
> depend on the config option CONFIG_FB_OMAP2.

No, I don't think so. omap2 directory contains vram, vrfb and omapdss,
all of which can be used without omapfb driver. vram and vrfb can be
even used without omapdss driver.

Is this patch fixing some real problem?

 Tomi
