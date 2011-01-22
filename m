From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: 2.6.38-rc1-git1 musb undefined references
Date: Sat, 22 Jan 2011 19:35:08 +0200
Message-ID: <20110122173508.GB14774@legolas.emea.dhcp.ti.com>
References: <4D386129.4080206@blueyonder.co.uk>
 <20110121032236.GB2448@legolas.emea.dhcp.ti.com>
 <4D3921CF.9070505@blueyonder.co.uk>
 <4D3B01CD.9030404@blueyonder.co.uk>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D3B01CD.9030404-QgLWrMLu8clzjhtm8Ag3mw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sid Boyce <sboyce-QgLWrMLu8clzjhtm8Ag3mw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sat, Jan 22, 2011 at 04:11:57PM +0000, Sid Boyce wrote:
> "make omap2plus_defconfig" corrected the problem, kernel builds up to
> 2.6.38-rc1-git3 completed.

Thanks, I'll try to cleanup the DMA stuff for next merge window.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
