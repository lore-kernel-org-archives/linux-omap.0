From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path
Date: Thu, 23 Sep 2010 11:10:10 +0300
Message-ID: <20100923081010.GD4580@legolas.emea.dhcp.ti.com>
References: <1285201846-26599-1-git-send-email-hemahk@ti.com>
 <20100923064910.GF2563@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863D9EB@dbde02.ent.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D9EB-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Sep 23, 2010 at 02:59:29AM -0500, Kalliguddi, Hema wrote:
>Oh! It should be core. Now I understand why save/restore counts were not matching with
>Core-off counts.
>Thanks for pointing this out.

ok, please be more careful next time, we could have committed without
noticing this :-)

>>if plat->save_context is 1, then set it to 1 ???
>>
>This is mistake. I messed it up. I had another flag
>for offmode support, which I removed later.
>i will correct this.

ok.

>>>@@ -2443,10 +2447,13 @@ static int musb_resume_noirq(struct devi
>>> {
>>> 	struct platform_device *pdev = to_platform_device(dev);
>>> 	struct musb	*musb = dev_to_musb(&pdev->dev);
>>
>>just now I notice these, hah, funny :-p pdev isn't even
>>needed. Has been
>>there for quite a while I believe.
>>
>>Commit 48fea965 should have changed that line, but that's ok, we will
>>clean it later.
>>
>Yehh :-)
>If it is OK, I can clean it up with this patch only.

nope, it's not part of this patch. leave it as is for now.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
