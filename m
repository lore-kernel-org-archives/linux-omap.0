From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/4] RX51: SDRAM settings changes
Date: Mon, 26 Oct 2009 11:50:00 -0700
Message-ID: <871vkqc7mv.fsf@deeprootsystems.com>
References: <1256573726-29800-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.221.174]:58630 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbZJZSt7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 14:49:59 -0400
Received: by qyk4 with SMTP id 4so7844513qyk.33
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 11:50:03 -0700 (PDT)
In-Reply-To: <1256573726-29800-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Mon\, 26 Oct 2009 18\:15\:22 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Following patch set fixes a few issues with current RX51 board SDRAM settings.
> Applies on top of PM branch.
>

Tero,

Can you resend this series against the master branch?  There is no reason
this should be carried in the PM branch anymore.

You'll have to add to your series the patch to add the
board-rx51-sdram.c file, which I currently carry in the PM branch.

Then, for the PM branch, we just need a small patch to add the various
rate tables in the call to init_common_hw until DVFS stuff is
upstream.

Kevin
