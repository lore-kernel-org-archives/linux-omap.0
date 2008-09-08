From: "Budhee Jamaich" <budheej@gmail.com>
Subject: 3430: can't find mmc debounce clock
Date: Mon, 8 Sep 2008 16:18:09 +0300
Message-ID: <57314e840809080618x1f0cd0aen74b1a03351dc8ef7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:53210 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbYIHNSK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 09:18:10 -0400
Received: by gxk9 with SMTP id 9so7691964gxk.13
        for <linux-omap@vger.kernel.org>; Mon, 08 Sep 2008 06:18:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I read that the mmc has 3 clocks: fixed functional clock (MMCi_FCLK),
interface clock (MMCi_ICLK) and debounce clock (MMCi_32).

But, when I look in clock34xx.h, I can only see two of those - there
is the "mmchs_fck" and "mmchs_ick". There is no struct clk for the
debounce clock. Only when I look in older kernels I can see also the
"mmchsdb2_fck".

So where is the debounce clock struct ? (I want to 'get' and 'enable' it...)

Thank you in advance
Budhee
