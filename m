From: Tero Kristo <t-kristo@ti.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Tue, 10 Sep 2013 15:24:59 +0300
Message-ID: <522F0F9B.9050705@ti.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com> <521DCD80.1060600@ti.com> <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com> <522F0CC7.50501@ti.com> <522F0E3E.1080001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36510 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274Ab3IJMZE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Sep 2013 08:25:04 -0400
In-Reply-To: <522F0E3E.1080001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Stefan Roese <stefan.roese@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

On 09/10/2013 03:19 PM, Tomi Valkeinen wrote:
> On 10/09/13 15:12, Tero Kristo wrote:
>
>> If it claims it is not locked, it means the DPLL itself is disabled. You
>> could try clk_enable for the clock before doing clk_set_rate.
>
> Hmm, so is it required to enable the clock before setting the rate? If
> so, I think I'm using the clocks wrong in all the places =).

In generic case, it is not. But DPLLs behave strangely if they go to low 
power stop mode. If there is any downstream clock enabled for a specific 
DPLL it is enabled and things work okay.

One could also argue that the API behavior in OMAP is wrong currently, 
as the bypass rate is something you are most likely never actually going 
to use for anything....

Just try the change and check the results.

-Tero
