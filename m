From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv8 09/10] I2C: OMAP: Do not set the XUDF if the underflow
 is not reached
Date: Mon, 23 Apr 2012 22:59:22 +0530
Message-ID: <4F959172.7080302@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com> <1334842101-20670-10-git-send-email-shubhrajyoti@ti.com> <20120423164212.GC27321@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:35324 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752209Ab2DWR33 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 13:29:29 -0400
Received: by dadz8 with SMTP id z8so15845595dad.10
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 10:29:28 -0700 (PDT)
In-Reply-To: <20120423164212.GC27321@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, Alexander Shishkin <virtuoso@slind.org>

On Monday 23 April 2012 10:12 PM, Wolfram Sang wrote:
> On Thu, Apr 19, 2012 at 06:58:20PM +0530, Shubhrajyoti D wrote:
>> Currently in the 1.153 errata handling while waiting for transmitter
>> underflow if NACK is got the XUDF flag is also set.
>> The flag is set after wait for the condition is over.
> What does XUDF mean? Please update the commit description, I can't know
> all terminology for all architectures.
>
Transmitter underflow ,will update the commit description and resend.

