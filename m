From: "Amit Pundir" <pundiramit@gmail.com>
Subject: Re: defconfig for omap3-evm
Date: Fri, 21 Nov 2008 17:29:09 +0530
Message-ID: <52c7556c0811210359n73256679pd50f391c48af5530@mail.gmail.com>
References: <52c7556c0811210204h13f4a582r7d3add4b790863f0@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301B6C8CE09@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:38899 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbYKUL7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 06:59:10 -0500
Received: by ti-out-0910.google.com with SMTP id b6so608052tic.23
        for <linux-omap@vger.kernel.org>; Fri, 21 Nov 2008 03:59:09 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B6C8CE09@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

>
> When you say TI kernel, is it the one you received with your EVM package?
>
> If so, you will need to continue using the same defconfig.

Yes the one received with the EVM package.

>> drivers/built-in.o: In function `omapfb_do_probe':
>> /home/amit/omap35xx/ti/muru_linux/linux-2.6.22.1/drivers/video
>> /omap/omapfb_main.c:1777:
>> undefined reference to `omap2_int_ctrl'

"undefined reference to `omap2_int_ctr'" is the problem. This variable
is only defined for ARCH_OMAP2 build and I cannot enable OMAP2 and
OMAP3 builds simultaneously.

This error comes when it tries to build LCD controller part which is
an internal part of evm and hence necessary.

Still stuck at the kernel build.

Regards
Amit Pundir
