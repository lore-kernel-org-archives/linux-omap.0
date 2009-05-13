From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] OMAP3: PM: More pedantic parameter and error checking in smartreflex
Date: Wed, 13 May 2009 08:10:37 -0700
Message-ID: <87bppx82du.fsf@deeprootsystems.com>
References: <1240849585-14828-1-git-send-email-ext-phil.2.carmody@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:11186 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbZEMPKi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 11:10:38 -0400
Received: by wf-out-1314.google.com with SMTP id 26so472471wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 08:10:39 -0700 (PDT)
In-Reply-To: <1240849585-14828-1-git-send-email-ext-phil.2.carmody@nokia.com> (Phil Carmody's message of "Mon\, 27 Apr 2009 19\:26\:23 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: linux-omap@vger.kernel.org

Phil Carmody <ext-phil.2.carmody@nokia.com> writes:

> A couple of simple patches to improve error handling in smartreflex.
> The first has a practical benefit of avoiding a string-based search
> in situtations where the result wouldn't be needed. The second is
> simple paranoia.

Thanks, pushing this series today.

Note that I pushed this on top of Rajendra's patch:
"OMAP3: SR: Fix SR driver to check for omap-pm return values"
and had to resolve a couple of conflicts.

Could you please sanity check it?

Thanks,

Kevin
