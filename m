From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv11 07/49] clk: divider: add support for low level ops
Date: Fri, 20 Dec 2013 18:33:33 +0200
Message-ID: <52B4715D.5020207@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com> <1387452260-23276-8-git-send-email-t-kristo@ti.com> <20131219182620.GQ27438@atomide.com> <52B342D2.1010301@ti.com> <52B416E8.8070006@ti.com> <52B41C15.8040304@ti.com> <52B41E4B.8040808@ti.com> <20131220161622.GC27438@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50767 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458Ab3LTQeC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Dec 2013 11:34:02 -0500
In-Reply-To: <20131220161622.GC27438@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 12/20/2013 06:16 PM, Tony Lindgren wrote:
> * Rajendra Nayak <rnayak@ti.com> [131220 02:40]:
>>
>> yeah, the crash was indeed when ll_ops was dereferenced despite being NULL.
>
> Might be also worth checking if the gate and mux patches have a similar issue.

Yea they had and I fixed those. v12 coming out right after this email.

-Tero
