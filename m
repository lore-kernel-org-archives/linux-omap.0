From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] I2C:Moving Register Defines to Header File
Date: Thu, 14 May 2009 13:40:34 -0700
Message-ID: <20090514204033.GR5593@atomide.com>
References: <52671.192.168.10.89.1242133785.squirrel@dbdmail.itg.ti.com> <87hbzqe55y.fsf@deeprootsystems.com> <57428.192.168.10.89.1242203177.squirrel@dbdmail.itg.ti.com> <87octx9lxn.fsf@deeprootsystems.com> <561678670905140334x3a5588f3i540ee692890e50e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63767 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbZENUki (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 16:40:38 -0400
Content-Disposition: inline
In-Reply-To: <561678670905140334x3a5588f3i540ee692890e50e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jagadeesh Bhaskar Pakaravoor <jagadeeshbp@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Syed Rafiuddin <rafiuddin.syed@ti.com>, linux-omap@vger.kernel.org, ben-linux@fluff.org, linux-i2c@vger.kernel.org

* Jagadeesh Bhaskar Pakaravoor <jagadeeshbp@gmail.com> [090514 03:34]:
> > IMO, The regs do not need to move to a separate header unless they will
> > be used outside of i2c-omap.c.
> >
> Would it not be cleaner to move them to a separate header file,
> especially considering the fact that we have some 19 registers for
> OMAP3 I2C and when we redefine them for OMAP4, there would be 38
> (infact 40, including the two new registers) lines of just register
> definitions at the top of the file?

I agree with Kevin, unless the defines are used in other files there
should not be need for having a separate header file.

Tony
