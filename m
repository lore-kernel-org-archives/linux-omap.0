From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 07/43] CLK: TI: add autoidle support
Date: Tue, 5 Nov 2013 10:10:08 +0200
Message-ID: <5278A7E0.6060708@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-8-git-send-email-t-kristo@ti.com> <52727FDA.7060009@ti.com> <527371F5.9080702@ti.com> <5273FDF1.6090405@ti.com> <52777042.40703@ti.com> <5277B63B.7080106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33064 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309Ab3KEIKh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Nov 2013 03:10:37 -0500
In-Reply-To: <5277B63B.7080106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11/04/2013 04:59 PM, Nishanth Menon wrote:
> On 11/04/2013 04:00 AM, Tero Kristo wrote:
>> On 11/01/2013 09:16 PM, Nishanth Menon wrote:
>>> On 11/01/2013 04:18 AM, Tero Kristo wrote:
>
> [...]
>>> one other thing I missed, will be nice to introduce a common bindings
>>> for autoidle which tends to be reused in other drivers..
>>
>> You mean documentation or? Autoidle from this patch is only used by two
>> clock drivers (divider + fixed-factor.) DPLLs use completely different
>> setup. Converting the interface clocks to use the same might be rather
>> nasty thing to do.
> The definitions are common - so, yes, it will be nice to have
> autoidle.txt which is then pointed to by divider, fixed-clock etc..

Ok can add that.

-Tero

