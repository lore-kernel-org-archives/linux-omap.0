From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v7 09/10] usb: dwc3: omap: manage "usb_otg_ss_refclk960m"
 clock
Date: Mon, 7 Oct 2013 11:19:32 +0300
Message-ID: <52526E94.7080605@ti.com>
References: <1379508542-22389-1-git-send-email-rogerq@ti.com> <1379508542-22389-10-git-send-email-rogerq@ti.com> <52403E02.4070208@ti.com> <20131002131113.GM1476@radagast> <524C22A1.30200@ti.com> <20131003122941.GD3230@radagast> <524D8516.8000107@ti.com> <20131003154144.GA18189@kroah.com> <524E9C70.8050303@ti.com> <20131004132329.GA25648@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59588 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871Ab3JGIUP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Oct 2013 04:20:15 -0400
In-Reply-To: <20131004132329.GA25648@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: balbi@ti.com, bcousson@baylibre.com, tony@atomide.com, george.cherian@ti.com, kishon@ti.com, bigeasy@linutronix.de, sergei.shtylyov@cogentembedded.com, thomas.langer@lantiq.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/04/2013 04:23 PM, Greg KH wrote:
> On Fri, Oct 04, 2013 at 01:46:08PM +0300, Roger Quadros wrote:
>> Greg,
>>
>> On 10/03/2013 06:41 PM, Greg KH wrote:
>>> On Thu, Oct 03, 2013 at 05:54:14PM +0300, Roger Quadros wrote:
>>>> On 10/03/2013 03:29 PM, Felipe Balbi wrote:
>>>>> Hi,
>>>>>
>>>>> On Wed, Oct 02, 2013 at 04:41:53PM +0300, Roger Quadros wrote:
>>>>>> On 10/02/2013 04:11 PM, Felipe Balbi wrote:
>>>>>>> On Mon, Sep 23, 2013 at 04:11:30PM +0300, Roger Quadros wrote:
>>>>>>>> Hi Felipe,
>>>>>>>>
>>>>>>>> On 09/18/2013 03:49 PM, Roger Quadros wrote:
>>>>>>>>> "usb_otg_ss_refclk960m" is an optional functional clock to the
>>>>>>>>> UBS_OTG_SS module. So manage it in the driver.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Just realized that "usb_otg_ss_refclk960m" is in fact functional clock to the 
>>>>>>>> PHY and not USB_OTG_SS module. The name is misleading.
>>>>>>>>
>>>>>>>> So please ignore patch 9 and 10.
>>>>>>>
>>>>>>> ignored. All others are fine, right ?
>>>>>>>
>>>>>> Yes. But I might have to rebase this on top of Phy framework stuff.
>>>>>
>>>>> alright, Greg already took the PHY framework, so maybe we need to just
>>>>> give him my Acked-by and he takes the patches directly as I don't have
>>>>> PYH framework.
>>>>>
>>>> OK. I'll resend this series to Greg in a while.
>>>
>>> It looks like you did, but forgot Felipe's ack :(
>>>
>> I was under the impression that Felipe will explicitly give his Ack there.
>> Should I resend with his Acked-bys?
> 
> No need, I took the patches yesterday, you should have seen the
> automated emails, right?
> 
Thanks. Yes, I got the automated e-mails.

cheers,
-roger
