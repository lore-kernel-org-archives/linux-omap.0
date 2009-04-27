From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] regulator core: fix double-free in
 regulator_register() error path
Date: Mon, 27 Apr 2009 12:40:02 +0100
Message-ID: <1240832402.14165.4.camel@vega.slimlogic.co.uk>
References: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755035AbZD0LkZ@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net
List-Id: linux-omap@vger.kernel.org

On Sat, 2009-04-25 at 05:28 -0600, Paul Walmsley wrote:
> During regulator registration, any error after device_register() will 
> cause a double-free on the struct regulator_dev 'rdev'.  The bug is in 
> drivers/regulator/core.c:regulator_register():
> 
> ...
> scrub:
> 	device_unregister(&rdev->dev);
> clean:
> 	kfree(rdev);                           <---
> 	rdev = ERR_PTR(ret);
> 	goto out;
> ...
> 
> device_unregister() calls regulator_dev_release() which frees rdev.  The 
> subsequent kfree corrupts memory and causes some OMAP3 systems to oops on 
> boot in regulator_get().
> 
> Applies against 2.6.30-rc3.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  drivers/regulator/core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 

Applied.

Thanks

Liam
