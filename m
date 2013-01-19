From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 0/2] OMAP3 ISP: Simplify clock usage
Date: Sat, 19 Jan 2013 19:27:37 +0200
Message-ID: <20130119172737.GK13641@valkosipuli.retiisi.org.uk>
References: <1357652634-17668-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357652634-17668-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On Tue, Jan 08, 2013 at 02:43:52PM +0100, Laurent Pinchart wrote:
> Hello,
> 
> Now that the OMAP3 supports the common clock framework, clock rate
> back-propagation is available for the ISP clocks. Instead of setting the
> cam_mclk parent clock rate to control the cam_mclk clock rate, we can mark the
> dpll4_m5x2_ck_3630 and cam_mclk clocks as supporting back-propagation, and set
> the cam_mclk rate directly. This simplifies the ISP clocks configuration.
> 
> Laurent Pinchart (2):
>   ARM: OMAP3: clock: Back-propagate rate change from cam_mclk to
>     dpll4_m5
>   omap3isp: Set cam_mclk rate directly
> 
>  arch/arm/mach-omap2/cclock3xxx_data.c |   10 +++++++++-
>  drivers/media/platform/omap3isp/isp.c |   18 ++----------------
>  drivers/media/platform/omap3isp/isp.h |    8 +++-----
>  3 files changed, 14 insertions(+), 22 deletions(-)

Thanks! It's so nice to see one of the last ugly bits of the omap3isp driver
disappear. :-)

Acked-by: Sakari Ailus <sakari.ailus@iki.fi>
Tested-by: Sakari Ailus <sakari.ailus@iki.fi>

(On 3630 / N950.)

-- 
Cheers,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
