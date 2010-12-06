From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH v3 6/7] omap3: Export omap3isp platform device
 structure
Date: Mon, 6 Dec 2010 11:32:13 -0800
Message-ID: <20101206193213.GN8345@atomide.com>
References: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1290653678-15556-7-git-send-email-laurent.pinchart@ideasonboard.com>
 <20101125070241.GX2468@legolas.emea.dhcp.ti.com>
 <201011251218.00331.laurent.pinchart@ideasonboard.com>
 <20101125112311.GV2468@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101125112311.GV2468@legolas.emea.dhcp.ti.com>
Sender: linux-media-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [101125 03:13]:
> Hi,
> 
> On Thu, Nov 25, 2010 at 12:17:59PM +0100, Laurent Pinchart wrote:
> >>pass platform_data as an argument to this call ? Then remove the static
> >>inline and export this one ?
> >
> >Yes indeed, why ? :-)
> >
> >I guess things like that are difficult to spot when you've had your nose on
> >the code for too long. Thanks for the review, I'll fix this.
> 
> no problem :-)

Can you please also grep to make sure there are no other EXPORT_SYMBOL
being added to arch/arm/*omap*/ code in these patches?

Thanks,

Tony
