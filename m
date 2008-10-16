From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-omap-git+ 6/5] twl4030 MMC card detction
Date: Thu, 16 Oct 2008 15:33:28 -0700
Message-ID: <200810161533.28320.david-b@pacbell.net>
References: <200810131259.50460.david-b@pacbell.net> <200810141201.43612.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:33335 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755486AbYJPWda (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Oct 2008 18:33:30 -0400
In-Reply-To: <200810141201.43612.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Tuesday 14 October 2008, David Brownell wrote:
> Replace stubbed-out card-detect support for twl4030 GPIOs with
> a simpler platform_data mechanism.  As before, no current users.
> Sanity tested by enabling this on Beagle; it booted OK with
> root on MMC.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/gpio/twl4030-gpio.c |   52 +++++++++---------------------------------
>  include/linux/i2c/twl4030.h |    3 ++
>  2 files changed, 15 insertions(+), 40 deletions(-)

By the way, a minor comment:  I noticed that there are also
settings in the PM_RECEIVER "dc-to-dc_GLOBAL_CFG" register
to change the card detect signal from active high (which is
the default) to active low.

This patch doesn't support such signal polarity options,
but it'd seem likely to me that some boards will need them.
Someday later than today.  :)

This email is just to note this issue ... fixing it should
be trivial, there are several more bits available in that
byte which could be used to configure polarity.

- Dave
