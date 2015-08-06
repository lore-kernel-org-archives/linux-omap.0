From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mailbox/omap: Add ti,mbox-send-noirq quirk to fix
 AM33xx CPU Idle
Date: Wed, 5 Aug 2015 23:29:23 -0700
Message-ID: <20150806062923.GN16878@atomide.com>
References: <1437166592-25378-1-git-send-email-d-gerlach@ti.com>
 <1437166592-25378-2-git-send-email-d-gerlach@ti.com>
 <20150805102840.GA16878@atomide.com>
 <55C22C8E.3000506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C22C8E.3000506-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [150805 08:35]:
> Hi Tony,
> 
> On 08/05/2015 05:28 AM, Tony Lindgren wrote:
> > * Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [150717 13:59]:
> >> --- a/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> >> +++ b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> >> @@ -75,6 +75,14 @@ data that represent the following:
> >>      Cell #3 (usr_id)  - mailbox user id for identifying the interrupt line
> >>                          associated with generating a tx/rx fifo interrupt.
> >>  
> >> +Optional Properties:
> >> +--------------------
> >> +- ti,mbox-send-noirq:   Quirk flag to allow the client user of this sub-mailbox
> >> +                        to send messages without triggering a Tx ready interrupt,
> >> +                        and to control the Tx ticker. Should be used only on
> >> +                        sub-mailboxes used to communicate with WkupM3 remote
> >> +                        processor on AM33xx/AM43xx SoCs.
> >> +
> > 
> > Hmm can't you do this just by setting a flag in the device driver
> > based on the compatible string?
> 
> We can't because there can be other users like PRUSS which will use a
> sub-mailbox in a regular fashion. The compatible serves the IP and there
> can be multiple sub-mailboxes underneath it, and this quirk is needed
> only on the one that's used by the WkupM3.

OK

> Do you have any comments on this?

Up to you guys then to figure out what property is used for it then.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
