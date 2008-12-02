From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Make sure omap cpufreq driver initializes after cpufreq framework and governors
Date: Tue, 2 Dec 2008 11:26:40 -0800
Message-ID: <200812021126.40890.david-b@pacbell.net>
References: <1228231877-18114-1-git-send-email-peter.de-schrijver@nokia.com> <1228231877-18114-2-git-send-email-peter.de-schrijver@nokia.com> <1228231877-18114-3-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:26696 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750748AbYLBT0n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 14:26:43 -0500
In-Reply-To: <1228231877-18114-3-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 02 December 2008, Peter 'p2' De Schrijver wrote:
> -arch_initcall(omap_cpufreq_init);
> +late_initcall(omap_cpufreq_init);

So this might explain why I've been unable to run
my OSK (5912) with cpufreq for a while now ...
