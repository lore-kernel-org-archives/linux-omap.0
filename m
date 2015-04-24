From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] bus: omap_l3_noc: Fix master id address decoding for
 OMAP5
Date: Fri, 24 Apr 2015 14:54:51 -0500
Message-ID: <553A9F8B.7010205@ti.com>
References: <1429898060-51944-1-git-send-email-s-anna@ti.com>	<553A8C68.5080903@ti.com>	<553A951A.1080905@ti.com> <CAGo_u6rgZhkRZSjpXuvBz5frYByUDtzFrAQFaPB7rxT8hLYBPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32932 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030735AbbDXTzQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Apr 2015 15:55:16 -0400
In-Reply-To: <CAGo_u6rgZhkRZSjpXuvBz5frYByUDtzFrAQFaPB7rxT8hLYBPw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, dt list <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 04/24/2015 02:38 PM, Nishanth Menon wrote:
> On Fri, Apr 24, 2015 at 2:10 PM, Suman Anna <s-anna@ti.com> wrote:
>> On 04/24/2015 01:33 PM, Nishanth Menon wrote:
>>> On 04/24/2015 12:54 PM, Suman Anna wrote:
> 
> ...
>>>> -static struct l3_target_data omap_l3_target_data_clk3[] = {
>>>> -    {0x0100, "EMUSS",},
>>>> -    {0x0300, "DEBUG SOURCE",},
>>>> -    {0x0,   "HOST CLK3",},
> ^^ this was HOST CLK3
> ..
>>>>
>>>> +/* OMAP5 data */
>>>> +static struct l3_target_data omap5_l3_target_data_clk3[] = {
>>>> +    {0x0100, "L3INSTR",},
>>>> +    {0x0300, "DEBUGSS",},
>>>> +    {0x0,    "HOSTCLK3",},
>>>
>>> "HOST CLK"
>>
>> Why? I followed the convention used for the other two HOST CLKs for the
> 
> so asked, if it should be HOST<space>CLK3

Aah ok, you missed the trailing number before. In anycase, this was
intentional to match HOSTCLK1 and HOSTCLK2 on OMAP4/5. Overall, the
names are somewhat non-standard, some use underscores and some others
strip out the underscore and do not use any spaces in between either.
"HOST CLK3" would be the only one to use a space for OMAP4, so I got rid
of it, so hope that's ok with you.

regards
Suman


