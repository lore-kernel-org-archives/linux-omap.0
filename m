From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv12 06/49] clk: add support for low level register ops
Date: Tue, 7 Jan 2014 09:44:56 +0200
Message-ID: <52CBB078.7000607@ti.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com> <1387557274-22583-6-git-send-email-t-kristo@ti.com> <20131222173926.GB8064@book.gsilab.sittig.org> <52C67F53.6000402@ti.com> <52C7141F.2020901@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60240 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754662AbaAGHpe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jan 2014 02:45:34 -0500
In-Reply-To: <52C7141F.2020901@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, Anatolij Gustschin <agust@denx.de>

On 01/03/2014 09:48 PM, Stephen Boyd wrote:
> On 01/03/14 01:13, Tero Kristo wrote:
>> On 12/22/2013 07:39 PM, Gerhard Sittig wrote:
>>>
>>>
>>> Further I'd suggest to split this register access aspect out of
>>> the TI clock series, and to prepare it already for regmap style
>>> access to the hardware registers.  See the next comment below.
>>
>> This sounds like a good idea to me, seeing it is blocking lots of
>> other things.
>
> This ll_ops struct looks like a simplified regmap. Have you seen my
> series that adds regmap support to the common clock framework[1]? Is
> there any reason why you can't use those patches and layer some patches
> on top to add support for regmap to the basic clock types?
>
> [1] https://lkml.org/lkml/2013/12/23/461

Yea I've seen that. I also used regmap myself on some earlier rev, but 
it is rather an overkill solution to my purposes, and it also adds 
additional latencies to the register access.

-Tero

