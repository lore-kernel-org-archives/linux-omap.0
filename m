From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHV2] OMAP4: OPP: add OMAP4460 definitions
Date: Tue, 19 Jul 2011 08:16:52 -0700
Message-ID: <87wrfejo63.fsf@ti.com>
References: <1309758042-17208-1-git-send-email-vishwanath.bs@ti.com>
	<f1dff603251827d0e02bc74ebc871388@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:55600 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751354Ab1GSPQ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jul 2011 11:16:56 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so5264617iyb.33
        for <linux-omap@vger.kernel.org>; Tue, 19 Jul 2011 08:16:55 -0700 (PDT)
In-Reply-To: <f1dff603251827d0e02bc74ebc871388@mail.gmail.com> (Vishwanath
	Sripathy's message of "Tue, 19 Jul 2011 18:55:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Nishanth Menon <nm@ti.com>

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

> I see that this patch is not queued for 3.1 merge window. Any
> issues/comments on this patch?

I did not look at this patch as it came late in the development cycle.

A quick glance now suggests it has a few minor problems.

- patch was not Cc's to linux-arm-kernel
- uses 44XX naming which is not used in l-o master

Please update against current l-o tree which has the PRCM/hwmod updates
from Paul/Benoit as well as the base 4460 support for v3.1.

Kevin
