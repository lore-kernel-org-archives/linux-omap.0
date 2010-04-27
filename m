From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 15/22] OMAP3: PM: Support for enabling smartreflex autocompensation by default.
Date: Tue, 27 Apr 2010 12:10:19 -0700
Message-ID: <87aasoiuec.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
	<1271408597-3066-5-git-send-email-thara@ti.com>
	<1271408597-3066-6-git-send-email-thara@ti.com>
	<1271408597-3066-7-git-send-email-thara@ti.com>
	<1271408597-3066-8-git-send-email-thara@ti.com>
	<1271408597-3066-9-git-send-email-thara@ti.com>
	<1271408597-3066-10-git-send-email-thara@ti.com>
	<1271408597-3066-11-git-send-email-thara@ti.com>
	<1271408597-3066-12-git-send-email-thara@ti.com>
	<1271408597-3066-13-git-send-email-thara@ti.com>
	<1271408597-3066-14-git-send-email-thara@ti.com>
	<1271408597-3066-15-git-send-email-thara@ti.com>
	<1271408597-3066-16-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:54756 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab0D0TKX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 15:10:23 -0400
Received: by pzk42 with SMTP id 42so9200214pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 12:10:22 -0700 (PDT)
In-Reply-To: <1271408597-3066-16-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:33\:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds support to pdata enable smartreflex autocompenstion
> during init based on enable_on_init flag passed as pdata.

-ENOPARSE.  Removing the first 'pdata' makes it understandable, I think.

> This patch also adds enabling of autocompensation by
> default (setting enable_on_init  flag to true) in case of ES3.1
> OMAP3430 chip. In the current implementation
> this step is kept in smartreflex.c itself.Later an API can be added
> so that the decision to enable autocompensation by default
> can be passed from the corresponding board files.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

otherwise, ok.

Kevin
