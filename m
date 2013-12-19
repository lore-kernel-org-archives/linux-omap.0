From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv11 00/49] ARM: TI SoC clock DT conversion
Date: Thu, 19 Dec 2013 09:07:20 -0600
Message-ID: <52B30BA8.2060108@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:48827 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab3LSPHZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 10:07:25 -0500
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/19/2013 05:23 AM, Tero Kristo wrote:
[...]
>
> branch: 3.13-rc4-dt-clks-v11 : contains everything, shall me merged last


Tero,
Considering Pauls'  concerns with v10 last time, I ran
[1] and got a few sparse, smatch and checkpatch warnings:
http://pastebin.mozilla.org/3810314

I think we can ignore sparse spam about "__ksymtab" for the moment.
but stuff like:
+drivers/clk/ti/clk.c:88 ti_clk_retry_init() error: potential null 
dereference 'retry'.  (kzalloc returns null)

the checkpatch warn that Paul stated:"extern struct of_device_id 
__clk_of_table" still remain should be fixed IMHO.

I am unfortunately on vacation right now, and will not be able to test 
until second week of jan on platforms - thanks to my completely messed 
up vpn setup.

[1] https://github.com/nmenon/kernel_patch_verify

Regards,
Nishanth Menon
