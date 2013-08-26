From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 01/31] CLK: clkdev: add support for looking up clocks
 from DT
Date: Mon, 26 Aug 2013 21:12:28 +0300
Message-ID: <521B9A8C.7090000@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com> <1375460751-23676-2-git-send-email-t-kristo@ti.com> <20130803183143.GE23053@n2100.arm.linux.org.uk> <521B67DF.4000005@ti.com> <20130826170327.GG25647@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51938 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905Ab3HZSNI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Aug 2013 14:13:08 -0400
In-Reply-To: <20130826170327.GG25647@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 08/26/2013 08:03 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 26, 2013 at 05:36:15PM +0300, Tero Kristo wrote:
>> On 08/03/2013 09:31 PM, Russell King - ARM Linux wrote:
>>> On Fri, Aug 02, 2013 at 07:25:20PM +0300, Tero Kristo wrote:
>>>> +
>>>> +	if (cl)
>>>> +		return cl;
>>>> +
>>>> +	/* If clock was not found, attempt to look-up from DT */
>>>> +	node = of_find_node_by_name(NULL, con_id);
>>>
>>> This is utterly broken if you're looking up purely by a connection ID.
>>> Please, go back and read clk_get()'s documentation in linux/clk.h.
>>> It's spelt out very plainly there.
>>>
>>> NAK.
>>>
>>
>> Hi Russell,
>>
>> After looking at this a bit more, it seems difficult to get rid of the
>> clk_get -> of_clk_get conversion, however based on this comment I am
>> somewhat stuck. Do you think it would be acceptable if I change the
>> implementation of this patch to work like this:
>
> Firstly, for clk_get(), you don't need to do anything - clk_get() already
> deals with DT, and if your DT is correct, it should already be returning
> the appropriate clock(s).
>
> I guess the problem here is clk_get_sys(), because that doesn't take a
> struct device (and it doesn't take a struct device because it's used
> from code where there is no struct device to use with it.)

Yeah, most of the OMAP clocks have been traditionally referenced in this 
way, they are using clk_get_sys and with dev=NULL. conn-id is mostly unique.

>
> If you have an OF node, what's wrong with using of_clk_get_by_name()?
> If you don't have an OF node, how do you expect to find the clock in
> the device tree, remembering that clocks are specific to devices, and
> the 2nd argument to clk_get()/clk_get_sys() is not a unique identifier.

In the legacy code, pretty much all the clocks are mapped through 
clk_get_sys(NULL, conn), and large amount of the drivers don't even have 
DT conversion in place yet. I am attempting to handle the cases where we 
don't have OF nodes.... yet at least, without converting everything to 
DT, and without causing regressions (also, I don't even pretend to be 
capable of testing all the potential drivers for this.) Some parts of 
the basic infra which are using clk_get_sys are pretty silly also, like 
the ocp_if parts of the hwmod, I haven't figured out yet how to convert 
that to DT.

Personally I don't mind causing a regressions here though, if I get 
approval for it from Tony.

-Tero
