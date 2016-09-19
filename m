From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] usb: musb: Fix unbalanced platform_disable
Date: Mon, 19 Sep 2016 15:41:50 -0700
Message-ID: <20160919224149.3msqxiv24ofwjz4c@atomide.com>
References: <20160912153947.k4gnggur6usyujii@atomide.com>
 <14745757.ahNt4Zeunj@avalon>
 <20160918151901.k7go65s4jauldxcl@atomide.com>
 <2377851.ZR7UYeyr7h@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2377851.ZR7UYeyr7h@avalon>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [160919 13:35]:
> On Sunday 18 Sep 2016 08:19:02 Tony Lindgren wrote:
> > > [    5.711303] [<c0872788>] (_raw_spin_unlock_irqrestore) from
> > > [<c069b260>]
> > > (musb_gadget_queue+0x128/0x4ac)
> > > [    5.711303] [<c069b260>] (musb_gadget_queue) from [<c06a9ae4>]
> > > (usb_ep_queue+0x38/0x1d4)
> > > [    5.729766] [<c06a9ae4>] (usb_ep_queue) from [<c06aba40>]
> > > (rx_submit+0xc8/0x19c)
> > > [    5.737548] [<c06aba40>] (rx_submit) from [<c06abb90>]
> > > (rx_fill+0x7c/0xa0) [    5.737548] [<c06abb90>] (rx_fill) from
> > > [<c06abbdc>] (eth_start+0x28/0x48) [    5.751983] [<c06abbdc>]
> > > (eth_start) from [<c06abe7c>] (eth_open+0x6c/0x7c) [    5.751983]
> > > [<c06abe7c>] (eth_open) from [<c0778c2c>]
> > > (__dev_open+0x9c/0x104)
> > 
> > This could be something else though. Care to email me your .config, maybe
> > this is related to legacy g_ether being built in?
> 
> Sure, please find it attached. The legacy g_ether is indeed built-in, that's 
> what I use to boot over nfsroot.

OK, I think g_ether may have issues in general..

I mostly test with configfs based gadgets and shell script as then I can
test load/configure/connect/disconnect/unconfigure/unload easily :)

> > Anyways, please also give the following patch a try.
> 
> I've tested the patch and if fixes the original problem. Warm reboots are 
> still broken though.

No luck here with your .config a try with my pandaboard es against v4.8-rc7
plus the patch I posted on Sunday. It reboots with no errors for me with
NFSroot. Do you do something other than just reboot?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
