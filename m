From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 5/5] staging:ti dspbridge: replace simple_strtoul by
	strict_strtoul
Date: Wed, 28 Jul 2010 21:40:19 +0300
Message-ID: <AANLkTimNAoy7fJLeGeUPz2tZT9evUwD58tm7mOxTqqv2@mail.gmail.com>
References: <1280328052-31292-1-git-send-email-ernesto@ti.com>
	<1280328052-31292-2-git-send-email-ernesto@ti.com>
	<1280328052-31292-3-git-send-email-ernesto@ti.com>
	<1280328052-31292-4-git-send-email-ernesto@ti.com>
	<1280328052-31292-5-git-send-email-ernesto@ti.com>
	<1280328052-31292-6-git-send-email-ernesto@ti.com>
	<20100728150934.GA25299@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49783 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab0G1SkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 14:40:21 -0400
In-Reply-To: <20100728150934.GA25299@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Ernesto Ramos <ernesto@ti.com>, omar.ramirez@ti.com, ohad@wizery.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, fernando.lugo@ti.com, linux-kernel@vger.kernel.org, nm@ti.com, linux-omap@vger.kernel.org

On Wed, Jul 28, 2010 at 6:09 PM, Greg KH <gregkh@suse.de> wrote:
> On Wed, Jul 28, 2010 at 09:40:52AM -0500, Ernesto Ramos wrote:
>> Replace simple_strtoul by strict_strtoul in atoi function.
>
> Why not use the built-in kernel function instead of having your own atoi
> function?
The commit message left opened questions about
http://dev.omapzoom.org/?p=tidspbridge/kernel-dspbridge.git;a=commit;h=b8af1123b47741086ef5a307ad1ec8fec6fc7f0d

-- 
With Best Regards,
Andy Shevchenko
