From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH 1/2] clk: Make clk API return per-user struct clk instances
Date: Tue, 7 Oct 2014 17:28:55 +0200
Message-ID: <CAAObsKD6=xRqR9m8dNATUAuiky-HZW4LHJtnG1BbpO8dsBBJPg@mail.gmail.com>
References: <1412255097-15928-1-git-send-email-tomeu.vizoso@collabora.com>
 <1412255097-15928-2-git-send-email-tomeu.vizoso@collabora.com> <20141003231515.GM10233@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:44146 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbaJGP3Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2014 11:29:16 -0400
In-Reply-To: <20141003231515.GM10233@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On 4 October 2014 01:15, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 10/02, Tomeu Vizoso wrote:
>> +
>>  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
>
> These ifdefs look useless.
>
>>  struct clk *of_clk_get_by_clkspec(struct of_phandle_args *clkspec);
>>  struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec);
>>  void of_clk_lock(void);
>>  void of_clk_unlock(void);
>>  #endif
>> +
>> +#if defined(CONFIG_COMMON_CLK)
>
> So we shouldn't need this one either.

Actually, i had to put it back so clkdev.c builds on
!CONFIG_COMMON_CLK. Do you have another idea on how to deal with this?

Sorry, but I forgot to CC you on v2 (just sent):
https://lkml.org/lkml/2014/10/7/430

Thanks,

Tomeu
