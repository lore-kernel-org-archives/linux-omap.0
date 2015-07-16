From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Remove legacy OMAP3 ISP instantiation
Date: Thu, 16 Jul 2015 18:45:22 +0300
Message-ID: <55A7D192.7080301@iki.fi>
References: <1437051319-9904-1-git-send-email-laurent.pinchart@ideasonboard.com> <1437051319-9904-2-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1437051319-9904-2-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, mike@compulab.co.il, grinberg@compulab.co.il
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

Laurent Pinchart wrote:
> The OMAP3 ISP is now fully supported in DT, remove its instantiation
> from C code.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/mach-omap2/devices.c | 53 -------------------------------------------
>  arch/arm/mach-omap2/devices.h | 19 ----------------
>  2 files changed, 72 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/devices.h

If you remove the definitions, arch/arm/mach-omap2/board-cm-t35.c will
no longer compile. Could you remove the camera support there as well?

My understanding is the board might be supported in DT but I'm not sure
about camera.

Cc Mike and Igor.

-- 
Regards,

Sakari Ailus
sakari.ailus@iki.fi
