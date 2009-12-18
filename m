From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/12] OMAP OPP: remove some unnecessary variables
Date: Fri, 18 Dec 2009 09:28:09 -0800
Message-ID: <87d42cxkd2.fsf@deeprootsystems.com>
References: <20091218004617.7694.84525.stgit@localhost.localdomain>
	<20091218004730.7694.17270.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:53774 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbZLRR2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 12:28:12 -0500
Received: by pwj9 with SMTP id 9so2033462pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 09:28:12 -0800 (PST)
In-Reply-To: <20091218004730.7694.17270.stgit@localhost.localdomain> (Paul Walmsley's message of "Thu\, 17 Dec 2009 17\:47\:32 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: nm@ti.com, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> No need to allocate new variables; the passed-in OPP list pointers do nicely
> as iterators.

Thanks Paul for this series.  I totally agree with the cleanups you've
done.

I've rebased this on top of my current pm-wip-opp branch and will include it
in the next push of that branch for broader use and testing.

Kevin

