From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 032/493] arm: remove use of __devexit_p
Date: Tue, 20 Nov 2012 09:59:49 -0800
Message-ID: <20121120175949.GI18567@atomide.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-32-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:24949 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751868Ab2KTSAB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 13:00:01 -0500
Content-Disposition: inline
In-Reply-To: <1353349642-3677-32-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Russell King <linux@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org

* Bill Pemberton <wfp5p@virginia.edu> [121119 10:29]:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.

For the arch/arm/*omap*/* touching patches:

Acked-by: Tony Lindgren <tony@atomide.com>
