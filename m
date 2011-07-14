From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 0/5] OMAP SMPS regulator driver
Date: Wed, 13 Jul 2011 17:22:50 -0700
Message-ID: <87ipr5n21x.fsf@ti.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:49411 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752448Ab1GNAW4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jul 2011 20:22:56 -0400
Received: by mail-iy0-f173.google.com with SMTP id 3so6744494iyb.4
        for <linux-omap@vger.kernel.org>; Wed, 13 Jul 2011 17:22:55 -0700 (PDT)
In-Reply-To: <1310565638-13140-1-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Wed, 13 Jul 2011 17:00:33 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com

Hi Tero,

Tero Kristo <t-kristo@ti.com> writes:

> Based on the comments for the previous version of this set, I implemented
> a regulator driver for the OMAP SMPS now. 

Could you rebase this on my pm-wip/voltdm branch where I've started the
work to separate out the VC/VP layers into their own files.

I've just rebased that branch on top of current l-o master, so it also
includes all the PRCM core code changes queued for v3.1.

Thanks,

Kevin
