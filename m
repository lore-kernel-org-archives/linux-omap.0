From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: OMAP baseline test results for v3.13-rc1 (toolchain Debian 4.7.2-5)
Date: Tue, 10 Dec 2013 00:34:17 +0300
Message-ID: <52A63759.70601@cogentembedded.com>
References: <alpine.DEB.2.02.1311250731410.1364@utopia.booyaka.com> <alpine.DEB.2.02.1311251514330.1364@utopia.booyaka.com> <alpine.DEB.2.02.1312090936530.32309@utopia.booyaka.com> <20131209171618.GC11433@atomide.com> <20131209191452.GA13171@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:57867 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab3LIUeU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 15:34:20 -0500
Received: by mail-la0-f48.google.com with SMTP id n7so1972708lam.21
        for <linux-omap@vger.kernel.org>; Mon, 09 Dec 2013 12:34:19 -0800 (PST)
In-Reply-To: <20131209191452.GA13171@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

Hello.

On 12/09/2013 10:14 PM, Tony Lindgren wrote:

>>>>> Boot to userspace:
>>>>>      FAIL ( 1/11): 37xxevm

>>>> So looks like this is due to the switchover to DT-based booting for 37xx
>>>> EVM.  Will plug that in here and re-test.

>>> Here's the updated test report.  Looks like dynamic idle PM tests are
>>> failing on the 37xxevm now.

>> Off-idle and wake-up events work but need these two pending patches:

>> 1. [PATCH] of/platform: Fix no irq domain found errors when populating interrupts
>>     http://lkml.org/lkml/2013/11/22/520

> Oops, this is the wrong patch, it should be:

> 1. [PATCH] of/platform: Fix no irq domain found errors when populating interrupts
>     http://lkml.org/lkml/2013/11/22/520

    Isn't it the same patch and link? :-)

WBR, Sergei

