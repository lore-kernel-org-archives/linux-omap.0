From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] OMAP3: PM: More pedantic parameter and error checking in smartreflex
Date: Wed, 13 May 2009 09:54:33 -0700
Message-ID: <87ab5h6j06.fsf@deeprootsystems.com>
References: <1240849585-14828-1-git-send-email-ext-phil.2.carmody@nokia.com>
	<87bppx82du.fsf@deeprootsystems.com>
	<1242228960.9103.119.camel@pcarmody-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:51348 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081AbZEMQye (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 12:54:34 -0400
Received: by wf-out-1314.google.com with SMTP id 26so514098wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 09:54:36 -0700 (PDT)
In-Reply-To: <1242228960.9103.119.camel@pcarmody-desktop> (Phil Carmody's message of "Wed\, 13 May 2009 18\:36\:00 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-phil.2.carmody@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Phil Carmody <ext-phil.2.carmody@nokia.com> writes:

> On Wed, 2009-05-13 at 17:10 +0200, ext Kevin Hilman wrote:
>> Phil Carmody <ext-phil.2.carmody@nokia.com> writes:
>> 
>> > A couple of simple patches to improve error handling in smartreflex.
>> > The first has a practical benefit of avoiding a string-based search
>> > in situtations where the result wouldn't be needed. The second is
>> > simple paranoia.
>> 
>> Thanks, pushing this series today.
>> 
>> Note that I pushed this on top of Rajendra's patch:
>> "OMAP3: SR: Fix SR driver to check for omap-pm return values"
>> and had to resolve a couple of conflicts.
>> 
>> Could you please sanity check it?
>
> Sanity check successful. Many thanks, Kevin.
>

Hmm, you're too fast for me.
Not sure how you tested as I hadn't pushed your changes yet ;)

I just pushed them to my pm branch, but they are not yet sync'd to
tony's tree.  Can you try now.

Kevin

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git
