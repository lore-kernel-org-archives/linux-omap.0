From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv8 1/5] OMAP3+: HWMOD: Add the default clockactivity for
 I2C
Date: Fri, 16 Dec 2011 01:35:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160135060.12660@utopia.booyaka.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com> <1323773758-6375-2-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1323773758-6375-2-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 13 Dec 2011, Shubhrajyoti D wrote:

> For I2C clockactivity field is added for OMAP3 and OMAP4 that defines how the
> interface (OCP) and functional (system) clocks behave when the I2C module is
> idle.
> 
> The configuration of the clock activity bit field (per TRM) is as follows:
> 0x0: Both clocks can be cut off
> 0x1: Only OCP clock must be kept active; system clock
>      can be cut off
> 0x3: Both clocks must be kept active
> 0x2: Only system clock must be kept active; OCP clock
>      can be cut off
> 
> The patch makes 0x2(CLOCKACT_TEST_ICLK) the default for OMAP3 and OMAP4.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>

Thanks, queued for 3.3.


- Paul
