From: Riku Voipio <riku.voipio@iki.fi>
Subject: Re: USB driver issue
Date: Wed, 30 Jul 2008 21:51:28 +0300
Message-ID: <20080730185127.GA26556@kos.to>
References: <31e679430807300505o3050a75ar2f9d8ff0cd35ea1b@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB02567D91E7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from naru.obs2.net ([84.20.150.76]:45766 "EHLO narury.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbYG3Svb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jul 2008 14:51:31 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02567D91E7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jul 30, 2008 at 09:53:43PM +0530, Gadiyar, Anand wrote:
> Besides, the MUSB code hasn't really changed that much in this time.

Even if that was true (which, according to Felippe's answer isn't),
the USB subsystem itself has changed quite a bit since.

> Do you really think the problem will go away in 2.6.26? People can't always use the
> latest kernel, you know. Embedded kernels don't get enough testing.

Certainly the best way to fix that is to ask embedded people to test
newer kernels then?

If for no other reason, to find out _why_ people can't use newer
kernels - If it's some valid brokenness is mainline kernels, those
bugs need to be found and fixed, rather than having developers sulking
with their old kernels...

> Grr. Saying one needs to upgrade to the latest kernel before one can expect
> support is a bit like certain proprietary OS vendors - and even they do a better
> job than this.

There is fine line between "you must use latest kernel" and "please do
me a favour and test with this latest version that already might have
the fix".

Vendors and Distributions provide stable baseline Linux kernels - but
then you should get support from the vendor rather than from community
in general. Now this mailing list is probable the right contact place
for TI provided kernels so this point is a bit moot ;)

-- 
"rm -rf" only sounds scary if you don't have backups
