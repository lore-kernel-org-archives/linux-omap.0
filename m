From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v9 0/9] USB Host support for OMAP5 uEVM
Date: Tue, 11 Mar 2014 14:16:23 +0200
Message-ID: <531EFE97.1090202@ti.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com> <531ECDCB.4060700@ti.com> <20140311120259.GI21216@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140311120259.GI21216@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/11/2014 02:02 PM, Lee Jones wrote:
>>> Hi,
>>>
>>> This patchset brings up USB Host ports and Ethernet port on
>>> the OMAP5 uEVM board.
>>>
>>> It also does some cleanup with respect to DT clock binding
>>> for the mfd/omap-usb-host driver.
>>>
>>> Please queue these for -next.
>>>
>>> Lee,
>>>
>>> I've folded some platform data dependent patches with mfd patches
>>> so that they don't break functionality when applied individually.
>>> You can safely pull in all MFD patches (1 to 6).
>>>
>>> Tony & Benoit,
>>>
>>> Can you please accept patches 7, 8 and 9?
>>
>> Tony has already picked up 7,8 and 9 through omap-soc tree.
>>
>> Since you acked most patches except 5 and 6, are you fine if Tony takes
>> all the patches 1 to 4 in this series via omap-soc tree?
>>
>> What about patches 5 and 6?
> 
> Any patches which are orthogonal can just be sucked into whichever tree
> they belong in. If there are inter-subsystem dependencies I'd prefer
> to take them and issue a immutable branch pull-request to the other
> maintainers.
> 
Awesome. That would be great, thanks.

cheers,
-roger
