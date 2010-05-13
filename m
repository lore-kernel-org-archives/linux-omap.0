From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] omap hsmmc: fix the hsmmc driver for am3517.
Date: Thu, 13 May 2010 08:58:44 -0700
Message-ID: <20100513155843.GA31224@atomide.com>
References: <1271745212-4474-1-git-send-email-stanley.miao@windriver.com>
 <1271745212-4474-8-git-send-email-stanley.miao@windriver.com>
 <20100511232656.GO13931@atomide.com>
 <4BEBE829.8020801@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59102 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758927Ab0EMP6u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 11:58:50 -0400
Content-Disposition: inline
In-Reply-To: <4BEBE829.8020801@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org, hvaibhav@ti.com, srk@ti.com, anuj.aggarwal@ti.com

* stanley.miao <stanley.miao@windriver.com> [100513 04:38]:
> We can move other features into the variable "features", such as
> "nonremovable", "power_saving".

Great, that sounds good to me. Might help with the mmc init issues
for omap4 also.

Regards,

Tony
