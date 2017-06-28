From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: usb-related linux-next boot failures
Date: Wed, 28 Jun 2017 03:30:14 -0700
Message-ID: <20170628103014.GC3730@atomide.com>
References: <0d1a491c-41c4-a02d-cdf8-e1a95a1fe989@ti.com>
 <20170628045543.GA28759@kroah.com>
 <87r2y45x97.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87r2y45x97.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Carlos Hernandez <ceh-l0cyMroinI0@public.gmane.org>, "lcpd_connectivity-uAqBSO/uNfhBDgjK7y7TUQ@public.gmane.org - Linux Core Product Development -
        Connectivity" <lcpd_connectivity-uAqBSO/uNfhBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

 Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> [170628 01:32]:
> Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> writes:
> > On Tue, Jun 27, 2017 at 02:28:56PM -0400, Carlos Hernandez wrote:
> >> Still seeing AM57xx/DRA72/DRA7x usb-related boot failures on linux-next...
> >
> > Is this a regression?  If so, any specific commit that caused it?
> 
> I did ask for a bisection last time but nobody from TI replied ;-)
> 
> https://marc.info/?i=87h8zi4gmx.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
> 
> Can't really help without bisection logs :-)

Seems this warning got add with 04c848d39879 ("genirq: Warn when
IRQ_NOAUTOEN is used with shared interrupts"). The fix is to get
rid of IRQ_NOAUTOEN and enable_irq for a shared interrupt. Hard
to say as the warning line does not match the version of next I
have so this should be verified.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
