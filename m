From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: latest kernel for am35xx
Date: Thu, 31 May 2012 11:02:06 +0200
Message-ID: <4FC7338E.4080502@visionsystems.de>
References: <CAP3+TEr8vsnZPhAhgH-w7jAjWZTNQgWvsQ3cn_uz4TaX8c-Zgg@mail.gmail.com> <CAPjKCR_CiKA_vXNyfYHdJeqPMsv0SA_oRYg1-XzbO2C1vSbLug@mail.gmail.com> <CAP3+TErug0DmndHWCVsguw2+e_vPCB2McF5j0+AyrMj8eGa=MQ@mail.gmail.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:55182 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab2EaJCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 May 2012 05:02:19 -0400
In-Reply-To: <CAP3+TErug0DmndHWCVsguw2+e_vPCB2McF5j0+AyrMj8eGa=MQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxim Podbereznyy <lisarden@gmail.com>
Cc: Anil Kumar <anilkumar880@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Maxim,

> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git
> Does anyone knows a working branch/tag for am3517evm? I need the board
> boots fine with Ethernet enabled and working.
> 
> I read a few messages at e2e forum and all of them report about broken
> features.. I need wl1271 support in the kernel therefore I have to use
> on the latest kernels.

my best choice was 3.3-rc7 so far. With final 3.3 frame buffer made problems. wl1271 was working like a charm. I have another PMIC, so I don't know if it works well with tps65910.

I just took the master branch of linux-omap.git

Best regards,
Yegor
