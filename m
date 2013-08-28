From: Tero Kristo <t-kristo@ti.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Wed, 28 Aug 2013 12:48:32 +0300
Message-ID: <521DC770.5050000@ti.com>
References: <521DC143.2010506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45941 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3H1Jsk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Aug 2013 05:48:40 -0400
In-Reply-To: <521DC143.2010506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, Stefan Roese <sr@denx.de>

On 08/28/2013 12:22 PM, Tomi Valkeinen wrote:
> Hi,
>
> I'm seeing odd clock behavior with Beagle, booting with DT. I'm using
> v3.11-rc7 + DSS DT patches.

I guess you are not using the clock DT patches? Just making sure I 
didn't break anything. :)

> It looks to me that when setting the rate of a clock, its child clock's
> rate is not updated correctly. Here's pieces of boot log (full log
> attached):
>
> Here my code prints the current clocks. This looks ok: dpll4_m4_ck's
> divider is 2 (432000000/2 = 216000000), and dpll4_m4x2_ck, which is a
> fixed x2 multiplier, is two times dpll4_m4_ck.
>
> [    1.592132] before:
> [    1.592163] dpll4_ck: 432000000
> [    1.592193] dpll4_m4_ck: 216000000
> [    1.592224] dpll4_m4x2_ck: 432000000
> [    1.592254] dss1_alwon_fck_3430es2: 432000000
>
> Here DSS driver sets dpll4_m4_ck's rate
>
> [    1.592254] setting rate 86400000
>
> Here we see the clocks after the clk_set_rate. dpll4_m4_ck is as
> supposed, but the dpll4_m4x2_ck is not x2, resulting in wrong clock for
> dss1_alwon_fck_3430es2. The rate of dpll4_m4x2_ck does get updated,
> though, but not for the correct x2 rate, but x1.
>
> [    1.592315] after:
> [    1.592315] dpll4_ck: 432000000
> [    1.592346] dpll4_m4_ck: 86400000
> [    1.592376] dpll4_m4x2_ck: 86400000
> [    1.592407] dss1_alwon_fck_3430es2: 86400000
>
> After that the DSS probe is deferred, as there's a missing regulator. A
> bit later, the driver is probed again:
>
> Here the clocks are still wrong, as nothing has changed them
>
> [    3.196868] before:
> [    3.199340] dpll4_ck: 432000000
> [    3.202667] dpll4_m4_ck: 86400000
> [    3.206207] dpll4_m4x2_ck: 86400000
> [    3.209991] dss1_alwon_fck_3430es2: 86400000
> [    3.214508] setting rate 72000000
>
> But after this clk_set_rate, the dpll4_m4x2_ck is correct.
>
> [    3.218048] after:
> [    3.220275] dpll4_ck: 432000000
> [    3.223602] dpll4_m4_ck: 72000000
> [    3.227142] dpll4_m4x2_ck: 144000000
> [    3.230987] dss1_alwon_fck_3430es2: 144000000
>
> So, for some reason, the first clk_set_rate goes wrong. Any ideas?

Hmm, strange. I am not seeing similar behavior, but I am calling 
clk_set_rate in different location.... also I am using clock DT patches 
(don't try the current version though, as I am reworking them.)

[    0.000000] dpll4_ck: 432000000
[    0.000000] dpll4_m4_ck: 72000000
[    0.000000] dpll4_m4x2_ck: 144000000
[    0.000000] dss1_alwon_fck_3430es2: 144000000
[    0.000000] dpll4_ck: 432000000
[    0.000000] dpll4_m4_ck: 86400000
[    0.000000] dpll4_m4x2_ck: 172800000
[    0.000000] dss1_alwon_fck_3430es2: 172800000

Do you see the error only when setting to some specific rate (86400000) 
or it doesn't matter?

-Tero

