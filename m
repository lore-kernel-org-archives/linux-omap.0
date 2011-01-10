From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] musb: move usb_add_hcd to the core init code from gadget code (v2)
Date: Mon, 10 Jan 2011 04:38:47 -0800 (PST)
Message-ID: <898333.24180.qm@web180304.mail.gq1.yahoo.com>
References: <4D2AF1EE.8010105@heeltoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D2AF1EE.8010105-k3bCrp9g88tBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, Brad Parker <brad-k3bCrp9g88tBDgjK7y7TUQ@public.gmane.org>
Cc: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ricardo.salveti-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


> With this patch, host mode works.

What about OTG and gadget modes?

The MUSB hardware is flakey with respect to
those init issues.  Re-ordering host vs gadget
init has been a good way to waste a few months,
for anyone who has a few to waste.  (And a
better way to waste them for folk who do NOT
but just need to stay on schedule.)  One learns
quickly that the Mentor IP follows some other
state machine than the USB-OTG says, but even their
docs don't help uncover whatever init model they
are trying  to follow.


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
