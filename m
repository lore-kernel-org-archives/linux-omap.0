From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: RFC, GIC based smp_cross_call cleanup suggestion
Date: Mon, 4 Apr 2011 09:25:18 +0100
Message-ID: <20110404082518.GA19178@n2100.arm.linux.org.uk>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local> <BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com> <20110402085133.GE8482@n2100.arm.linux.org.uk> <BANLkTim+bco_90iPLrc1ioV4bdSw+LRzQQ@mail.gmail.com> <BANLkTimjyBzh3Kc+1njcBBYCouKdSWhgng@mail.gmail.com> <20110403103730.GB4213@n2100.arm.linux.org.uk> <4D9851B5.20100@ti.com> <20110403134837.GE4213@n2100.arm.linux.org.uk> <4D997F53.5010409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41359 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab1DDIZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 04:25:57 -0400
Content-Disposition: inline
In-Reply-To: <4D997F53.5010409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Colin Cross <ccross@google.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, John Linn <John.Linn@xilinx.com>, linux-arm-kernel@lists.infradead.org, l-o <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Mon, Apr 04, 2011 at 01:50:35PM +0530, Santosh Shilimkar wrote:
> On 4/3/2011 7:18 PM, Russell King - ARM Linux wrote:
>> On Sun, Apr 03, 2011 at 04:23:41PM +0530, Santosh Shilimkar wrote:
>>> If you plan to commit this change then I can move these to
>>> other OMAP4 header file.
>>
>> Can you send me a patch to do that please?
>>
> Here it is.. Generated against latest mainline.
> Also attached just in case for any mailer issues.

Looks good, please send to the patch system.
