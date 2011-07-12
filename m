From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP4: 4430SDP: Keypad: Make keypad_data initdata
Date: Tue, 12 Jul 2011 15:32:01 -0700
Message-ID: <871uxvt9jy.fsf@ti.com>
References: <1310488329-16139-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:35367 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756082Ab1GLWcG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jul 2011 18:32:06 -0400
Received: by mail-iw0-f178.google.com with SMTP id 10so5232517iwc.9
        for <linux-omap@vger.kernel.org>; Tue, 12 Jul 2011 15:32:05 -0700 (PDT)
In-Reply-To: <1310488329-16139-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Tue, 12 Jul 2011 22:02:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> The keypad data is accessed only at init so making it initdata.
> This removes the section mismatch warning.
>
> Reported-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Tony, if it's not too late, this should probably queue for v3.1 so that
it goes in at the same time as the patch that introduces this compile
warning.

Kevin
