From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v2] [I2C-OMAP] Add support for 16-bit registers
Date: Fri, 19 Mar 2010 11:05:09 +0200
Message-ID: <20100319110509.76784df2.jhnikula@gmail.com>
References: <1260669242-29865-1-git-send-email-darkstar6262@gmail.com>
	<6cb013311001090947m2268833cv3784f469dc8b861d@mail.gmail.com>
	<20100109183321.GH2879@atomide.com>
	<6cb013311001091035x54321b3aqb814f476200980af@mail.gmail.com>
	<20100112012814.GK5055@atomide.com>
	<87k4tkf3ye.fsf@deeprootsystems.com>
	<20100310223000.GT2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:53052 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab0CSJDW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 05:03:22 -0400
In-Reply-To: <20100310223000.GT2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Ben Dooks <ben-linux@fluff.org>, Cory Maccarrone <darkstar6262@gmail.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

On Wed, 10 Mar 2010 14:30:00 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Kevin Hilman <khilman@deeprootsystems.com> [100310 10:01]:
> > Tony Lindgren <tony@atomide.com> writes:
> > 
...
> > Unfortunately, Tony's additional fix did not make it into the version
> > that was merged to mainline, which results in a crash during
> > probe when using v2.6.34-rc1.
> > 
> > Ben, can you queue the fix below from Tony for -rc2?
> 
> The original patch attached again below.
> 
FWIW,

Tony's "[PATCH] i2c-omap: Fix reg_shift init" makes the mainline
2.6.34-rc1 booting on OMAP3.

Tested-by: Jarkko Nikula <jhnikula@gmail.com>
