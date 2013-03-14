From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: smp: Allow real broadcast device selection instead
 of always dummy
Date: Thu, 14 Mar 2013 11:39:25 +0530
Message-ID: <51416995.80408@ti.com>
References: <1363165608-13739-1-git-send-email-santosh.shilimkar@ti.com> <514046B6.9020005@ti.com> <alpine.LFD.2.02.1303131516090.22263@ionos> <51409D1D.9000500@ti.com> <alpine.LFD.2.02.1303131931100.22263@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39854 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753950Ab3CNGIE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 02:08:04 -0400
In-Reply-To: <alpine.LFD.2.02.1303131931100.22263@ionos>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>

On Thursday 14 March 2013 12:01 AM, Thomas Gleixner wrote:
> On Wed, 13 Mar 2013, Santosh Shilimkar wrote:
>> On Wednesday 13 March 2013 07:49 PM, Thomas Gleixner wrote:
>>> Though making the rating of the dummy lower is definitely a good
>>> thing, so a real hardware device which is detected later can replace
>>> the dummy device. So yes, the rating should be low for the dummy
>>> timer.
>>>
>> Exactly. As Mark pointed out, you have already applied Mark's patch.
>> I was just wondering whether you can take the $subject patch as well
>> with ack from Russell, Mark.
> 
> It can go through the ARM tree as well, no dependencies on my stuff.
> 
Sure. I will push that through ARM tree.

Regards,
Santosh

