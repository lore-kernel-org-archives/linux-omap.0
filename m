From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/8] ti816evm: Add support for musb interface
Date: Mon, 12 Dec 2011 10:48:23 -0800
Message-ID: <20111212184822.GD32251@atomide.com>
References: <1318332369-9732-1-git-send-email-ajay.gupta@ti.com>
 <1318332369-9732-4-git-send-email-ajay.gupta@ti.com>
 <4E9431DB.3070600@compulab.co.il>
 <19F8576C6E063C45BE387C64729E739404ECCE5650@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECCE5662@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404ECCE5662-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "Pedanekar, Hemant" <hemantp-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Gupta, Ajay Kumar <ajay.gupta-l0cyMroinI0@public.gmane.org> [111011 09:33]:
> Hi,
> > > > Adding musb support in ti816 EVM board file.
> > > >
> > > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> > > > Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
> > > > Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > >
> > > This patch can result in a merge conflict, therefore I think
> > > this one should be taken through Tony's tree.
> > >
> > > Also you should work together with Hemant Pedanekar and
> > > someone of you should rebase on top of the other otherwise
> > > one of the patches (yours or Hemant's) possibly will not apply.
> > 
> > Ok sure. I will submit the patches (v5) after creating it on top of
> > Hemant's and Vaibhav's patches.
> 
> Here is the v5 of this patch created against latest Hemant's patch set.

Applying into musb branch.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
