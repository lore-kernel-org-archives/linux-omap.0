From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap-pm: Fixes behaviour of some shared resource framework functions
Date: Tue, 13 Oct 2009 12:06:24 -0700
Message-ID: <87iqejktan.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DDCE4650@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:49015 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbZJMTHC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 15:07:02 -0400
Received: by pxi10 with SMTP id 10so156488pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 12:06:26 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDCE4650@dbde02.ent.ti.com> (Romit Dasgupta's message of "Wed\, 7 Oct 2009 18\:11\:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Dasgupta, Romit" <romit@ti.com> writes:

> (Tested on Zoom2).
>
> 'omap_pm_dsp_set_min_opp' & 'omap_pm_cpu_set_freq' were using their own
> struct device *. This is a problem because invoking these functions from
> different clients would result in setting of the resource level as requested by
> the last caller. Fixes this by introducing a struct device * to the parameter
> list for these functions.
> Signed-off-by: Romit Dasgupta <romit@ti.com>


This looks like the right fix to me.

Paul, any comments?

Kevin

