From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Overo defconfig for omap-2.6.30
Date: Wed, 15 Jul 2009 10:25:45 -0700
Message-ID: <874otd97ty.fsf@deeprootsystems.com>
References: <F2B67B67-3E11-4CEF-8FB4-49EE9C05F2B9@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:57423 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350AbZGORZt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 13:25:49 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1285404wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 15 Jul 2009 10:25:47 -0700 (PDT)
In-Reply-To: <F2B67B67-3E11-4CEF-8FB4-49EE9C05F2B9@mac.com> (Elvis Dowson's message of "Wed\, 15 Jul 2009 21\:07\:27 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Elvis Dowson <elvis.dowson@mac.com> writes:

> 			Could you give me a copy of a defconfig file
> that you have for the  Overo, for omap-2.6.30 and the one that you are
> using currently for  your current development efforts on the pm
> branch?

I use omap3_pm_defconfig for all boards.

The default in that config is for UART1 console which works for SDP
and omap3evm.  For all others (beagle, rx51, zoom2, Overo) I simply
change the low-level debug UART to UART3.

This allows me to test the same defconfig on all boards.

Kevin
