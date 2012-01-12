From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 25/26] OMAP: PM: convert the SmartReflex code into the AVS driver framework
Date: Wed, 11 Jan 2012 16:55:59 -0800
Message-ID: <877h0xviw0.fsf@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
	<1321974370-25800-26-git-send-email-j-pihet@ti.com>
	<20111123233437.GA17638@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:47458 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751734Ab2ALA4F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jan 2012 19:56:05 -0500
Received: by ghbg15 with SMTP id g15so29333ghb.18
        for <linux-omap@vger.kernel.org>; Wed, 11 Jan 2012 16:56:03 -0800 (PST)
In-Reply-To: <20111123233437.GA17638@google.com> (Todd Poynor's message of
	"Wed, 23 Nov 2011 15:34:37 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: jean.pihet@newoldbits.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, balbi@ti.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>, nm@ti.com

Todd Poynor <toddpoynor@google.com> writes:

>> +static irqreturn_t _interrupt(int irq, void *data)
>> +{
>> +	struct smartreflex *sr = (struct smartreflex *)data;
>> +	u32 status = 0;
>> +
>> +	/* Read the status bits */
>> +	sr_read_reg(sr, IRQSTATUS);
>> +
>> +	/* Clear them by writing back */
>> +	sr_write_reg(sr, IRQSTATUS, status);
>
> Felipe Balbi sent a patch to the list fixing the write of zero,
> failing to clear the interrupts, to the list recently.

Right, this patch is in mainline now[1], so rebasing this series should
pick up this change.

Kevin

[1] 
commit 5a4f1844c2ba21f804d7729306d9b16eaeb724a8
Author: Felipe Balbi <balbi@ti.com>
Date:   Wed Nov 23 14:43:37 2011 -0800

    ARM: OMAP: smartreflex: fix IRQ handling bug
    
    Fix a bug which has been on this driver since
    it was added by the original commit 984aa6db
    which would never clear IRQSTATUS bits.
    
    Signed-off-by: Felipe Balbi <balbi@ti.com>
    Signed-off-by: Kevin Hilman <khilman@ti.com>
    Cc: stable@vger.kernel.org
    Signed-off-by: Tony Lindgren <tony@atomide.com>
