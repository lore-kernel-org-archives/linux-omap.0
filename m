From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Power management in omap3430
Date: Thu, 02 Oct 2008 12:15:12 +0300
Message-ID: <87zllnwe73.fsf@deeprootsystems.com>
References: <cb629f950809290813x26df9a28v295aabfd50840c1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:36913 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbYJBJPW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 05:15:22 -0400
Received: by fk-out-0910.google.com with SMTP id 18so507624fkq.5
        for <linux-omap@vger.kernel.org>; Thu, 02 Oct 2008 02:15:21 -0700 (PDT)
In-Reply-To: <cb629f950809290813x26df9a28v295aabfd50840c1c@mail.gmail.com> (monte L.'s message of "Mon\, 29 Sep 2008 20\:43\:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: monte L <montesnl987@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi Monte,

"monte L" <montesnl987@gmail.com> writes:

> I just got hold of omapzoom and am running linux from omapzoom site.
>
> Since I am new to omap, request some guidance on power mgmt:
>
> - Is OMAP PM interface from Paul the current power mgmt framework for omap3430?
> - Does it work together with PM QoS or any other framework (I have
> read Kevin's comments:
> http://marc.info/?l=linux-omap&m=120962073813933&w=2) Is there an
> update on this - will they co-exist?

In terms of power management, the omapzoom tree and the linux-omap
tree have very different approaches.  Currently, the only public tree
with fully functional PM is the omapzoom tree.  

The interfaces you mention above are not part of omapzoom, but are
being worked on for the linux-omap tree.  Paul, myself, some folks at
Nokia (Jouni Hogander, Tero Kristo, Peter De Schrijver) and some folks
at TI (Rajendra Nayak) are working on organizing and stabilizing the
various PM efforts into something that can be merged into the
linux-omap tree.  To that end, I've started to maintain PM branches of
the linux-omap tree where these efforts will be focused.  The current
branch is pm-0 which contains support for retention and OFF-mode in
suspend and dynamic idle tested mainly on OMAP3430SDP boards.

The pm-1 branch will shortly contain updated versions of pm-0 patches,
and several of the pm-0 patches have been merged into linux-omap.  The
'OMAP PM interface' will be included in pm-1 (or maybe pm-2), but will
be included shortly.  Re: PM QoS, the OMAP PM layer and the CPUidle
layer work together with PM QoS constraints, and they are taken into
consideration during various PM decisions.

The goal of these pm-N branches is to get this PM code in shape so it
can be merged into linux-omap and then to mainline.

> My work involves porting few middleware and applications on to
> OMAP3430 platform. I am seeking your help in how to go about
> handling power management aspects, which are so elaborate in omap3.

If you need something working out of the box today, then omapzoom is
the only tree will fully functional PM in the kernel, and all the
driver changes required to support the various PM states.

That being said, what the power management goals of your middleware
applications?  Are you expecting for your applications to communicate
various PM requirements to the kernel?

Hope that helps,

Kevin
