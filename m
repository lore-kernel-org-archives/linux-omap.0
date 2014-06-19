From: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Subject: Re: Gadget regression with enabling of MUSB babble interrupt handling
Date: Thu, 19 Jun 2014 12:08:48 +0200
Message-ID: <53A2B6B0.2040804@zonque.org>
References: <20140619095655.GA29055@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140619095655.GA29055-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

(+ George)

On 06/19/2014 11:56 AM, Tony Lindgren wrote:
> Looks like commit ca88fc2ef0d7 (usb: musb: add a work_struct
> to recover from babble errors) causes MUSB gadgets to stop
> enumerating at least on omap3. Reverting the the commit fixes
> the issue.

Hmm, so do you see babble errors occuring?

Also, there are some more patches for musb and babble error recovery on
the usb list, namely the ones starting here in v6:

  http://marc.info/?l=linux-usb&m=140109627505065&w=4

Care to give them a try?


Thanks,
Daniel


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
