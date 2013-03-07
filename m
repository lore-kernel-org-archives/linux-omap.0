From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [RFC PATCH 3/4] USB: OMAP: move omap-otg out from isp1301_omap
Date: Thu, 7 Mar 2013 19:59:07 +0200
Message-ID: <20130307175907.GD14552@blackmetal.musicnaut.iki.fi>
References: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
 <1362667221-30659-4-git-send-email-aaro.koskinen@iki.fi>
 <20130307145158.GE16577@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130307145158.GE16577-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Mar 07, 2013 at 04:51:59PM +0200, Felipe Balbi wrote:
> why is this otg_dev even needed ? Can you refresh my memory ?

If you want to handle OTG controller interrupt you need it... Though looks
like tahvo does not really need it, and it can be disabled.

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
