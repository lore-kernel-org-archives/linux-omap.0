From: Tony Lindgren <tony@atomide.com>
Subject: Re: Which git repo for OMAP4430 Pandaboard
Date: Tue, 26 Apr 2011 11:54:52 +0300
Message-ID: <20110426085452.GI16892@atomide.com>
References: <B24DE2DC-DF8B-43DD-988F-ADC1A1F66AC1@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:44809 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752388Ab1DZIyy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Apr 2011 04:54:54 -0400
Content-Disposition: inline
In-Reply-To: <B24DE2DC-DF8B-43DD-988F-ADC1A1F66AC1@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

* Elvis Dowson <elvis.dowson@mac.com> [110426 11:44]:
> Hi,
>        Which git repo should I consider using for OMAP4430 Pandaboard kernel development?
> 
> a. mainline linux-2.6 repo

You should do all the patches against the mainline kernel where possible
to avoid rebasing them later on.

Some patches of course may have dependencies to other branches, but in
those cases you should question how come those dependencies exist. 
Usually those dependencies can be sorted out in the mainline kernel.

Regards,

Tony
