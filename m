From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM Architecture and GENERIC_CMOS_UPDATE
Date: Tue, 1 Feb 2011 14:32:53 -0800
Message-ID: <20110201223252.GG3358@atomide.com>
References: <5CF2B383-9CD5-4295-82C5-9466311E1E62@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19673 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab1BAWdI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 17:33:08 -0500
Content-Disposition: inline
In-Reply-To: <5CF2B383-9CD5-4295-82C5-9466311E1E62@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Erickson <marathon96@gmail.com>
Cc: linux-omap@vger.kernel.org

* Grant Erickson <marathon96@gmail.com> [110128 16:34]:
> Is there any reason, to date, that the ARM architecture has not had the following kernel configuration option?
> 
> 	config GENERIC_CMOS_UPDATE
> 	    def_bool y

Looks like it would just require implementing update_persitent_clock.
No idea why it's not done for ARM , maybe send some patches for that?

Tony
