From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/1] OMAP3 PM Add C0 state
Date: Mon, 23 Feb 2009 10:24:24 -0800
Message-ID: <87ljrx9fl3.fsf@deeprootsystems.com>
References: <1234974118-27446-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:30347 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814AbZBWSY3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:24:29 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2043918rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2009 10:24:27 -0800 (PST)
In-Reply-To: <1234974118-27446-1-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Wed\, 18 Feb 2009 18\:21\:57 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> This patch introduces a new C state C0 which keeps both core and mpu
> powerdomains in ON state. This gives us low latency at a cost of higher
> power consumption.
>

I don't like the name 'C0' for an idle-state.  In ACPI terms, C0 is an
active state, not an idle state.  I know this is not an ACPI system,
but since we're using ACPI names, we should be consistent.

Is there a real benefit to having an additional state here?  Shouldn't
we just make these changes or C1?

Also, for a single patch, can you include the description in the patch
itself instead of the 'PATCH 0/1'.  Thanks.

Kevin

