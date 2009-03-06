From: "Woodruff, Richard" <r-woodruff2-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Fri, 6 Mar 2009 08:54:57 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037B646058@dlee02.ent.ti.com>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com>
 <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ari Kauppi <Ext-Ari.Kauppi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> I have observed some Spurious IRQ's for I2C1 when all kernel hacking options
> (and thus LOCKDEP) are disabled.
>
> Applying Richard Woodruff's 'I2C bug fixes for L-O and L-Z' seems to help
> but IRQF_DISABLED is needed for proper behaviour.

I only submitted on l-o list for information and comment.

They need to be submitted on i2c list and to Ben to get added.

Thanks for the additional positive feed back and fix.

Regards,
Richard W.
