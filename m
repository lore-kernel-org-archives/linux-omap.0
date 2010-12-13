From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH/RFC 2/2] OMAP: PM: implement context loss count APIs
Date: Mon, 13 Dec 2010 03:43:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012130331570.15971@utopia.booyaka.com>
References: <1291939712-25487-1-git-send-email-khilman@deeprootsystems.com> <1291939712-25487-2-git-send-email-khilman@deeprootsystems.com> <44f6fc2f0c975af7273975385567acd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35732 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002Ab0LMKnX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 05:43:23 -0500
In-Reply-To: <44f6fc2f0c975af7273975385567acd2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Hello Vishwa,

On Fri, 10 Dec 2010, Vishwanath Sripathy wrote:

> > +	count = omap_device_get_context_loss_count(pdev);
> > +	pr_debug("OMAP PM: context loss count for dev %s = %d\n",
> > +		 dev_name(dev), count);
> Shouldn't this implementation be part of omap-pm.c where all the OMAP PM
> functions are to be implemented? I thought omap-pm-noop.c should have
> dummy implementation.

In general, yes.  But we also want the code in omap-pm-noop.c not to cause 
additional breakage.  Unlike most of the other functions in this file, if 
the context loss count function doesn't do something minimally useful, then
the system is going to break badly.  You've probably seen this thread:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg40079.html

(By the way, the reason why I think we shouldn't use the approach 
described in 

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg40101.html

is because I suspect it is going to seriously damage retention idle 
performance.  For example, the HSMMC driver resets its entire IP block in 
its context restore function...)

But to confirm your general point, yes, in general, further functional
development of the OMAP PM code should take place outside the no-op file.
Hopefully, at some point, we'll be able to drop the no-op file.  Once 
there is a useful replacement, we should be able to switch to it as a 
default.


- Paul
