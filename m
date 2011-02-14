From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v6 02/10] omap3: Remove unusued ISP CBUFF resource
Date: Mon, 14 Feb 2011 14:31:06 +0200
Message-ID: <20110214123106.GW2549@legolas.emea.dhcp.ti.com>
References: <1297686097-9804-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1297686097-9804-3-git-send-email-laurent.pinchart@ideasonboard.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1297686097-9804-3-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 14, 2011 at 01:21:29PM +0100, Laurent Pinchart wrote:
> From: Sergio Aguirre <saaguirre@ti.com>
> 
> The ISP CBUFF module isn't use, its resource isn't needed.
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

it's unused but it's there right ? what's the problem in keeping it ?
maybe you'd like to add name for the resources as well, there are many
of them and keeping the order correct might be difficult. You can move
to platform_get_resource_byname() on drivers.

-- 
balbi
