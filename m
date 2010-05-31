From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: Fix board data to support device only, host  only and OTG roles.
Date: Mon, 31 May 2010 05:53:14 -0700 (PDT)
Message-ID: <177890.25654.qm@web180315.mail.gq1.yahoo.com>
References: <AANLkTin-Ud-BdQ3lcydqZx7Tb1YoBq05XCONeYqxWhZm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTin-Ud-BdQ3lcydqZx7Tb1YoBq05XCONeYqxWhZm-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Steve Sakoman <sakoman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



--- On Mon, 5/31/10, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Another issue is that OTG depends on PM, so if I build  PM-less kernel
> (PM is still more or less in development on OMAPs), Kconfig will only
> allow host or peripheral for musb, which doesn't match OTG selection
> in the board file, and the driver fails.

As Felipe partially explained:  OTG implies
HNP, and HNP requires suspending the USB link,
which requires some PM support...



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
