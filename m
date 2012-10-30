From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 30 Oct 2012 11:47:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com> <508FB226.20604@mimc.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47927 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537Ab2J3LrB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 07:47:01 -0400
In-Reply-To: <508FB226.20604@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hvaibhav@ti.com

cc Vaibhav Hiremath

On Tue, 30 Oct 2012, Mark Jackson wrote:

> At what point is booting from MMC on the BeagleBone going to start working ?
> 
> I only ask, since, by default, a new BeagleBone is setup to boot from 
> MMC, so anyone testing a new kernel will probably expect the same setup 
> to work.

BeagleBone boots initramfs from MMC now, which is what mine was shipped to 
do.  Are you asking about rootfs on MMC?  If so, Vaibhav would have a 
better sense of this than I.


- Paul
