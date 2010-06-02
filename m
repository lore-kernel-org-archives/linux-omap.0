From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: beagleboard expansion boards, was Trying to understand how to
 use new OMAP mux code
Date: Wed, 2 Jun 2010 16:14:18 +0300
Message-ID: <20100602161418.c6af218b.jhnikula@gmail.com>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
	<20100311224812.GU2900@atomide.com>
	<4C062DD4.2050701@cioinfoindus.fr>
	<20100602112130.GG5980@atomide.com>
	<20100602144606.4287c438.jhnikula@gmail.com>
	<3BC7A992-11AB-4EBF-B7A5-4C4B1498CC58@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f223.google.com ([209.85.219.223]:34606 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932452Ab0FBNUF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 09:20:05 -0400
Received: by ewy23 with SMTP id 23so627084ewy.1
        for <linux-omap@vger.kernel.org>; Wed, 02 Jun 2010 06:20:03 -0700 (PDT)
In-Reply-To: <3BC7A992-11AB-4EBF-B7A5-4C4B1498CC58@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Tony Lindgren <tony@atomide.com>, Laurent Epinat <laurent.epinat@cioinfoindus.fr>, linux-omap@vger.kernel.org

On Wed, 2 Jun 2010 14:56:30 +0200
Koen Kooi <koen@dominion.thruhere.net> wrote:

> > How about add-on cards for e.g. BeagleBoard? It would be nice feature
> > if a kernel module for that particular add-on card can do the muxing
> > without needing to specify them on cmdline. I.e. if you are switching
> > between cards there is no need to figure out new cmdline for each of
> > them. For me even "rootwait" is sometimes too difficult to remember :-)
> 
> What we (as in beagleboard.org) are currently doing is this:
> 
> u-boot:
> 
> http://gitorious.org/beagleboard-validation/u-boot/commit/70ed67cacbb1b7158e059b9b5d10308cce2d917a
> http://gitorious.org/beagleboard-validation/u-boot/commit/74f700341c656e1636221a53347caccbfc07c224
> 
> kernel:
> 
> http://gitorious.org/beagleboard-validation/linux/commit/32fb278553a4cd6126c1791d70aa33df12f73d90
> 
> It's very ugly and needs a rethink before it can get posted to here, but it works great! The plan is to do this as part of the patchset to add support for the 37xx based beagleboardXM.
> 
Problem is that amount of expansion boards is practically unlimited so
patching bootloader and board file could come quite maintenance effort.

Of course there are some lets say generic boards but bunch of in-house,
DIY, etc. boards and there is no point to patch common bootloader and
kernel board files because of them.


-- 
Jarkko
