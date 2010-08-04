From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] [omap1] Bluetooth device code common to HTC
 smartphones
Date: Wed, 4 Aug 2010 13:15:07 +0300
Message-ID: <20100804101507.GG9881@atomide.com>
References: <1280762976-17284-1-git-send-email-darkstar6262@gmail.com>
 <1280762976-17284-5-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62125 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177Ab0HDKOj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 06:14:39 -0400
Content-Disposition: inline
In-Reply-To: <1280762976-17284-5-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100802 18:23]:
> This change adds in a bluetooth controld driver/rfkill
> interface to the serial bluetooth controller found on many
> HTC smartphones such as the HTC Herald and HTC Wizard.

To me it looks like most of this should be in drivers/bluetooth/omap7xx.c
or something like that. Then you can just pass it the gpio numbers in
the platform_data.
 
Regards,

Tony
