From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 0/5] omap3: pm: Update TRITON power scripts and making it generic
Date: Tue, 06 Apr 2010 14:23:07 -0700
Message-ID: <877hoknumc.fsf@deeprootsystems.com>
References: <1270030752-1900-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47372 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756691Ab0DFVXO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 17:23:14 -0400
Received: by vws13 with SMTP id 13so168691vws.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 14:23:13 -0700 (PDT)
In-Reply-To: <1270030752-1900-1-git-send-email-leslyam@ti.com> (Lesly A. M.'s message of "Wed\, 31 Mar 2010 15\:49\:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org

Lesly A M <leslyam@ti.com> writes:

> This series of patch implements a updated TRITON power scripts.
> Also moving the sleep, wakeup & warm_reset sequence to a generic script file,
> which can be used by different OMAP3 board with the power companion chip TWL4030.
>
> This patch series is based off Kevin's tree origin/pm branch.

Hmm, I don't think so.  It appears to be based off of Thara's SR
series.

Kevin
