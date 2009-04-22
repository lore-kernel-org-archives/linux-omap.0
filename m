From: twebb <taliaferro62@gmail.com>
Subject: Re: lcd rotation in omapfb_main.c
Date: Wed, 22 Apr 2009 11:38:20 -0400
Message-ID: <dbdb2ea60904220838j2dca852bq402c11de5ae67f4e@mail.gmail.com>
References: <dbdb2ea60904211518o2539b4e1y80750587bebc30a1@mail.gmail.com>
	 <200904220029.30297.marek.vasut@gmail.com>
	 <dbdb2ea60904220539y61bc6dadgb895c4122f892b24@mail.gmail.com>
	 <1f11a5490904220625g26876f68wf5b9a77ed0ed2f4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:45222 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbZDVPiW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 11:38:22 -0400
Received: by gxk10 with SMTP id 10so59722gxk.13
        for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 08:38:21 -0700 (PDT)
In-Reply-To: <1f11a5490904220625g26876f68wf5b9a77ed0ed2f4e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Koen Kooi <k.kooi@student.utwente.nl>

>
> The L-O tree is already about 2.6.30, so you're essentially 3
> revisions out and you're just setting yourself up for a bunch of work
> to port numerous changes into your Kernel.
>
> And as Greg KH would probably say, 5 months in Kernel development land
> is a really long period of time. :)
>
> -- Ashwin
>

Thanks for the clarification.  Maybe you could help me understand
something about the l-o tree.  From what I see on the git, the latest
tagged l-o version is 2.6.30-rc2, but my understanding is that only
tags that include "-omapX" have had the latest omap patches applied to
it.  So I'm not sure what the best choice would be for the 'newest
kernel I can find'.  Maybe another way to ask this is which would
offer better, reasonably stable, omap support: tagged tree
v2.6.28-omap1 or v2.6.29, or head omap-2.6.28 or omap-2.6.29 or
omap-fixes?

Thanks.
