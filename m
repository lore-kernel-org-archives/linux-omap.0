From: Harish Jenny K N <harish_kandiga-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: Gadget regression with u_ether in Linux next
Date: Sun, 18 Sep 2016 22:26:58 +0200
Message-ID: <35c40480-c076-7793-f873-5e1deaa66a93@mentor.com>
References: <20160916220355.w6whbd75eqegrz3q@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160916220355.w6whbd75eqegrz3q-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jim Baxter <jim_baxter-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

>>>>> On Saturday 17 September 2016 12:03 AM, Tony Lindgren wrote:

> Hi,
>
> Looks like commit c9ffc78745f8 ("usb: gadget: NCM: Protect dev->port_usb
> using dev->lock") causes hangs for me with Linux next.
>
> Reverting c9ffc78745f8 makes the issues go away, some more info below.
>
> Regards,
>
> Tony
Sorry. There was a mistake with the commit. spinlock not acquired in if (dev->wrap) condition was also being tried to get unlocked.

Please revert/remove the commit.

Thanks,
Harish
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
