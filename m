From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/1] Save sram context after changing MPU, DSP or core clocks
Date: Wed, 26 Nov 2008 10:51:11 -0800
Message-ID: <87ljv6jp7k.fsf@deeprootsystems.com>
References: <1227095127-7158-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:23800 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbYKZSvT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 13:51:19 -0500
Received: by ey-out-2122.google.com with SMTP id 6so267861eyi.37
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 10:51:17 -0800 (PST)
In-Reply-To: <1227095127-7158-1-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Wed\, 19 Nov 2008 13\:45\:26 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> This patch saves the sram context again after a MPU,DSP or core clock
> frequency change. This is necessary so the rom code can restore the correct
> DPLL settings when resuming from off mode. Thanks to Rajendra Nayak for
> suggesting the problem and coming up with the same fix at about the same time.
>

Thanks, pulling into next PM branch.

Kevin
