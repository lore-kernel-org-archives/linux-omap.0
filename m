From: Tony Lindgren <tony@atomide.com>
Subject: Re: gpio_expander_omap removal?
Date: Mon, 24 Nov 2008 09:42:49 -0800
Message-ID: <20081124174247.GB4927@atomide.com>
References: <5d5443650811240917q1215d424sdaec82889dbe2b49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62033 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbYKXRmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 12:42:50 -0500
Content-Disposition: inline
In-Reply-To: <5d5443650811240917q1215d424sdaec82889dbe2b49@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Trilok Soni <soni.trilok@gmail.com> [081124 09:18]:
> Any plans to remove gpio expander APIs from drivers/i2c/chips?
> 
> I hope gpio_xxx APIs from gpiolib will work directly over pcf857x.

Yes, let's get rid of that.

Tony
