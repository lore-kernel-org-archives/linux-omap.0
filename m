From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/0] Power domain and clock domain patches for omap
Date: Wed, 20 Aug 2008 00:38:20 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808200034010.26647@utopia.booyaka.com>
References: <1216221555-18958-1-git-send-email-tony@atomide.com> <g8feuo$i9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56064 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbYHTGiV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 02:38:21 -0400
In-Reply-To: <g8feuo$i9$1@ger.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Hello Dmitry,

On Tue, 19 Aug 2008, Dmitry Baryshkov wrote:

> There is one major flaw IMO in this code. Please correct me if I'm wrong:
> Driver A: powerdomain_register()
> Driver B: powerdomain_get()
> Driver A: powerdomain_unregister()
> 
> Then Driver B has a reference to unregistered domain. And as powerdomains
> lack any type of refcounting this can lead to any type of memory access
> bugs if Driver A is unloaded from the kernel.

At this point, only OMAP kernel init code registers powerdomains in 
arch/arm/mach-omap2/io.c.  It's not intended that driver code will 
manipulate or even know about these.

Thanks for the comments,

- Paul
