From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
Date: Thu, 12 Apr 2012 06:10:45 -0700
Message-ID: <20120412131045.GB31384@kroah.com>
References: <1331934707-29487-1-git-send-email-aneesh@ti.com>
 <alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com>
 <20120412030044.GA26236@kroah.com>
 <4F867A95.9030104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43261 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757566Ab2DLNKt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 09:10:49 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2C49821ADD
	for <linux-omap@vger.kernel.org>; Thu, 12 Apr 2012 09:10:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4F867A95.9030104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Aneesh V <aneesh@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, mgreer@animalcreek.com, msalter@redhat.com

On Thu, Apr 12, 2012 at 12:17:49PM +0530, Santosh Shilimkar wrote:
> I was hoping that we will have some thing like drivers/memory/*
> but since it doesn't exist, we used drivers/misc.

Why not create it?  I have no objection to that, it makes it more
obvious as to what this really is.

greg k-h
