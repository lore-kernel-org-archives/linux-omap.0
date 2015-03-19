From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap voltage management
Date: Thu, 19 Mar 2015 13:27:50 -0700
Message-ID: <20150319202750.GM31346@atomide.com>
References: <CAJ2oMhKGG9YrM4+rVdi2wZP=y4OBmCkw3GjgwBq-HpvtbWyNVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38728 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbbCSUca (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 16:32:30 -0400
Content-Disposition: inline
In-Reply-To: <CAJ2oMhKGG9YrM4+rVdi2wZP=y4OBmCkw3GjgwBq-HpvtbWyNVg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Ran Shalit <ranshalit@gmail.com> [150319 13:05]:
> Hello,
> 
> I am using DM8148 and I get error message in boot that voltage
> management driver is not added.
> Is it supported in DM8148. If not - why ?

We currently are missing dm8148 support from mainline, dm8168
does have basic support now. Adding dm8148 will hopefully happen
too with time permitting :)

Regards,

Tony
