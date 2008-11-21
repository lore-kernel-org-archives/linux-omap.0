From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: defconfig for omap3-evm
Date: Fri, 21 Nov 2008 17:33:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E8E67DEC@dbde02.ent.ti.com>
References: <52c7556c0811210359n73256679pd50f391c48af5530@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41965 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbYKUMDb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 07:03:31 -0500
In-Reply-To: <52c7556c0811210359n73256679pd50f391c48af5530@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Pundir <pundiramit@gmail.com>, "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Amit Pundir
> Sent: Friday, November 21, 2008 5:29 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: defconfig for omap3-evm
> 
> Hi,
> 
> >
> > When you say TI kernel, is it the one you received with your EVM
> package?
> >
> > If so, you will need to continue using the same defconfig.
> 
> Yes the one received with the EVM package.
> 
> >> drivers/built-in.o: In function `omapfb_do_probe':
> >> /home/amit/omap35xx/ti/muru_linux/linux-2.6.22.1/drivers/video
> >> /omap/omapfb_main.c:1777:
> >> undefined reference to `omap2_int_ctrl'
> 
> "undefined reference to `omap2_int_ctr'" is the problem. This
> variable
> is only defined for ARCH_OMAP2 build and I cannot enable OMAP2 and
> OMAP3 builds simultaneously.
> 
> This error comes when it tries to build LCD controller part which is
> an internal part of evm and hence necessary.
> 
> Still stuck at the kernel build.
> 
[Hiremath, Vaibhav] Can you provide your .config file? 

> Regards
> Amit Pundir
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

