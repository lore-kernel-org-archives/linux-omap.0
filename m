From: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Thu, 12 Mar 2009 13:33:45 +0200
Message-ID: <1236857625.6478.163.camel@kauppi-desktop>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com>
	 <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com>
	 <20090310005222.GE19758@fluff.org.uk>
	 <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com>
	 <alpine.DEB.2.00.0903111803170.26959@utopia.booyaka.com>
	 <1236839178.6478.40.camel@kauppi-desktop>
	 <alpine.DEB.2.00.0903120041020.26959@utopia.booyaka.com>
	 <1236844467.6478.103.camel@kauppi-desktop>
	 <alpine.DEB.2.00.0903120356230.26959@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.0903120356230.26959-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2009-03-12 at 10:58 +0100, ext Paul Walmsley wrote:
> On Thu, 12 Mar 2009, Kauppi Ari (EXT-Ixonos/Oulu) wrote:
> 
> > My process was:
> > 
> > 1) Take 2.6.28-based kernel on custom OMAP3430ES3.0 hardware with
> > CONFIG_DEBUG_LOCKDEP enabled. There are no spurious interrupts and
> > everything works.
> > 
> > 2) Disable CONFIG_DEBUG_LOCKDEP and all other kernel debugging options.
> > Spurious interrupts start to appear on several IRQs, especially with IRQ
> > 56 (I2C1).
> > 
> > 3) Apply Richard's patch. All spurious interrupts for IRQ 56 are gone
> > but frequency of others increase.
> > 
> > 4) Set IRQF_DISABLED in i2c-omap and the frequency of other spurious
> > interrupts decreases considerably. However, I'm starting to realize that
> > the real problem is probably elsewhere.
> > 
> > My test setup is pretty systematic, it does not have any user
> > interaction in it. I have a relay controlling the power to the device
> > and have taken logs of about 12000 boots with different kernel options
> > and patches applied.
> 
> Thanks for the details.  Can you extract the list of spurious IRQ warnings 
> that you're getting, and post them?  I suspect that, like I2C, many of the 
> driver ISRs are not reading back the device interrupt status registers 
> after they clear them.

Sure,

Here is "grep -hoa 'write for irq.*' *.log | sort | uniq -c" from the
most problematic case (step 2 in above process). It should be noted that
the messages are always in pairs, ie. there are two consecutive messages
in the logs with only microseconds between them. I have divided the
counts reported by uniq -c by two in the list below.

Boot count: 6628
      1 write for irq 12
      1 write for irq 25
      1 write for irq 33
     10 write for irq 37
  29532 write for irq 56
     12 write for irq 67
      1 write for irq 71
    281 write for irq 73
    114 write for irq 83
    407 write for irq 86

I have also heard that with other use cases irq 17 and 21 should be in
the list, too. The single ones from 12,25,33,71 are probably just
one-offs and should not be taken too seriously, 37/67 are corner cases
but 73/83/86 are definitely valid measurements.

Best regards,

--
Ari
