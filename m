From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: fix enumeration after resume
Date: Tue, 6 Feb 2018 10:47:25 -0800
Message-ID: <20180206184725.GD21573@atomide.com>
References: <20180127083403.928-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180127083403.928-1-andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: b-liu-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [180127 08:34]:
> On dm3730 there are enumeration problems after resume.
> Investigation led to the cause that the MUSB_POWER_SOFTCONN
> bit is not set. If it was set before suspend (because it
> was enabled via musb_pullup()), it is set in
> musb_restore_context() so the pullup is enabled. But then
> musb_start() is called which overwrites MUSB_POWER and
> therefore disables MUSB_POWER_SOFTCONN, so no pullup is
> enabled and the device is not enumerated.

I just gave this patch a quick try and things seem to behave
for me from PM point of view:

Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Unrelated to this patch, I also noticed that we now somehow
higher idle power consumption initially when musb modules are
loaded. It used to idle after that but now to get things to
idle I had to plug and unplug a USB device once to the musb
port.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
