From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 14/14] ARM: OMAP3: clock: remove legacy clock data
Date: Wed, 5 Mar 2014 09:32:40 +0200
Message-ID: <5316D318.8080405@ti.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com> <1393924700-6510-15-git-send-email-t-kristo@ti.com> <20140304173242.GB17470@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33091 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbaCEHdK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Mar 2014 02:33:10 -0500
In-Reply-To: <20140304173242.GB17470@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, mturquette@linaro.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 03/04/2014 07:32 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [140304 01:22]:
>> This is no longer needed as clock data is provided through DT.
>
> And this one we cannot apply yet until omap3 is booting in device tree
> only mode.

What is missing to achieve this? Some boards are not booting in DT mode 
yet or?

-Tero
