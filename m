From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH/RFC 2/2] OMAP: PM: implement context loss count APIs
Date: Mon, 13 Dec 2010 19:18:35 +0530
Message-ID: <940a49d978e2d610b2349f42d56614cc@mail.gmail.com>
References: <1291939712-25487-1-git-send-email-khilman@deeprootsystems.com>
 <1291939712-25487-2-git-send-email-khilman@deeprootsystems.com>
 <44f6fc2f0c975af7273975385567acd2@mail.gmail.com> <alpine.DEB.2.00.1012130331570.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:41745 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757857Ab0LMNsg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 08:48:36 -0500
Received: by mail-iy0-f172.google.com with SMTP id 42so834410iyi.3
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 05:48:35 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012130331570.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, December 13, 2010 4:13 PM
> To: Vishwanath Sripathy
> Cc: Kevin Hilman; linux-omap@vger.kernel.org
> Subject: RE: [PATCH/RFC 2/2] OMAP: PM: implement context loss count
> APIs
>
> Hello Vishwa,
>
> On Fri, 10 Dec 2010, Vishwanath Sripathy wrote:
>
> > > +	count = omap_device_get_context_loss_count(pdev);
> > > +	pr_debug("OMAP PM: context loss count for dev %s = %d\n",
> > > +		 dev_name(dev), count);
> > Shouldn't this implementation be part of omap-pm.c where all the
> OMAP PM
> > functions are to be implemented? I thought omap-pm-noop.c should
> have
> > dummy implementation.
>
> In general, yes.  But we also want the code in omap-pm-noop.c not to
> cause
> additional breakage.  Unlike most of the other functions in this file,
if
> the context loss count function doesn't do something minimally useful,
> then
> the system is going to break badly.  You've probably seen this thread:
>
> http://www.mail-archive.com/linux-
> omap@vger.kernel.org/msg40079.html
>
> (By the way, the reason why I think we shouldn't use the approach
> described in
>
> http://www.mail-archive.com/linux-
> omap@vger.kernel.org/msg40101.html
>
> is because I suspect it is going to seriously damage retention idle
> performance.  For example, the HSMMC driver resets its entire IP block
in
> its context restore function...)
>
> But to confirm your general point, yes, in general, further functional
> development of the OMAP PM code should take place outside the no-op
> file.
> Hopefully, at some point, we'll be able to drop the no-op file.  Once
> there is a useful replacement, we should be able to switch to it as a
> default.
I have no issues with the implementation and I agree. All I am saying is
that why can't this implementation be added in omap-pm.c and compile this
file instead of omap-pm-noop.c when OMAP_PM is enabled. I believe this
function is useful when off mode is enabled which means OMAP_PM is
enabled.

Vishwa
>
>
> - Paul
