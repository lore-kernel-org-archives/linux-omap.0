From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: dra7xx: Fix compatible string for PCF8575
 chip
Date: Wed, 13 Apr 2016 10:21:48 +0300
Message-ID: <570DF38C.8000600@ti.com>
References: <1458147150.20441.2.camel@codethink.co.uk>
 <56E9DED9.6020909@ti.com> <20160412210438.GA5995@atomide.com>
 <570DEE5B.1010001@linutronix.de> <570DF110.3070805@ti.com>
 <570DF235.6040705@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570DF235.6040705-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 13/04/16 10:16, Sebastian Andrzej Siewior wrote:
> On 04/13/2016 09:11 AM, Roger Quadros wrote:
>> On 13/04/16 09:59, Sebastian Andrzej Siewior wrote:
>>> On 04/12/2016 11:04 PM, Tony Lindgren wrote:
>>>>> While at it, do you want to fix up (+Seb):
>>>>> a) Documentation/devicetree/bindings/i2c/i2c-pxa-pci-ce4100.txt which
>>>>> also seems to refer to ti,pcf in example (introduced by df2634f43f51
>>>>> x86: dtb: Add a device tree for CE4100 )
>>>>> b) arch/x86/platform/ce4100/falconfalls.dts as well?
>>>>
>>>> Applying this one with Roger's ack, seems like those should be
>>>> additional patches.
>>>
>>> Okay. I looked it up on the board and it says NXP PCF8575 and not TI.
>>> TI's was probably the first hit while I was looking for it (I think
>>> CE4100 manual mentioned just PCF8575).
>>>
>>> But if it would have a TI branding on it I would keep the TI prefix in
>>> front and add the NXP prefix. As of today we might not know a
>>> functional difference between those two but this does not mean we might
>>> find one in the future.
>>> That said, are you people sure that the DRA7 has a TI or a NXP branding
>>> on it?
>>
>> Board has a Texas Instruments part: PCF8575PWR TSSOP24.
>> http://www.ti.com/product/PCF8575
> 
> So this sounds like
> 
> 	compatible = "ti,pcf8575", "nxp,pcf8575";
> 
> then.

Agree with you.

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
