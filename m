From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next: manual merge of the usb tree with the omap tree
Date: Wed, 11 Nov 2009 11:12:13 -0800
Message-ID: <20091111191213.GH24837@atomide.com>
References: <20091111193013.9a4bca3e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091111193013.9a4bca3e.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [091111 00:29]:
> Hi Greg,
> 
> Today's linux-next merge of the usb tree got a conflict in
> drivers/usb/host/ehci-omap.c between commit
> 7cb07f72711d3e10763ca7d7a9fcd7ac788aabf4 ("omap: ehci: Add platform init
> code") from the omap tree and commit
> 9e92239693d7010d2e710a445f46d6a738b09171 ("USB: host: ehci: introduce
> omap ehci-hcd driver") from the usb tree.
> 
> Both commits create this file but I used the omap tree version because
> commit ce491cf85466c3377228c5a852ea627ec5136956 ("omap: headers: Move
> remaining headers from include/mach to include/plat") from the omap tree
> moved one included header file (mach/usb.h -> plat/usb.h).

Oops, sorry. Looks like I accidentally included also drivers/usb/host/ehci-omap.c
as we were testing it in the linux-omap tree.

I'll drop the drivers/usb/host/ehci-omap.c part from my queue, it should get
integrated via Greg's queue. I'll just merge the platform init code.

Regards,

Tony
