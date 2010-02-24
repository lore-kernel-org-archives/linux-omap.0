From: Tony Lindgren <tony@atomide.com>
Subject: Re: [ANNOUNCE] dspbridge: kill camelcase
Date: Tue, 23 Feb 2010 19:13:26 -0800
Message-ID: <20100224031325.GM28173@atomide.com>
References: <4B848B9B.2030002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53463 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab0BXDM1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 22:12:27 -0500
Content-Disposition: inline
In-Reply-To: <4B848B9B.2030002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Omar Ramirez Luna <omar.ramirez@ti.com> [100223 18:11]:
> 
> Hi All,
> 
> I'm currently working on removing camel case + hungarian notation
> from dspbridge code in the following branch:
> 
> dspbridge-next-camelcase on d.o-z
> 
> I'll appreciate if you can mail any unsent patch otherwise it will
> need to wait (and be rebased) after the camelcase changes.
> 
> If nobody disagrees I'll be marking dspbridge 0.2 (as per private
> discussion) in the upcoming days.

Maybe do a perl or sed script that allows you to convert one
string at a time? That way you can regenerate the patches as
needed.

We used something like that to convert the musb code a few
years ago.

I recommend converting one variable at a time and then compile
and boot test in between. Otherwise you can easily convert
substrings accidentally and then things will not compile..

Regards,

Tony
