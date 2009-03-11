From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Thu, 12 Mar 2009 01:59:10 +0200
Message-ID: <20090311235908.GC19038@gandalf>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com> <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com> <20090310005222.GE19758@fluff.org.uk> <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0903111741270.26959-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Ari Kauppi <Ext-Ari.Kauppi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 11, 2009 at 05:55:50PM -0600, Paul Walmsley wrote:
> Ben's right, there shouldn't be any need for this.  This patch could cause
> some unnecessary interrupt service latency.

That's not what Thomas Gleixner thinks. How about the possibility of
stack overflow ?

According to Thomas (and Ingo, I'd say) all drivers should call
request_irq() with IRQF_DISABLED and that's gonna be true as soon as the
threaded irq handler support gets merged, if I'm not wrong.

-- 
balbi
