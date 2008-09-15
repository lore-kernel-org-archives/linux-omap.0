From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch] kill compile warning on twl4030-power.c
Date: Mon, 15 Sep 2008 21:23:02 +0300
Message-ID: <20080915182259.GB7782@frodo>
References: <20080915151208.GA17076@frodo> <20080915155512.GF4712@codecarver.research.nokia.com> <20080915162122.GB17076@frodo> <20080915162421.GH4712@codecarver.research.nokia.com> <20080915163611.GE17076@frodo> <20080915173020.GI4712@codecarver.research.nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56738 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbYIOSXV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2008 14:23:21 -0400
Content-Disposition: inline
In-Reply-To: <20080915173020.GI4712@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Sep 15, 2008 at 08:30:20PM +0300, Peter 'p2' De Schrijver wrote:
> > > > -#if defined(CONFIG_MACH_OMAP_3430SDP) || defined(CONFIG_MACH_OMAP_3430LABRADOR)
> > > > -       /* Disabling AC charger effect on sleep-active transitions */
> > > > -       err |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
> > > > -                                       R_CFG_P1_TRANSITION);
> > > > -       data &= 0x0;
> > > 
> > > This does not make sense :) 
> > 
> > Why not? That data variable is only used on 3430SDP and LABRADOR
> > anyways. Any other build will keep generating "unused variable" warnings
> > and that's annoying :-p
> 
> Because a logical and with 0 will always result in 0. So the read is
> useless. So the original code is probably wrong.

Maybe you meant data &= ~(1 << 0);  ???

-- 
balbi
