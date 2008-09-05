From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Fri, 5 Sep 2008 10:23:05 -0700
Message-ID: <5e088bd90809051023t6aab7d93jd04d18d6843cb4e6@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	 <20080905011235.GZ23085@atomide.com>
	 <5e088bd90809042318k762df6c8k79ef1fcbad9a8781@mail.gmail.com>
	 <20080905165641.GI24202@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:16671 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbYIERXH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 13:23:07 -0400
Received: by py-out-1112.google.com with SMTP id p76so308319pyb.10
        for <linux-omap@vger.kernel.org>; Fri, 05 Sep 2008 10:23:06 -0700 (PDT)
In-Reply-To: <20080905165641.GI24202@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> At least the first patch needs to be updated for phys_pbase instead of
> virt_base.

Yes it does, mcbsp is likely still working by the same accident of fate.

> Hmm, is the musb broken now?

It is on Overo if I base my patches against current top of tree
(a376251519ced5831ed07ed234430725230ed93a)

Doesn't crash, just quietly doesn't work.  I hear from Beagle folk
that musb doesn't work there either.   I have it configured as a host
port, and IIRC so do the Beagle folks

If I base my patches against the state of the tree just prior to the
move to rc5 (81c893795c2e1fbe0bf5f638ed6ae1e500b80a2d), musb works as
well as it ever has.

Steve
