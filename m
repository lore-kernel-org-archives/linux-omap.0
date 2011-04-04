From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: RFC, GIC based smp_cross_call cleanup suggestion
Date: Mon, 04 Apr 2011 14:03:33 +0530
Message-ID: <4D99825D.2020604@ti.com>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local> <BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com> <20110402085133.GE8482@n2100.arm.linux.org.uk> <BANLkTim+bco_90iPLrc1ioV4bdSw+LRzQQ@mail.gmail.com> <BANLkTimjyBzh3Kc+1njcBBYCouKdSWhgng@mail.gmail.com> <20110403103730.GB4213@n2100.arm.linux.org.uk> <4D9851B5.20100@ti.com> <20110403134837.GE4213@n2100.arm.linux.org.uk> <4D997F53.5010409@ti.com> <20110404082518.GA19178@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53165 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754009Ab1DDIdv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 04:33:51 -0400
Received: by gxk8 with SMTP id 8so2424190gxk.23
        for <linux-omap@vger.kernel.org>; Mon, 04 Apr 2011 01:33:50 -0700 (PDT)
In-Reply-To: <20110404082518.GA19178@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>, Colin Cross <ccross@google.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, John Linn <John.Linn@xilinx.com>, linux-arm-kernel@lists.infradead.org, l-o <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On 4/4/2011 1:55 PM, Russell King - ARM Linux wrote:
> On Mon, Apr 04, 2011 at 01:50:35PM +0530, Santosh Shilimkar wrote:
>> On 4/3/2011 7:18 PM, Russell King - ARM Linux wrote:
>>> On Sun, Apr 03, 2011 at 04:23:41PM +0530, Santosh Shilimkar wrote:
>>>> If you plan to commit this change then I can move these to
>>>> other OMAP4 header file.
>>>
>>> Can you send me a patch to do that please?
>>>
>> Here it is.. Generated against latest mainline.
>> Also attached just in case for any mailer issues.
>
> Looks good, please send to the patch system.
patch 6860/1

Regards
Santosh
