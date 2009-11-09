From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: Driver Merge Questions
Date: Mon, 9 Nov 2009 19:09:00 +0200
Message-ID: <20091109170900.GA1773@smtp.gmail.com>
References: <4AF040D1.7020109@kionix.com>
 <20091103165821.GG8981@atomide.com>
 <20091109092621.GY1773@smtp.gmail.com>
 <4AF82D27.2010705@kionix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:62840 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbZKIRJP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 12:09:15 -0500
Received: by fxm21 with SMTP id 21so345300fxm.21
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2009 09:09:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4AF82D27.2010705@kionix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Hudson <chudson@kionix.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 09 Nov 09, Chris Hudson wrote:
> Hello Amit,
> 
> Thank you for the information.
> 
> The driver is just about finished actually; I was going to do some
> final testing and pull and submit the patches today.  I read the
> lkml.org source and it definitely seems like things are in a state
> of limbo at the moment (well, as of a few months ago) with regard to
> sensor drivers.  So, should I submit the code as-is and work on
> changing it as necessary with the help of the community, or do I
> step back and modify for the iio subsystem before submission?
> Alternatively, since the code was originally written for the 2.6.29
> Android kernel, should I submit the current version of the driver to
> that branch first?  Please let me know.

Hi Chris,

No harm is submitting a patch for a hwmon-based driver against mainline
2.6.32-rc6 to LKML (cc the requisite maintainers). It might help get review on
obvious issues, if any. 

But be prepared to modify the driver to use IIO. I just modified a driver to
use IIO and isn't that hard - probably an afternoon's work.

Regards,
Amit
-- 
-------------------------------------------------------------------------
Amit Kucheria,				 Kernel Developer, Verdurent
-------------------------------------------------------------------------
