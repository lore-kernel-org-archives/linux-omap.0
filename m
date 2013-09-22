From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
Date: Sun, 22 Sep 2013 12:58:17 -0400
Message-ID: <20130922165817.GD30946@htj.dyndns.org>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379595943-14622-9-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1379595943-14622-9-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 19, 2013 at 04:05:36PM +0300, Roger Quadros wrote:
> From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> 
> Some platforms have a PHY hooked up to the
> SATA controller. The PHY needs to be initialized
> and powered up for SATA to work. We do that
> using the PHY framework.
> 
> [Roger Q] Cleaned up.
> 
> CC: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Looks okay to me although I don't know whether everyone using
ahci_platform would be happy with requiring phy.  Sergei, does this
look good to you?

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
