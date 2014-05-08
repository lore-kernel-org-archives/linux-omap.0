From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: OMAP baseline test results for v3.15-rc4
Date: Thu, 8 May 2014 11:11:22 +0200
Message-ID: <CAGhQ9Vx_dJTn20S1OngAks1KvZkH=MUWEh-4bv5ciM7PhofJ8Q@mail.gmail.com>
References: <alpine.DEB.2.02.1405080417150.23579@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:33424 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbaEHJLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 05:11:23 -0400
Received: by mail-vc0-f178.google.com with SMTP id hq16so35388vcb.37
        for <linux-omap@vger.kernel.org>; Thu, 08 May 2014 02:11:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1405080417150.23579@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel-build-reports@lists.linaro.org

On 8 May 2014 06:23, Paul Walmsley <paul@pwsan.com> wrote:
>
> Here are some basic OMAP test results for Linux v3.15-rc4.
> Logs and other details at:
>
>     http://www.pwsan.com/omap/testlogs/test_v3.15-rc4/20140505112251/
>
>
> Test summary
> ------------
<snip>
>
> The eMMC on the 4460 VAR-SOM-OM has failed; I guess it's run out of
> reserve blocks to reallocate.  Now it's time to find yet another way
> to boot it.

I have some patches for u-boot which makes it possible to use the
on-board LAN7500 USB Ethernet controller for tftp.

Since you have a VAR-SOM-OM44 module maybe you could test my dts patches for it?
I will post a new version of the patch set early next week. I can cc you.

Do you have the VAR-DVK-OM44 eval board?

regards
Joachim Eastwood
