From: "R, Vignesh" <vigneshr@ti.com>
Subject: Re: [PATCH 2/2] w1: masters: omap_hdq: Add support for 1-wire mode
Date: Mon, 2 Mar 2015 13:27:46 +0530
Message-ID: <54F417FA.1010802@ti.com>
References: <1425029057-5075-1-git-send-email-vigneshr@ti.com> <10805905.OnX7kRTk9d@wuerfel> <54F04767.5070001@ti.com> <4111301.XAv3eRBo5S@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4111301.XAv3eRBo5S@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Evgeniy Polyakov <zbr@ioremap.net>, Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, NeilBrown <neilb@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


Hi,

On 2/27/2015 4:04 PM, Arnd Bergmann wrote:
> On Friday 27 February 2015 16:01:03 Vignesh R wrote:
>> On Friday 27 February 2015 03:25 PM, Arnd Bergmann wrote:
>>> On Friday 27 February 2015 14:54:17 Vignesh R wrote:
>>>> +- compatible : should be "ti,omap3-1w" or "ti,am43xx-hdq"
>>>>
>>>
>>> Do not use wildcards in the compatible string, use real part numbers
>>> if you don't know the actual name of the device.
>>
>>
>> The DT node for hdq on AM437x is already present in mainline
>> (commit: 741cac5f00beb) and it declares compatibility as
>> "ti,am43xx-hdq". Hence, I cannot change into anything different.
>>
> 
> No, there is no driver using this device, and the binding was
> not documented, so there is no problem in changing it: nobody
> will notice a regression when it was never working before

Ok... I will change it to "ti,am4372-hdq"

Regards
Vignesh
