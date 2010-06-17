From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/12] OMAP2/3: hwmod: remove '_hwmod' suffix from names
Date: Thu, 17 Jun 2010 07:23:57 -0700
Message-ID: <87iq5hspoi.fsf@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
	<1276733833-18510-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42362 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab0FQOYA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 10:24:00 -0400
Received: by pwi1 with SMTP id 1so4295969pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 07:23:59 -0700 (PDT)
In-Reply-To: <1276733833-18510-2-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 16 Jun 2010 17\:17\:02 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

Kevin Hilman <khilman@deeprootsystems.com> writes:

> As per new naming convention for hwmods, remove the redundant _hwmod suffix
> from all hwmod names.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

This duplicates a patch already done by Benoit[1], but mine
incorrectly renames l3.  I'll drop mine in favor of Benoit's version.

Kevin

[1] https://patchwork.kernel.org/patch/101953/

