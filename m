From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP4: Keypad: Make keypad_data initdata
Date: Tue, 12 Jul 2011 08:00:19 -0700
Message-ID: <871uxvv918.fsf@ti.com>
References: <1310460153-10512-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:44747 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751118Ab1GLPA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jul 2011 11:00:26 -0400
Received: by mail-iw0-f169.google.com with SMTP id 8so5505797iwn.0
        for <linux-omap@vger.kernel.org>; Tue, 12 Jul 2011 08:00:23 -0700 (PDT)
In-Reply-To: <1310460153-10512-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Tue, 12 Jul 2011 14:12:33 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> The keypad data is accessed only at init so making it initdata.
> This removes the section mismatch warning.
>
> Reported-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Please Cc: linux-arm-kernel on upstream patches.

Also, as this is specific to a particular board, it is common to note
that in the subject prefix, e.g:

OMAP4: 4430SDP: keypad: ...

Thanks,

Kevin
