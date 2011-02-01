From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP: hwmod: Do not expect an entry in clkdev to add
 alias for opt_clks
Date: Tue, 1 Feb 2011 09:53:06 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102010948320.15746@utopia.booyaka.com>
References: <1296213475-23460-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1101311606030.16671@utopia.booyaka.com> <997a6c2b061aee29cd2d0c755d4ad80c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58296 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab1BAQxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 11:53:07 -0500
In-Reply-To: <997a6c2b061aee29cd2d0c755d4ad80c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 1 Feb 2011, Rajendra Nayak wrote:

> One other thing I was thinking of is if the function name
> _add_optional_clock_alias need to be changed to something like
> _add_optional_clock_clkdev since we are adding a new clkdev entry,
> if it does not exist, and no longer adding an 'alias' for an existing
> entry.

Fine with me.

> Also, the adding of an entry in clkdev is today done for
> optional clocks alone. Is there any reason why we should not do
> this at runtime for all main clks and interface clks also.
> That way we get rid of all dependencies with the static clkdev
> table, and we might infact not need one if all entries are added
> runtime.

Heh, you've just uncovered my "secret" plan.  It seemed best to me to wait 
until all of the hwmod conversions were done to avoid alarming certain 
people who might be consulting the static clkdev table in 
mach-omap2/clock*_data.c as a platform reference...


- Paul
