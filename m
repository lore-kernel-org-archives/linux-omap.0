From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: DTS: AM33XX: Add PMU support
Date: Tue, 13 Aug 2013 13:47:27 +0200
Message-ID: <520A1CCF.8000501@baylibre.com>
References: <1375552854-8468-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:61517 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756981Ab3HMLrb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Aug 2013 07:47:31 -0400
Received: by mail-we0-f176.google.com with SMTP id q56so6415254wes.21
        for <linux-omap@vger.kernel.org>; Tue, 13 Aug 2013 04:47:30 -0700 (PDT)
In-Reply-To: <1375552854-8468-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

Salut Alexandre,

On 03/08/2013 20:00, Alexandre Belloni wrote:
> ARM Performance Monitor Units are available on the am33xx, add the support in
> the dtsi.
>
> Tested with perf and oprofile on a regular beaglebone.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Thanks, applied for 3.12.

Regards,
Benoit

