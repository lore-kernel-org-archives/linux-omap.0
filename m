From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/7] OMAP4: Add 4460 base support
Date: Fri, 01 Jul 2011 09:36:17 -0700
Message-ID: <87boxe2c1q.fsf@ti.com>
References: <1309486081-8257-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:55911 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756943Ab1GAQgW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 12:36:22 -0400
Received: by mail-iy0-f182.google.com with SMTP id 11so5312181iyb.27
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 09:36:21 -0700 (PDT)
In-Reply-To: <1309486081-8257-1-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Fri, 1 Jul 2011 07:37:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com

Rajendra Nayak <rnayak@ti.com> writes:

> This series adds base support needed to be able
> to boot on a OMAP4460 device.
> Patches are based on Benoit's for_3.0.1/7_hwmod_modulemode
> branch and boot tested on both 4460sdp as well as 4430sdp.

Can you also briefly summarize the dependencies between this series an
Benoit's?   I'm assuming it is mainly because of the s/4430/44XX/
changes, and also avoiding conflicts in clockdomain and powerdomain data
files.

With that, you can add

Reviewed-by: Kevin Hilman <khilman@ti.com>

for the whole series.

Kevin
