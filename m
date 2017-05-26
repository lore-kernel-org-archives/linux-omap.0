From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] Enable Mailboxes for AM57xx IDKs
Date: Fri, 26 May 2017 08:46:39 -0700
Message-ID: <20170526154639.GD3717@atomide.com>
References: <20170519204742.1563-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170519204742.1563-1-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [170519 13:51]:
> Hi Tony,
> 
> This series enables the mailbox nodes to be used for communicating with
> the DSPs and IPUs on AM57xx IDKs using IPC 3.x. The mailbox nodes themselves
> were already defined/added before for other DRA7 boards, and these patches
> simply enable the respective nodes for the IDKs.
> 
> Patches are based on 4.12-rc1 and are intended for the 4.13 merge
> window.

Applying into omap-for-v4.13/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
