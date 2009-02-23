From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] OMAP: HSMMC: Initialize hsmmc controller registers when
	resuming
Date: Mon, 23 Feb 2009 14:41:23 +0900
Message-ID: <4d34a0a70902222141y345a7bc3g314e6de5df156f2d@mail.gmail.com>
References: <4d34a0a70902200400s252f48ddvfd6e0d83e91fa291@mail.gmail.com>
	 <200902201311.44056.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:33437 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbZBWFlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 00:41:24 -0500
In-Reply-To: <200902201311.44056.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, drzeus-mmc@drzeus.cx, =?EUC-KR?B?seix1L/4?= <q1.kim@samsung.com>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>

Hi,

On Sat, Feb 21, 2009 at 6:11 AM, David Brownell <david-b@pacbell.net> wrote:
> On Friday 20 February 2009, Kim Kyuwon wrote:
>> +static void omap_hsmmc_init(struct mmc_omap_host *host)
>> +{
>> +       u32 hctl, capa, value;
>> +
>> +       /* Only MMC1 supports 3.0V */
>> +       if (host->id == OMAP_MMC1_DEVID) {
>> +               hctl = SDVS30;
>
> Shouldn't it be remembering what voltage it was using,
> and then restore that, instead of always making MMC1
> restart at a 3.0V level?  That's pretty awkward to test
> unless you have a 1.8V-capable card in MMC1...

You are somewhat right, thank you.
But remebering what voltage it was using doesn't feasible to me,
because the card can be changed while in 'Sleep' state. I should have
inserted a function that detect the right voltage after intializing. I
will resend the patch later.

-- 
Kyuwon
