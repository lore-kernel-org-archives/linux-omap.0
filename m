From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] twl4030: move twl4030-pwrbutton to drivers/input/misc
Date: Thu, 19 Feb 2009 12:08:45 -0800
Message-ID: <200902191208.45851.david-b@pacbell.net>
References: <1235050197-26818-1-git-send-email-me@felipebalbi.com> <1235050197-26818-2-git-send-email-me@felipebalbi.com> <1235050197-26818-3-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n5b.bullet.sp1.yahoo.com ([69.147.64.186]:39604 "HELO
	n5b.bullet.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751858AbZBSUKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 15:10:06 -0500
In-Reply-To: <1235050197-26818-3-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@openedhand.com>

On Thursday 19 February 2009, Felipe Balbi wrote:
> Take it out of drivers/i2c/chips as requested by Jean Delvare
> that all drivers move out of there.
> 
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Samuel Ortiz <sameo@openedhand.com>
> Signed-off-by: Felipe Balbi <me@felipebalbi.com>

You're cc'ing Sam on these patches to the OMAP tree ... are you
suggesting this code merge to mainline?

If so, you'll need to send the input driver to the input list
as a patch against mainline, for review.  The snippet from
your patch 1/2 affecting the twl4030 MFD core might reasonably
be merged with that, assuming Sam's OK with that going though
the input tree.

- Dave


> ---
>  drivers/i2c/chips/Kconfig                          |    4 ----
>  drivers/i2c/chips/Makefile                         |    1 -
>  drivers/input/misc/Kconfig                         |    4 ++++
>  drivers/input/misc/Makefile                        |    1 +
>  .../{i2c/chips => input/misc}/twl4030-pwrbutton.c  |    0
>  drivers/mfd/twl4030-core.c                         |    3 ++-
>  6 files changed, 7 insertions(+), 6 deletions(-)
>  rename drivers/{i2c/chips => input/misc}/twl4030-pwrbutton.c (100%)
> 

