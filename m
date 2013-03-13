From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] ARM: smp: Allow real broadcast device selection instead
 of always dummy
Date: Wed, 13 Mar 2013 19:31:50 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303131931100.22263@ionos>
References: <1363165608-13739-1-git-send-email-santosh.shilimkar@ti.com> <514046B6.9020005@ti.com> <alpine.LFD.2.02.1303131516090.22263@ionos> <51409D1D.9000500@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47942 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab3CMSb4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 14:31:56 -0400
In-Reply-To: <51409D1D.9000500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>

On Wed, 13 Mar 2013, Santosh Shilimkar wrote:
> On Wednesday 13 March 2013 07:49 PM, Thomas Gleixner wrote:
> > Though making the rating of the dummy lower is definitely a good
> > thing, so a real hardware device which is detected later can replace
> > the dummy device. So yes, the rating should be low for the dummy
> > timer.
> > 
> Exactly. As Mark pointed out, you have already applied Mark's patch.
> I was just wondering whether you can take the $subject patch as well
> with ack from Russell, Mark.

It can go through the ARM tree as well, no dependencies on my stuff.

Thanks,

	tglx
