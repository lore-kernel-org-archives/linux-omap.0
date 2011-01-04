From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: boards w/ wl12xx should select
 REGULATOR_FIXED_VOLTAGE
Date: Tue, 4 Jan 2011 11:17:33 -0800
Message-ID: <20110104191732.GI7771@atomide.com>
References: <1290593090-6288-1-git-send-email-ohad@wizery.com>
 <AANLkTinc1xopSYvaJmN_hHaQq1TP=i_HNy5vX_LhdQOh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48443 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1ADTRg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 14:17:36 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinc1xopSYvaJmN_hHaQq1TP=i_HNy5vX_LhdQOh@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [110104 10:04]:
> On Wed, Nov 24, 2010 at 12:04 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > Power to the wl12xx wlan device is controlled by a fixed regulator.
> >
> > Boards that have the wl12xx should select REGULATOR_FIXED_VOLTAGE so
> > users will not be baffled.
> >
> > Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> > ---
> 
> Hi Tony,
> 
> Gentle reminder,

This is queued for 2.6.38 in omap-for-linus as commit
7c50152f0851e44ef7491546a29fddbbea47735b?

Tony
