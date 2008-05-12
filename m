From: Tony Lindgren <tony@atomide.com>
Subject: Re: Error displaying commit 4ca958bea8c1d6 in gitweb
Date: Mon, 12 May 2008 09:08:13 -0700
Message-ID: <20080512160812.GA28999@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02224F66E6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54423 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbYELQIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2008 12:08:15 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02224F66E6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "lvcargnini@gmail.com" <lvcargnini@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [080512 06:01]:
> Hi Tony,
> 
> I was trying to look at the history of the following file in gitweb:
>         <include/asm-arm/arch-omap/mcbsp.h>
> 
> It throws a parsing error seemingly because of characters in the above
> commit's Author field.
> 
> Any chance we can fix this? (I'm not even sure if we should, but if Luis
> doesn't mind, maybe we could change it to something displayable).

Well we could git-revert and reapply it, but I don't know if that
really helps considering that it's been since September 2007.

At least this displays it fine (with the messed up character set
though):

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=4ca958bea8c1d6e3ad9725a112757013313d3bb5

Tony
