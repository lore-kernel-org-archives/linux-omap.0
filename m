From: Tony Lindgren <tony@atomide.com>
Subject: Re: [2.6.29-rc7][take #2][PATCH 0/3] ARM: OMAP: Add command line
	option for I2C bus speed
Date: Mon, 9 Mar 2009 10:19:02 -0700
Message-ID: <20090309171901.GE7329@atomide.com>
References: <1236606359-20362-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49986 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbZCIRTI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 13:19:08 -0400
Content-Disposition: inline
In-Reply-To: <1236606359-20362-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [090309 06:46]:
> Hi
> 
> Tony, I added kernel-parameters.txt change to the patches 2 and 3. Otherwise
> set is the same than currently in linux-omap. Set is generated on top of
> mainline version 2.6.29-rc7. Earlier discussion was
> 
> http://marc.info/?l=linux-omap&m=123635604511892&w=2

Thanks, they look OK to me. Can you please reply to that earlier thread
with these updated patches, and add linux-i2c@vger.kernel.org to Cc?
Then the I2C people can give their comments on the cmdline option.

Regards,

Tony
