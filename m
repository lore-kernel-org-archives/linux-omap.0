From: "Abraham Arce" <abraham.arce.moreno@gmail.com>
Subject: Re: [PATCH 1/1] SDP2430 Fix dependency in include file
Date: Mon, 1 Sep 2008 08:42:20 -0500
Message-ID: <cb8016980809010642g4b53de5o3500e0b3ff2d4800@mail.gmail.com>
References: <cb8016980808311857y693787daq8c641c785732058c@mail.gmail.com>
	 <20080901080700.GX9887@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:49455 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbYIANmV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 09:42:21 -0400
Received: by yw-out-2324.google.com with SMTP id 9so277374ywe.1
        for <linux-omap@vger.kernel.org>; Mon, 01 Sep 2008 06:42:20 -0700 (PDT)
In-Reply-To: <20080901080700.GX9887@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: omap <linux-omap@vger.kernel.org>

On Mon, Sep 1, 2008 at 3:07 AM, Felipe Balbi <me@felipebalbi.com> wrote:

>>  #include <linux/clk.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/spi/ads7846.h>
>> +#include <linux/i2c/twl4030.h>
>
> and what's wrong with:

Nothing is bad... I didn't see the patch

>
> http://marc.info/?l=linux-omap&m=122011272912755&w=2
>
> --
> balbi
>
