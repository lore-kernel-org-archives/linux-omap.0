From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] musb: Add new fifo table for a OMAP3 errata
Date: Mon, 21 Dec 2009 12:46:47 +0200
Message-ID: <20091221104647.GF30969@nokia.com>
References: <1261387769-20247-1-git-send-email-ajay.gupta@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AF94@dbde02.ent.ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AF94-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 21, 2009 at 11:12:16AM +0100, ext Gadiyar, Anand wrote:
>Gupta, Ajay Kumar wrote:
>>
>> We have observed MSC data read corruption when USB LAN device is
>> also connected and it's interface is up.
>>
>> Silicon team has confirmed an errata where in all the active
>> transfers should use FIFO space either in first 8K or next 8K.
>> So far we have observed the issue in above use case scenario.
>>
>> As a workaround to it, adding a new FIFO config (5) fitting well
>> within first 8K which can be used for such use cases.
>>
>> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>
>Long term, do you think the board files should define the
>the FIFO configuration table that they want to use (instead of
>having different options in musb_core.c)?

I think so too and even sent a patch long time about doing that but it 
got lost.

I recall Dave wanted to have a default mode on musb_core.c though.

>Acked-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

I'm taking this one

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
