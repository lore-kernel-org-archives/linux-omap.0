From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Fix OFF mode on HS/EMU Devices
Date: Tue, 21 Jul 2009 09:20:19 -0700
Message-ID: <874ot6ovng.fsf@deeprootsystems.com>
References: <1248190107-21703-1-git-send-email-ext-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:34854 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbZGUQUX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 12:20:23 -0400
Received: by wf-out-1314.google.com with SMTP id 26so955745wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 09:20:22 -0700 (PDT)
In-Reply-To: <1248190107-21703-1-git-send-email-ext-roger.quadros@nokia.com> (Roger Quadros's message of "Tue\, 21 Jul 2009 18\:28\:27 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: linux-omap@vger.kernel.org

Roger Quadros <ext-roger.quadros@nokia.com> writes:

> Defer calling omap3_save_scratchpad_contents() to after
> omap3_secure_ram_storage has been initialized. This fixes
> lockup & reboot while entering CORE OFF mode on HS/EMU devices.
>
> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>

Thanks, pushed to PM branch, and pm-2.6.29.

Kevin
