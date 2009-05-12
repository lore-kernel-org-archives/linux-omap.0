From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: OMAP4 naming conventions
Date: Tue, 12 May 2009 07:58:45 -0700
Message-ID: <87tz3qe5ay.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:52725 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbZELO6r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 10:58:47 -0400
Received: by wf-out-1314.google.com with SMTP id 26so18854wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 07:58:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

As the OMAP4 patches are coming in, there seems to be a bit of variety
in the naming of functions/macros/variables etc.

Could I propose that we just use omap4_* and OMAP4_* instead of
OMAP44XX_* or OMAP4XXXX_* etc.

I know that OMAP2 and OMAP3 have a variety of forms here too, but
those should probably be cleaned up eventually too.

With proper runtime revision detecting, IMO, we should only really
have the OMAP4 prefix, and leave the sub revision handling to runtime
code.

Thoughts?

Kevin
