From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] serial: omap: fix the reciever line error case
Date: Fri, 21 Sep 2012 14:46:18 -0700
Message-ID: <87r4pvdp79.fsf@deeprootsystems.com>
References: <1348238239-18510-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40972 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab2IUVqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 17:46:20 -0400
Received: by pbbrr4 with SMTP id rr4so3478018pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 14:46:19 -0700 (PDT)
In-Reply-To: <1348238239-18510-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Fri, 21 Sep 2012 20:07:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> This patch does the following
> - In case of errors if there least one data character in the RX FIFO
> read it otherwise it may stall the receiver.
>
> This is recommended in the interrupt reset method in the table 23-246 of
> the omap4 TRM.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> - Tested on omap4sdp.
> - pm tested hitting off in idle and suspend.
> - v2 changes update the changelogs.
> - Also remove the dummy check as FE , PE , BI and OE are the only
> receiver errors.

Tested-by: Kevin Hilman <khilman@ti.com>

This one also makes the regression I was seeing on 3530/Overo disappear.

Thanks,

Kevin
