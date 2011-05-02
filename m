From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: musb: omap2430: Fix retention idle on musb
 peripheral only boards
Date: Mon, 2 May 2011 12:29:28 +0300
Message-ID: <20110502092924.GN2529@legolas.emea.dhcp.ti.com>
References: <1303912957-10279-1-git-send-email-jhnikula@gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1303912957-10279-1-git-send-email-jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 27, 2011 at 05:02:37PM +0300, Jarkko Nikula wrote:
> Recent runtime pm and hwmod conversions for 2.6.39 broke the musb peripheral
> mode OMAP retention idle on boards where the board mode in struct
> musb_hdrc_platform_data is set to MUSB_PERIPHERAL.
> 
> These conversions changed the way how the OTG_SYSCONFIG register is
> configured and used in runtime. Before 2.6.39 smart standby/idle modes were
> activated statically in OTG_SYSCONFIG. Those modes allow that the musb is
> able to idle when peripheral device is not connected to host.
> 
> In 2.6.39 the OTG_SYSCONFIG is updated runtime depending on VBUS status.
> No standby/idle modes are used when device is connected and force
> standby/idle when disconnected.
> 
> Unfortunately VBUS disconnect event that handles the disconnect case lets
> the peripheral musb to idle only when board mode is MUSB_OTG. Fix this by
> checking the peripheral mode also.
> 
> Signed-off-by: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

applied, thanks

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
