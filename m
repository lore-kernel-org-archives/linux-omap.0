From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv8 2/5] OMAP: hwmod/device : add omap_device_reset to
 reset all the hwmods in the device
Date: Fri, 16 Dec 2011 01:42:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160141510.12660@utopia.booyaka.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com> <1323773758-6375-3-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1323773758-6375-3-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi

On Tue, 13 Dec 2011, Shubhrajyoti D wrote:

>     Add a function omap_device_reset() to reset all the hwmods in the hwmod device.
>     This is intended to be used by device drivers to reset all the hwmods in the
>     device. This is needed to support some ips like i2c which  may have to do reset
>     in error paths or in errata.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Thanks, queued for 3.3.

- Paul
