From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: Re: [PATCH 07/10] ARM: OMAP5: clock data: Add OMAP54XX full clock
 tree and headers
Date: Mon, 21 Jan 2013 22:34:22 +0100
Message-ID: <50FDB45E.7090609@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com> <1358522856-12180-8-git-send-email-santosh.shilimkar@ti.com> <50FD5055.6000903@ti.com> <50FD512B.4020003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33438 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512Ab3AUVea (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jan 2013 16:34:30 -0500
In-Reply-To: <50FD512B.4020003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, Paul Walmsley <paul@pwsan.com>

Hi Santosh,

I have push under the omap-audio gitorious two patches on top of your 
series. One for adding the ABE DPLL and a second for the remove of Audio 
DMA addresses.

https://gitorious.org/omap-audio/linux-audio/commits/base/omap5_es2_data

I will try to check Display tomorrow.

Sebastien

On 01/21/2013 03:31 PM, Santosh Shilimkar wrote:
> On Monday 21 January 2013 07:57 PM, Sebastien Guiriec wrote:
>> Hi Santosh,
>>
>> I check the tree with Audio and it is working. Just a comment for the
>> addition of ABE DPLL locking like for OMAP4.
>>
> Excellent. Can you send the update please?
> I will fold that in.
>
> Regards
> santosh
>

