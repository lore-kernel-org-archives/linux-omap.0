From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: GUI for OMAP3EVM
Date: Thu, 28 Aug 2008 07:58:43 -0700
Message-ID: <5e088bd90808280758x5d030539wd1dba8cd09fcb5e8@mail.gmail.com>
References: <c656a4d20808280151u74b3f6d6xbda61097ebe3fb1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:55596 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbYH1O6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 10:58:44 -0400
Received: by py-out-1112.google.com with SMTP id p76so253208pyb.10
        for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 07:58:43 -0700 (PDT)
In-Reply-To: <c656a4d20808280151u74b3f6d6xbda61097ebe3fb1e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> X window based GUI is not suitable for embedded
> devices, am I right?
>
> Does any body tried this?

Yes, I have some X based images you can play with on your EVM.  They
are located at:

http://www.sakoman.net/feeds/omap3/glibc/images/omap3evm/

I suggest that you grab uImage-omap3evm.bin for the kernel and
omap3evm-demo-image-omap3evm.jffs2 for the rootfs.

The image includes touchscreen support, some PIM apps, and the Midori
web browser.

Re-flash in the usual way.

Steve
