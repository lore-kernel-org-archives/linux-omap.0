From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Thu, 12 Mar 2009 00:46:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903120041020.26959@utopia.booyaka.com>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com>  <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com>  <20090310005222.GE19758@fluff.org.uk>  <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com>
 <alpine.DEB.2.00.0903111803170.26959@utopia.booyaka.com> <1236839178.6478.40.camel@kauppi-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1236839178.6478.40.camel@kauppi-desktop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Ari,

On Thu, 12 Mar 2009, Kauppi Ari (EXT-Ixonos/Oulu) wrote:

> I was seeing some Spurious irq's for the I2C1 (IRQ 56).
> 
> I'm aware of flushing posted write and the very first thing I tried was
> to use read-after-write for OMAP_I2C_STAT_REG (in all applicable
> places). However, it didn't make any difference.

Strange.

> Applying Richard Woodruff's patch (mentioned earlier in thread) that
> disables dev->b_hw hack for 3430 (STT/STP bits written together) and
> double clears ARDY fixed the spurious IRQ issues for I2C1.
> 
> However, with the STT/STP+ARDY patch I was seeing Spurious interrupts
> all over the place and the IRQF_DISABLED in i2c-omap seemed to tame them
> quite well. I do agree that my approach might not be the proper one in
> long term.

Could you clarify this?  Do Richard's patches fix the spurious IRQs, or 
cause spurious interrupts to appear?


regards,

- Paul
