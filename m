From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFT PATCH 0/8] clk: ti: Fix possible ERR_PTR dereferences from
 clk_get_sys
Date: Wed, 13 May 2015 10:07:08 +0300
Message-ID: <5552F81C.2010301@ti.com>
References: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43211 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbbEMHGU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 May 2015 03:06:20 -0400
In-Reply-To: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/13/2015 09:54 AM, Krzysztof Kozlowski wrote:
> Hi,
>
>
> clk_get_sys() may return ERR_PTR but the drivers immediately
> dereferenced the return value. This could lead to oops.
>
> I tried only to fix possible ERR_PTR dereference and to not change
> the logic. This is why some of the patches look quite complex.
> For example in clk-7xx driver proceeds to next clocks if first one fails.
>
> WARNING:
> The patchset was only compile tested (plus static checkers), as
> I do not have the hardware. I am kindly asking for tests.
>
>
> Best regards,
> Krzysztof

Hi Krzysztof,

These should be rather fixed by using assigned-clock-parents / 
assigned-clock-rates DT properties and removing the offending legacy 
code from clk-* files. Patch #1 is good to go as is.

-Tero

>
>
> Krzysztof Kozlowski (8):
>    clk: ti: dra7-atl-clock: Fix possible ERR_PTR dereference
>    clk: ti: clk-2xxx: Prevent possible ERR_PTR dereference
>    clk: ti: clk-3xxx: Prevent possible ERR_PTR dereference
>    clk: ti: clk-33xx: Prevent possible ERR_PTR dereference
>    clk: ti: clk-43xx: Prevent possible ERR_PTR dereference
>    clk: ti: clk-43xx: Prevent possible ERR_PTR dereference
>    clk: ti: clk-54xx: Prevent possible ERR_PTR dereference
>    clk: ti: clk-7xx: Prevent possible ERR_PTR dereference
>
>   drivers/clk/ti/clk-2xxx.c     | 18 ++++++++++++----
>   drivers/clk/ti/clk-33xx.c     |  9 +++++---
>   drivers/clk/ti/clk-3xxx.c     | 18 ++++++++++++----
>   drivers/clk/ti/clk-43xx.c     |  3 ++-
>   drivers/clk/ti/clk-44xx.c     | 16 ++++++++++----
>   drivers/clk/ti/clk-54xx.c     | 47 +++++++++++++++++++++++++++-------------
>   drivers/clk/ti/clk-7xx.c      | 50 +++++++++++++++++++++++++------------------
>   drivers/clk/ti/clk-dra7-atl.c |  5 +++++
>   8 files changed, 114 insertions(+), 52 deletions(-)
>

