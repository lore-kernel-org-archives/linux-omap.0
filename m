From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 2/4] usb: dwc3: add dual-role support
Date: Mon, 13 Jun 2016 11:25:00 +0300
Message-ID: <575E6DDC.1000604@ti.com>
References: <1465564650-27516-1-git-send-email-rogerq@ti.com>
 <1465564650-27516-3-git-send-email-rogerq@ti.com>
 <20160612091137.GE22054@shlinux2> <575E5C21.8040103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <575E5C21.8040103-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 13/06/16 10:09, Roger Quadros wrote:
> Peter,
> 
> On 12/06/16 12:11, Peter Chen wrote:
>> On Fri, Jun 10, 2016 at 04:17:28PM +0300, Roger Quadros wrote:
>>> Register with the USB OTG/DRD core. Since we don't support
>>> OTG yet we just work as a dual-role device even
>>> if device tree says "otg".
>>>
>>> Get ID and VBUS information from the OTG controller
>>> and kick the OTG state machine.
>>>
>>
>> Hi Roger,
>>
>> I can't apply it after rebase usb-next rc1 and felipe's testing/next.
>> How to apply it?
> 
> You just need to apply the series on Felipe's testing/next + this one patch
> http://article.gmane.org/gmane.linux.kernel/2240761

You can also use the below repo as balbi testing/next is a moving target

https://github.com/rogerq/linux/commits/for-v4.8/otg-drd-v11-core-dwc3-v7

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
