From: David Brown <davidb@codeaurora.org>
Subject: Re: ARM defconfig files
Date: Mon, 12 Jul 2010 16:34:04 -0700
Message-ID: <201007121634.04427.davidb@codeaurora.org>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org> <201007121605.32462.davidb@codeaurora.org> <AANLkTimho3rcoCZZ2PlC3B3KIZZhsEiTnTk-__n1q_Dy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimho3rcoCZZ2PlC3B3KIZZhsEiTnTk-__n1q_Dy@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Walker <dwalker@codeaurora.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Eric Miao <eric.miao@canonical.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

On Monday 12 July 2010 16:18:01 Linus Torvalds wrote:

> 2010/7/12 David Brown <davidb@codeaurora.org>:
> >
> > Do you have scripts or tools that you did this with, or is a manual
> > process.  We're about to add several new (ARM) targets, and it'd be
> > nice to be able to make small defconfigs for those targets as well.
> 
> Uwe posted it earlier in this thread as an attachement, and I put the
> python script into the merge commit message too. And we should
> probably put it somewhere in scripts too, and/or make a 'make' target
> to create the small config files.
> 
> I pushed it all out, and tagged it as -rc5.

Got it, thanks.  I just pulled a bit soon.

It seems a bit brute force, probably not something I can make part of
our regular build process, but I can definitely run it before sending
patches out.

I wonder if there's a more efficient way of doing it that doesn't
involve invoking make for each line of the file.  It at least
shouldn't be necessary to actually build the kernel each time.

David
