From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v4 3/3] omap3isp: Configure CSI-2 phy based on platform
 data
Date: Sat, 13 Oct 2012 14:14:15 +0300
Message-ID: <20121013111415.GU14107@valkosipuli.retiisi.org.uk>
References: <20121010200115.GO14107@valkosipuli.retiisi.org.uk>
 <1349899302-9041-3-git-send-email-sakari.ailus@iki.fi>
 <2856409.8kZuhLNs9q@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2856409.8kZuhLNs9q@avalon>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 11, 2012 at 01:34:30AM +0200, Laurent Pinchart wrote:
> On Wednesday 10 October 2012 23:01:42 Sakari Ailus wrote:
> > Configure CSI-2 phy based on platform data in the ISP driver. For that, the
> > new V4L2_CID_IMAGE_SOURCE_PIXEL_RATE control is used. Previously the same
> > was configured from the board code.
> > 
> > This patch is dependent on "omap3: Provide means for changing CSI2 PHY
> > configuration".
> 
> Is it still ?

Not anymore. It depends on the previous patch (used to be for linux-omap
instead) so I'll remove that statement.

Regards,

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
