From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: AM3517evm
Date: Mon, 12 Mar 2012 14:55:02 +0100
Message-ID: <4F5E0036.105@visionsystems.de>
References: <CAFu+nvFt8BcO1pDD6CXXM056WYG9AQDTv-boc7xF0C2JuHAyYw@mail.gmail.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:48309 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab2CLNzO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 09:55:14 -0400
In-Reply-To: <CAFu+nvFt8BcO1pDD6CXXM056WYG9AQDTv-boc7xF0C2JuHAyYw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "George C. Huntington, III" <george.huntingtoniii@gmail.com>
Cc: linux-omap@vger.kernel.org, mporter@ti.com

Am 09.03.2012 18:22, schrieb George C. Huntington, III:
> I would like to make the newer kernel (3.x) work with the AM3517EVM.
> I have a 2.6.32 and a 2.6.33 that run well on the board, but the
> recent kernels have kernel panics before even running init.  where
> should I start?  is there a better place to pursue this?

Have you tried this one? http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=summary

I have this one booting one month ago, but I checked out the kernel today and it hangs somewhere:

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
                       
Or have you tried the one from kernel.org directly?
                         
Best regards,
Yegor
