From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5] usb: musb: Power management support
Date: Fri, 25 Feb 2011 12:39:30 +0200
Message-ID: <20110225103930.GD4190@legolas.emea.dhcp.ti.com>
References: <1298628663-27650-1-git-send-email-hemahk@ti.com>
 <20110225102112.GC4190@legolas.emea.dhcp.ti.com>
 <875afd9a6c1e7ccc61c7ff025fd57588@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <875afd9a6c1e7ccc61c7ff025fd57588-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Feb 25, 2011 at 03:56:46PM +0530, Hema Kalliguddi wrote:
> I tried to rebase and found that my hardware mod patches are not
> in for-next branch. So there will be some conflicts for patch 4 and 5.
> Is there any branch in which you have all the usb and platform changes
> merged?

I just built one, please use musb-hwmod-pm-runtime It has all your
recent patches plus a few extra ones.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
