From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC part1/2 merge][PATCH 00/10] omap2/3/4: uart4 fixes + zoom2/3 changes
Date: Fri, 05 Mar 2010 14:40:53 -0800
Message-ID: <87iq9az91m.fsf@deeprootsystems.com>
References: <1267625925-22616-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f189.google.com ([209.85.210.189]:38164 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836Ab0CEWk7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 17:40:59 -0500
Received: by yxe27 with SMTP id 27so2338379yxe.21
        for <linux-omap@vger.kernel.org>; Fri, 05 Mar 2010 14:40:58 -0800 (PST)
In-Reply-To: <1267625925-22616-1-git-send-email-saaguirre@ti.com> (Sergio Aguirre's message of "Wed\,  3 Mar 2010 08\:18\:35 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org

Sergio Aguirre <saaguirre@ti.com> writes:

> Hi,
>
> This is a merge of my previously posted RFC series [1] and [2],
> and is meant to be applied on top of Thomas's Patch [3].
>
> Changelog compared to previous versions:
>  - Series merged, as mentioned above.
>  - Dropped omap_serial_init rename.
>  - Added patch for zoom2/3 defconfig to init only one port.
>
> Please let me know your comments and thoughts.
>
> Thanks to:
>  - Vikram Pandita
>  - Paul Walmsley
>  - Kevin Hilman
>  - Manjunath Kondaiah
>
> For the feedback recieved so far. I really appreciate it.

Other than my minor comment on the symbolic constant, this series
looks good to me.  

Tested on 3430 (OMAP3EVM) and 3630 (Zoom3).  

Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

Would be nice to see a quick test on OMAP4.

Kevin
