From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH 2/2] USB: musb: omap2430: add mode change from A to B
Date: Thu, 22 Jul 2010 19:40:44 +0300
Message-ID: <4C48748C.8040307@felipebalbi.com>
References: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com> <1268648622-28529-2-git-send-email-Hui.Wang@windriver.com> <877hknwnrb.fsf@anar.kanru.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <877hknwnrb.fsf-ONHucydYG54+Yz5RL6G0bA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kan-Ru Chen <kanru-suFqJ7M7tPnYtjvyW6yDsg@public.gmane.org>
Cc: Wang Hui <Hui.Wang-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/22/2010 06:16 PM, Kan-Ru Chen wrote:
> Just curious about how to do this in a more automatic way.
> 
> I think setup a daemon to monitor the musb_hdrc mode and try to alter
> it's state via sysfs interface will work, but it may be error prone and
> not always desirable solution.
> 
> Can we query the id pin state periodically in the kernel and change to
> corresponding role?

the transceiver has an interrupt for id pin changes. You can use that
instead of polling.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
