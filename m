From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/5] staging: tidspbridge: for 3.9
Date: Thu, 17 Jan 2013 16:47:46 -0800
Message-ID: <20130118004746.GA8897@kroah.com>
References: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38447 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab3ARAru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jan 2013 19:47:50 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so1785679pad.4
        for <linux-omap@vger.kernel.org>; Thu, 17 Jan 2013 16:47:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@copitl.com>
Cc: devel@driverdev.osuosl.org, Chen Gang <gang.chen@asianux.com>, linux-omap@vger.kernel.org

On Thu, Jan 10, 2013 at 03:36:57AM -0600, Omar Ramirez Luna wrote:
> Patches for staging-next, fixing comments and suggestions provided
> by Chen Gang.
> 
> There is an additional scm patch, that removes hardcoded defines
> related to direct register handling for SCM, it was dependent on
> changes that already made it to mainline.

What is the status on getting this out of the staging tree?  What needs
to be done still?

thanks,

greg k-h
