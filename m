From: Seth Forshee <seth.forshee@gmail.com>
Subject: Re: [PATCH 1/1] PLAT: OMAP: Add device configuration to support second HSMMC slot on OMAP 2430 and 3430 boards.
Date: Sun, 23 Mar 2008 21:10:46 -0500
Message-ID: <20080324021045.GA19892@ubuntu-workstation>
References: <47E273BD.9080705@indt.org.br> <20080321004401.GA8667@ubuntu-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:37468 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbYCXCMh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Mar 2008 22:12:37 -0400
Received: by py-out-1112.google.com with SMTP id u52so3762625pyb.10
        for <linux-omap@vger.kernel.org>; Sun, 23 Mar 2008 19:12:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080321004401.GA8667@ubuntu-workstation>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, Mar 20, 2008 at 07:44:02PM -0500, Seth Forshee wrote:
> Shouldn't you only register each device if enabled in the corresponding
> configuration, i.e.:
> 
> 	if (mmc_conf->mmc[1].enabled)
> 		(void) platform_device_register(&mmc_omap_device1);
> 	if (mmc_conf->mmc[2].enabled)
> 		(void) platform_device_register(&mmc_omap_device2);

Of course that should be 0 and 1, not 1 and 2.
