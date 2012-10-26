From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 2/5] drivers: usb: otg: make twl6030_usb as a comparator
 driver to omap_usb2
Date: Fri, 26 Oct 2012 19:57:31 +0200
Message-ID: <508ACF0B.60808@ti.com>
References: <1346943430-18236-1-git-send-email-kishon@ti.com> <1346943430-18236-3-git-send-email-kishon@ti.com> <CAH+eYFAj1ecvmiJCu8QDCr3LjHT5eXjq6zsZMiVRPROoWcDuNQ@mail.gmail.com> <CAAe_U6K1RXA3b5u9WvE=2VoXym9Vj3KM7c0J27jKz+2KrV4tsg@mail.gmail.com> <CAH+eYFAhVE8cAte2PFk3jinV9n3m+eDLtE43QxzRXMScnFGcrA@mail.gmail.com> <508AA94B.10504@ti.com> <508AAA85.6070905@ti.com> <alpine.DEB.2.00.1210261750430.7573@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57675 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932894Ab2JZR5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 13:57:52 -0400
In-Reply-To: <alpine.DEB.2.00.1210261750430.7573@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Roger Quadros <rogerq@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Rabin Vincent <rabin@rab.in>, tony@atomide.com, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org

Hi Paul,

On 10/26/2012 07:54 PM, Paul Walmsley wrote:
> On Fri, 26 Oct 2012, Benoit Cousson wrote:
> 
>> On 10/26/2012 05:16 PM, Roger Quadros wrote:
>>
>>> I still can't get musb to work on 3.7-rc2. Apparently it is still
>>> missing the patches from Benoit's for_3.7/dts_part2.
>>>
>>> Maybe I just need to wait for it to be merged?
>>
>> They are now in a for_3.8/dts. Unfortunately, one patch that was adding
>> ctrl_module address in the USB data was rejected and thus I'm not sure
>> it will work without that.
> 
> For v3.7-rc timeframe, looks like it's waiting on an ack from you:
> 
> http://www.spinics.net/lists/arm-kernel/msg201028.html

Oups, I missed that one. But I thought Roger was mentioning the DT patch
and not that one.

Anyway, I will answer to Tony. Thanks for the reminder Paul.

Regards,
Benoit
