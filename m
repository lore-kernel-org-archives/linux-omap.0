From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 3/4] ARM: dts: DRA7: Add timer12 node
Date: Tue, 6 Oct 2015 00:52:09 -0700
Message-ID: <20151006075209.GH23801@atomide.com>
References: <1444087704-1429-1-git-send-email-s-anna@ti.com>
 <1444087704-1429-4-git-send-email-s-anna@ti.com>
 <87y4fgesbz.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87y4fgesbz.fsf-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [151005 17:51]:
> 
> according to Tony we should avoid using status at all for in-SoC
> devices.
> 
> Tony, can you confirm I understood you correctly ?

Yes. With status = "disabled" kernel completely ignores the
device and struct device is not created at all even with the
device being there. In general we're better off trying to
probe the device and idle it.

The only time we really want to mark something with
status = "disabled" is if some coprocessor firmware is
using that device and the kernel should not touch it at
all.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
