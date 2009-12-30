From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [patch-v2.6.34 7/9] usb: musb: use only clk framework for clk
 handling
Date: Wed, 30 Dec 2009 13:53:32 +0200
Message-ID: <1262174012.28789.178.camel@gandalf>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
	 <1262127567-15202-8-git-send-email-felipe.balbi@nokia.com>
	 <4B3B3720.9070205@ru.mvista.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B3B3720.9070205-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, 2009-12-30 at 14:18 +0300, Sergei Shtylyov wrote:
>    Why always "ick"?! Do you think OMAPs are the only boards using MUSB 
> out there?

err, I'm afraid you have to read more about clock framework. The clock
name should not matter when you issue clk_get(). I used the shortest
name that came to my mind. could've been "usb", "usb_clock",
"musb_otg_default_clock". It doesn't matter.


-- 
balbi

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
