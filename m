From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH] USB: ehci-omap: Select USB_PHY
Date: Thu, 11 Apr 2013 15:02:08 +0200
Message-ID: <5166B450.1000404@ahsoftware.de>
References: <5166856C.3080906@ti.com> <20130411100435.GB14394@arwen.pp.htv.fi> <516695A4.2050804@ti.com> <20130411105557.GE14394@arwen.pp.htv.fi> <5166AFD2.4070108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5166AFD2.4070108@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Am 11.04.2013 14:42, schrieb Roger Quadros:
> On 04/11/2013 01:55 PM, Felipe Balbi wrote:

>> I would avoid 'select' completely and just update omap2plus_defconfig
>> adding those two as modules.
>>
> 
> OK, makes sense. I will update the patch to remove "select NOP_USB_XCEIV".

Sorry, but this just will end up with many users having broken configs
because of disabled stuff they don't know why they have to enable them.
And thus with a never ending stream of questions and thus with a needed
FAQ entry.

Regards,

Alexander
