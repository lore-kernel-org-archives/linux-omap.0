From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH V2] OMAP: GPIO: Fix OMAP4 GPIO reg access issues
Date: Wed, 05 May 2010 14:41:48 -0700
Message-ID: <87wrvi2fhf.fsf@deeprootsystems.com>
References: <1270724268-27622-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56596 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758666Ab0EEVl5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 17:41:57 -0400
Received: by pva18 with SMTP id 18so734963pva.19
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 14:41:56 -0700 (PDT)
In-Reply-To: <1270724268-27622-1-git-send-email-charu@ti.com> (Charulatha V.'s message of "Thu\,  8 Apr 2010 16\:27\:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org

Charulatha V <charu@ti.com> writes:

> Access to some of the OMAP4 GPIO registers are not properly handled.
> This patch fixes it.
>
> This patch is tested on 3430SDP and 4430SDP boards
>
> Signed-off-by: Charulatha V <charu@ti.com>
> cc: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

All this #ifdeffery will be gone with the in-progress hwmod
conversion, but this fix should go in in the meantime.

Kevin
