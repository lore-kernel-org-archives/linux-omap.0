From: Pavel Machek <pavel@ucw.cz>
Subject: Re: bluetooth: Add hci_h4p driver
Date: Thu, 18 Dec 2014 20:31:53 +0100
Message-ID: <20141218193153.GA27832@amd>
References: <20141213223727.GA13894@amd>
 <1418637710.4443.11.camel@linux-0dmf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418637710.4443.11.camel@linux-0dmf.site>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, marcel@holtmann.org
List-Id: linux-omap@vger.kernel.org

Hi!

> > +	h4p_simple_send_frame(info, skb);
> > +
> > +	if (!wait_for_completion_interruptible_timeout(&info->init_completion,
> > +						       msecs_to_jiffies(1000))) {
> > +		printk("h4p: negotiation did not return\n");
> 
> Memory leak in the error case

And memory leak in the normal case, too, no? Fixed.

> > +	case H4_ACL_PKT:
> > +		acl_hdr = (struct hci_acl_hdr *)skb->data;
> > +		retval = le16_to_cpu(acl_hdr->dlen);
> 
> Could you explain, why only this needs endianness converted?

This one is 16 bit, the others I checked are 8 bit.

> > +static void h4p_rx_tasklet(unsigned long data)
> > +{
> > +	u8 byte;
> > +	struct h4p_info *info = (struct h4p_info *)data;
> > +
> > +	BT_DBG("tasklet woke up");
> > +	BT_DBG("rx_tasklet woke up");
> 
> Isn't this a bit redundant?

Fixed.

> > +	struct sk_buff *skb;
> > +	struct h4p_info *info = (struct h4p_info *)data;
> > +
> > +	BT_DBG("tasklet woke up");
> > +	BT_DBG("tx_tasklet woke up");
> 
> Doubled?

Fixed.

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
