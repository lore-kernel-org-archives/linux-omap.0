From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] regulator core: fix double-free in regulator_register()
 error path
Date: Sat, 25 Apr 2009 22:53:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904252250230.4291@utopia.booyaka.com>
References: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55954 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbZDZExg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Apr 2009 00:53:36 -0400
In-Reply-To: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net

On Sat, 25 Apr 2009, Paul Walmsley wrote:

> During regulator registration, any error after device_register() will 
> cause a double-free on the struct regulator_dev 'rdev'.  The bug is in 
> drivers/regulator/core.c:regulator_register():
>
> ...
> 
> device_unregister() calls regulator_dev_release() which frees rdev.  The 
> subsequent kfree corrupts memory and causes some OMAP3 systems to oops on 
> boot in regulator_get().

For the 3430SDP users out there, this patch also fixes the boot hang after 
"regulator_init_complete: incomplete constraints, leaving VAUX3 on"
on that device.

- Paul
