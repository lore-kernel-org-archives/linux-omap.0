From: Orjan Friberg <of@flatfrog.com>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Thu, 26 Jan 2012 10:26:20 +0100
Message-ID: <4F211C3C.3090004@flatfrog.com>
References: <4F206213.9070704@flatfrog.com> <4F206DCE.3060609@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:59603
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751048Ab2AZJ0X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jan 2012 04:26:23 -0500
In-Reply-To: <4F206DCE.3060609@flatfrog.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 01/25/2012 10:02 PM, Orjan Friberg wrote:
> That one-liner was boiled down from the following program, which still
> oopses instantly:

The C program seems to work fine with CONFIG_PREEMPT_NONE=y.

If that is indeed the problem I guess it's reasonable that it worked
better with PREEMPT_VOLUNTARY than PREEMPT because there are fewer
preemtion points.

-- 
Orjan Friberg
FlatFrog Laboratories AB
