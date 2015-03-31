From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 30/35] ARM: dts: omap4: add minimal l4 bus layout with
 control module support
Date: Tue, 31 Mar 2015 17:58:49 +0300
Message-ID: <551AB629.5020104@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com> <1426877086-17131-31-git-send-email-t-kristo@ti.com> <20150330230116.GM10805@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47716 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbbCaO7A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2015 10:59:00 -0400
In-Reply-To: <20150330230116.GM10805@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, sakari.ailus@iki.fi, linux-arm-kernel@lists.infradead.org

On 03/31/2015 02:01 AM, Tony Lindgren wrote:
> Hi,
>
> * Tero Kristo <t-kristo@ti.com> [150320 11:46]:
>> This patch creates the l4_cfg and l4_wkup interconnects for OMAP4, and
>> moves some of the generic peripherals under it. System control module
>> support is added to the device tree also, and the existing SCM related
>> functionality is moved under it.
>
> Doing a diff on the dmesg output before and after this series now
> produces this extra warning on omap4:
>
> +ti_dt_clk_init_provider: scm_conf missing 'clocks' child node

Nice test case you got there.

Added a check against missing clocks node, control module no longer 
attempts clock registration if the clocks are not defined. Will repost.

-Tero
