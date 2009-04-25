From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: lcd rotation in omapfb_main.c
Date: Sat, 25 Apr 2009 17:31:36 +0200
Message-ID: <200904251731.36722.marek.vasut@gmail.com>
References: <dbdb2ea60904211518o2539b4e1y80750587bebc30a1@mail.gmail.com> <1f11a5490904220625g26876f68wf5b9a77ed0ed2f4e@mail.gmail.com> <dbdb2ea60904220838j2dca852bq402c11de5ae67f4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:62197 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbZDYPbe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Apr 2009 11:31:34 -0400
Received: by bwz7 with SMTP id 7so1550296bwz.37
        for <linux-omap@vger.kernel.org>; Sat, 25 Apr 2009 08:31:32 -0700 (PDT)
In-Reply-To: <dbdb2ea60904220838j2dca852bq402c11de5ae67f4e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Koen Kooi <k.kooi@student.utwente.nl>

On Wednesday 22 of April 2009 17:38:20 twebb wrote:
> > The L-O tree is already about 2.6.30, so you're essentially 3
> > revisions out and you're just setting yourself up for a bunch of work
> > to port numerous changes into your Kernel.
> >
> > And as Greg KH would probably say, 5 months in Kernel development land
> > is a really long period of time. :)
> >
> > -- Ashwin
>
> Thanks for the clarification.  Maybe you could help me understand
> something about the l-o tree.  From what I see on the git, the latest
> tagged l-o version is 2.6.30-rc2, but my understanding is that only
> tags that include "-omapX" have had the latest omap patches applied to
> it.  So I'm not sure what the best choice would be for the 'newest
> kernel I can find'.  Maybe another way to ask this is which would
> offer better, reasonably stable, omap support: tagged tree
> v2.6.28-omap1 or v2.6.29, or head omap-2.6.28 or omap-2.6.29 or
> omap-fixes?

I'm not an omap person anymore (though I'll miss working on my omap devices). 
But, according to README[1], the git address is [2] and you should be fine 
just doing git clone [3] on it.

[1] http://www.muru.com/linux/omap/README_OMAP_GIT
[2] 
http://git.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary
[3] git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>
> Thanks.
