From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] i2c drivers fixes
Date: Wed, 14 May 2008 15:26:24 -0700
Message-ID: <20080514222624.GC8928@atomide.com>
References: <1210681330-1442-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59863 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbYENW0Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 18:26:24 -0400
Content-Disposition: inline
In-Reply-To: <1210681330-1442-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080513 05:24]:
> Basically add i2c_device_id and fix some warnings.
> 
> Felipe Balbi (4):
>   I2C: TSL2563: Add i2c_device_id
>   I2C: LP5521: Add i2c_device_id
>   I2C: RADIO: TEA5761: Add i2c_device_id
>   I2C: Get rid of warnings
> 
>  drivers/i2c/chips/lp5521.c          |   11 +++++++++--
>  drivers/i2c/chips/tsl2563.c         |   11 +++++++++--
>  drivers/input/keyboard/lm8323.c     |    2 +-
>  drivers/media/radio/radio-tea5761.c |   11 +++++++++--
>  4 files changed, 28 insertions(+), 7 deletions(-)
> 

Pushing today.

Tony
