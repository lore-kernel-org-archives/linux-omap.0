From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 0/3] [OMAP:I2C] Small bug fixes and errata 1.153
Date: Thu, 30 Jul 2009 00:51:05 +0100
Message-ID: <20090729235105.GD8850@fluff.org.uk>
References: <CD8CC2B65FEE304DA95744A5472698F202958D2F85@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F202958D2F85-UmuGNrFEPrGIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 21, 2009 at 10:13:20AM -0500, Sonasath, Moiz wrote:
> 
> This patch includes the following:
> - Bug in reading the RXSTAT/TXSTAT values from I2C_BUFFSTAT
> - In case of a NACK|ARDY|AL interrupts return from the ISR
> - OMAP3430 silicon errata 1.153

hi, in future it would be better to prefix the patch subjects with
i2c-omap (IE, the driver name).
 
> Signed-off-by: Moiz Sonasath<m-sonasath-l0cyMroinI0@public.gmane.org> 
                              ^ space to go in here.
> Signed-off-by: Vikram pandita<vikram.pandita-l0cyMroinI0@public.gmane.org>
> Moiz Sonasath (3):
>   [OMAP:I2C]Bug in reading the RXSTAT/TXSTAT values from the
>     I2C_BUFFSTAT register
>   [OMAP:I2C]In case of a NACK|ARDY|AL return from the ISR
>   [OMAP:I2C]OMAP3430 Silicon Errata 1.153
> 
>  drivers/i2c/busses/i2c-omap.c |   42 +++++++++++++++++++++++++++++++++-------
>  1 files changed, 34 insertions(+), 8 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
