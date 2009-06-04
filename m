From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/06] OMAP3430 Errata, defect fixes and optimizations
Date: Thu, 04 Jun 2009 16:31:01 -0700
Message-ID: <87oct3d1ai.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03057E76B6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:3053 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbZFDXbC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 19:31:02 -0400
Received: by rv-out-0506.google.com with SMTP id f9so218275rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 04 Jun 2009 16:31:04 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03057E76B6@dbde02.ent.ti.com> (Rajendra Nayak's message of "Thu\, 28 May 2009 18\:13\:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> This series contains a set of patches which implement new 3430 errata, and some optimizations
> and fixes in the SR driver and DVFS path.
>
> These apply on the latest 'pm' branch and are validated on a 3430SDP platform.

Thanks, applying all but the scratchpad locking patch to PM branch.
See comment/question on that patch.

Kevin
