From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] omap: beagle: add support for wl1271 on the board
 file
Date: Thu, 23 Sep 2010 15:50:01 +0300
Message-ID: <20100923125001.GS4580@legolas.emea.dhcp.ti.com>
References: <1285230003-5065-1-git-send-email-luciano.coelho@nokia.com>
 <20100923114528.GL4580@legolas.emea.dhcp.ti.com>
 <1285244253.3231.75.camel@chilepepper>
 <20100923122048.GO4580@legolas.emea.dhcp.ti.com>
 <AANLkTikN37=O8rnFkBfuJex25DdNPEieioL5jgenpoYY@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikN37=O8rnFkBfuJex25DdNPEieioL5jgenpoYY-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Sep 23, 2010 at 07:46:33AM -0500, Ohad Ben-Cohen wrote:
>> irq = platform_get_irq(pdev, 0);
>
>only problem is that there is no platform device involved here :)

heh, I thought the omap_beagle_vwlan_device was it, but it's only for
the regulator :-p

nevermind.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
