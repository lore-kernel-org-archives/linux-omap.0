From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: How to change freq of mmc2_clk to 48Mhz for OMAP35xx
Date: Wed, 8 Dec 2010 22:43:17 +0200
Message-ID: <AANLkTimjJaU4nqM-4svHb4BMJrVf99aBdoU-aofVhcOp@mail.gmail.com>
References: <68E48EB0-25B0-4D1B-B7C3-587A521F309F@mac.com>
	<alpine.DEB.2.00.1012081330470.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:62478 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755747Ab0LHUqN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 15:46:13 -0500
Received: by iwn40 with SMTP id 40so2191398iwn.3
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 12:46:13 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012081330470.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Elvis Dowson <elvis.dowson@mac.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Dec 8, 2010 at 10:36 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Anyway, if you want to try changing it from the kernel side, you'll need
> code like this in the MMC driver or OMAP integration code (off the top of
> my head, untested):

> Please let me know if this doesn't work.
IIRC, there is mmc_set_clock() method, but it isn't exported. Anyway,
I have another issue with some specific code which also requires the
same function to be exported.

-- 
With Best Regards,
Andy Shevchenko
