From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: ARM: OMAP: patches for stable
Date: Mon, 27 Feb 2012 13:14:14 -0800
Message-ID: <20120227211414.GA16071@kroah.com>
References: <4F474DAD.1030302@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42037 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab2B0VOs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Feb 2012 16:14:48 -0500
Received: by pbcup15 with SMTP id up15so2484618pbc.19
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 13:14:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F474DAD.1030302@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: stable@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Feb 24, 2012 at 10:43:25AM +0200, Igor Grinberg wrote:
> Hi Greg,
> 
> There are several patches already in mainline, that should be also applied to stable:
> 
> 40410715 (ARM: omap: fix oops in drivers/video/omap2/dss/dpi.c)				[3.2-stable]
> d980e0f8 (ARM: omap: fix oops in arch/arm/mach-omap2/vp.c when pmic is not found)	[3.2-stable]
> 
> Can these, please be applied to stable?

I need an ack from Russell before I can do so.

thanks,

greg k-h
