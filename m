From: Tony Lindgren <tony@atomide.com>
Subject: Re: Bug in twl4030backupbatt_voltage()
Date: Tue, 9 Sep 2008 10:42:15 -0700
Message-ID: <20080909174214.GP29054@atomide.com>
References: <48BEA8DC.3030905@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60513 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209AbYIIRmU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 13:42:20 -0400
Content-Disposition: inline
In-Reply-To: <48BEA8DC.3030905@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: linux-omap@vger.kernel.org, madhu.cr@ti.com

* Adrian Hunter <ext-adrian.hunter@nokia.com> [080903 08:08]:
> In the omap tree, commit f91fd98be045bec9c18e13110f22dafd44cb84b5
> fixed a bug with the use of function twl4030_madc_conversion()
> relating to the local variable 'struct twl4030_madc_request req'
> not being fully initialised.
>
> The same problem appears to be in the function
> twl4030backupbatt_voltage() which is in drivers/power/twl4030_bci_battery.c

Thanks, I'll initialize it to NULL. Wouldn't it have been easier just
to write a patch instead of the description above? :)

Tony
