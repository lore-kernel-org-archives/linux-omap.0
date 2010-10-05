From: Greg KH <greg@kroah.com>
Subject: Re: [PATCHv2 01/11] staging: tidspbridge: replace iommu custom for
 opensource implementation
Date: Tue, 5 Oct 2010 08:55:41 -0700
Message-ID: <20101005155541.GA24456@kroah.com>
References: <1285899178-14413-1-git-send-email-x0095840@ti.com>
 <1285899178-14413-2-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:56003 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048Ab0JEQK0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 12:10:26 -0400
Content-Disposition: inline
In-Reply-To: <1285899178-14413-2-git-send-email-x0095840@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fernando Guzman Lugo <x0095840@ti.com>
Cc: gregkh@suse.de, felipe.contreras@nokia.com, ameya.palande@nokia.com, nm@ti.com, Hiroshi.DOYU@nokia.com, ohad@wizery.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org

On Thu, Sep 30, 2010 at 09:12:48PM -0500, Fernando Guzman Lugo wrote:
> Now the tidspbridge uses the API's from
> iovmm module.
> 
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>

This patch applied, but number 2 and others didn't.  Care to respin
those against the new linux-next tree and resend?

thanks,

greg k-h
