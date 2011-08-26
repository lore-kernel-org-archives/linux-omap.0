From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2] OMAP2: PM debug: remove leftover debug code
Date: Fri, 26 Aug 2011 16:15:15 -0700
Message-ID: <87fwknydbw.fsf@ti.com>
References: <87bow3uc4p.fsf@ti.com>
	<1312789580-10007-1-git-send-email-michael.jones@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:44260 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752728Ab1HZXPU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 19:15:20 -0400
Received: by mail-iy0-f173.google.com with SMTP id z25so67196iab.18
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 16:15:19 -0700 (PDT)
In-Reply-To: <1312789580-10007-1-git-send-email-michael.jones@matrix-vision.de>
	(Michael Jones's message of "Mon, 8 Aug 2011 09:46:20 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Michael Jones <michael.jones@matrix-vision.de> writes:

> commit 20d5d5514981f9a68832bffb27a698545ecba77a (OMAP2: PM debug:
> remove register dumping) left some code lying around which doesn't
> do anything. Clean it up.
>
> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>

Thanks, queueing for v3.2 (branch: for_3.2/pm-cleanup)

Kevin

P.S., apologies for the lag... been out on vacation.

