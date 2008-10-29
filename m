From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 0/21 Continue phasing out legacy GPIO calls
Date: Wed, 29 Oct 2008 16:49:08 -0700
Message-ID: <200810291649.09137.david-b@pacbell.net>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com> <20081029160056.GD20456@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:45834 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752081AbYJ2XtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 19:49:12 -0400
In-Reply-To: <20081029160056.GD20456@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

On Wednesday 29 October 2008, Tony Lindgren wrote:
> Let's do the clean-up patches in two phases, one series that
> applies against the mainline kernel, then additional patches for
> linux-omap. Otherwise we'll never get out of this merge hell.

I'll refresh my patches that way then.  Most of the stuff
remaining sits inside arch/arm anyway.


> BTW, we should try to do the same for anything that we can already
> patch in the mainline kernel.

Right.  We'll count on you to help us do that right.  Part
of the problem will be coping with the ARM tree merge rules,
especially for changes that touch mainline drivers too...

- Dave
 


