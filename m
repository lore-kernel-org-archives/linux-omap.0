From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] pinctrl: Add generic pinctrl-simple driver that supports
 omap2+ padconf
Date: Thu, 03 May 2012 16:34:45 -0600
Message-ID: <4FA30805.5050804@wwwdotorg.org>
References: <20120502172401.GG3739@atomide.com> <20120503065131.GA3738@game.jcrosoft.org> <20120503152708.GC5140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:56685 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933Ab2ECWes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 18:34:48 -0400
In-Reply-To: <20120503152708.GC5140@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/03/2012 09:27 AM, Tony Lindgren wrote:
> Hi,
> 
> * Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> [120503 00:16]:
>>
>> 	I really like it
>>
>> 	I was working on something simillar
>>
>> 	but can we split the group management so we can use it on other
>> 	bindings
> 
> Hmm I'm not sure I follow on the group management splitting, can you specify
> what you have in mind here?
> 
> If you mean moving more things into pinctrl fwk, then yeah I'd assume that
> will happen eventually and drivers like this will end up becoming more minimal.

Jean-Christophe, forgive me if I'm putting words in your mouth, but I
assume the following is what you mean:

There are two pieces of data required by the pinctrl subsystem:

a) The set of pins, functions, and groups that exist.

b) The specific function to select for each pin/group on a given board.

Item (a) can be represented in the pinctrl driver (e.g. as in the Tegra
driver), or can be represented in device tree in order to avoid large
tables in the driver.

Item (b) has to be represented in device tree, since the whole point is
that it's board-specific.

For all DT bindings I've seen that choose to represent (a) in the DT
rather than in the driver, the DT represents (b) directly, and (a) is
implicitly extracted/created based on (a).

When I was first thinking about DT bindings for pinctrl, I had hoped
that even if (a) was represented in DT, the DT nodes/properties for (a)
and (b) would be entirely separate, so that the binding for (b) could be
completely common across all SoCs, even though the binding for (a) would
perhaps be different across SoCs (if it existed at all).

So, perhaps Jean-Christophe is talking about splitting up (a) and (b) in
device tree?

Or perhaps Jean-Christophe only refers to the code that creates the
group and function definitions from (b), and not the actual DT binding
itself?
