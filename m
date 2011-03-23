From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/7] OMAP2+: voltage layer cleanup and restructure.
Date: Tue, 22 Mar 2011 17:31:14 -0700
Message-ID: <87vczaad9p.fsf@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:45594 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750835Ab1CWAbS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Mar 2011 20:31:18 -0400
Received: by mail-iy0-f178.google.com with SMTP id 12so10086173iyi.23
        for <linux-omap@vger.kernel.org>; Tue, 22 Mar 2011 17:31:16 -0700 (PDT)
In-Reply-To: <1300493932-17362-1-git-send-email-khilman@ti.com> (Kevin
	Hilman's message of "Fri, 18 Mar 2011 17:18:45 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Kevin Hilman <khilman@ti.com> writes:

> In order to implement a clean DVFS layer, the current voltage layer
> needs quite a bit of cleanup and restructure.  Many of the details
> were described by Paul in his initial cleanup[1], and this series is
> continuing in that direction.
>
> This series is currently also available in my pm-wip/voltdm branch and
> based on my pm-core branch.

FYI... while waiting for me to post an updated series here (which now
has a bunch more patches) you're free to look at my current
pm-wip/voltdm branch which has all my work-in-progress.

Kevin

