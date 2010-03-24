From: Viral Mehta <Viral.Mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
Subject: RE: USB on omap2430
Date: Wed, 24 Mar 2010 15:06:28 +0530
Message-ID: <70376CA23424B34D86F1C7DE6B997343017F5D5BE3@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <70376CA23424B34D86F1C7DE6B997343017F5D5BE1@VSHINMSMBX01.vshodc.lntinfotech.com>,<5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


________________________________________
From: Gadiyar, Anand [gadiyar-l0cyMroinI0@public.gmane.org]
Sent: Wednesday, March 24, 2010 2:46 PM
To: Viral Mehta; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: RE: USB on omap2430

Viral Mehta wrote:
>>
>> I am working on OMAP2430 and for me with linux2.6.33, USB is
>> simply not working. Board is not even able to boot if I just
>> enable Host Support.
>

> Maybe someone on the linux-omap list would be able to help with
> this - so adding linux-omap to the cc.

> Are you using the 2430SDP or some other board? I don't think
> anyone has tried booting one of those with mainline kernels
> in a long time. Does the default config for your board work?

I am using OMAP2430SDP (4.0.1).
I started with omap_2430sdp_defconfig
As a side note, USB works fine with 2.6.14-V3 kernel taken from linux.omap.com

>Maybe we can help get this working. Can you enable CONFIG_DEBUG_LL
>and CONFIG_EARLY_PRINTK in your build, then add "earlyprintk" to
>your bootargs?

>> If there is a crash during boot-up, this will let us know.
Ok, I will do that.

>Also, do you know which transceiver you have on the board?
>(TWL4030 or ISP1504 or something else?)
No.

>> I am seeing some patches for OMAP2430 USB support since few days.
>> Anyone really tested USB on OMAP2430 hardware? Or any idea
>> whether it will work with head of linus tree or anything like that ?
>>

>I posted one such patch - to remove some pin muxing code that
>was under a CONFIG_ARCH_OMAP2430 macro - this code should not
>be in a generic driver. I did not test on an actual 2430 board
>because I don't have one.

The only intention behind asking that question was to know whether I am missing any patch which should have been applied on top of the kernel that I am using. I am using 2.6.33 (linux-2.6.33.tar.bz2).

- Anand

______________________________________________________________________

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
