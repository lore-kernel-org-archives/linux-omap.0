From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/7] AM3517: rename the i2c boardinfo to make it more
 readable
Date: Tue, 11 May 2010 16:19:05 -0700
Message-ID: <20100511231904.GN13931@atomide.com>
References: <1271745212-4474-1-git-send-email-stanley.miao@windriver.com>
 <1271745212-4474-4-git-send-email-stanley.miao@windriver.com>
 <19F8576C6E063C45BE387C64729E7394044E13781B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53847 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab0EKXTI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:19:08 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E13781B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Govindarajan, Sriramakrishnan" <srk@ti.com>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [100420 00:03]:
> \
> 
> > -----Original Message-----
> > From: Stanley.Miao [mailto:stanley.miao@windriver.com]
> > Sent: Tuesday, April 20, 2010 12:03 PM
> > To: linux-omap@vger.kernel.org
> > Cc: tony@atomide.com; Hiremath, Vaibhav; Govindarajan, Sriramakrishnan;
> > Aggarwal, Anuj
> > Subject: [PATCH 3/7] AM3517: rename the i2c boardinfo to make it more
> > readable
> > 
> > There are three i2c buses on am3517, now rename these three boardinfo
> > structure name to am3517evm_i2c1_boardinfo, am3517evm_i2c2_boardinfo,
> > and am3517evm_i2c3_boardinfo, to make it more readable.
> > 
> [Hiremath, Vaibhav] Since we haven't had any objection/suggestion to follow naming convention based on i2C indexes, I think we can merge this patch.
> 
> Acked-By: Vaibhav Hiremath <hvaibhav@ti.com>

Looks like this needs to be refreshed against the current
omap-for-linus branch to apply.

Regards,

Tony
