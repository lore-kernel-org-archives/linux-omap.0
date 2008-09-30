From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 16/23] Move I2C driver model init earlier in the boot sequence
Date: Tue, 30 Sep 2008 08:52:53 -0700
Message-ID: <200809300852.54232.david-b@pacbell.net>
References: <1222769160-31615-1-git-send-email-felipe.balbi@nokia.com> <1222769160-31615-16-git-send-email-felipe.balbi@nokia.com> <1222769160-31615-17-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:23060 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754509AbYI3PxB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2008 11:53:01 -0400
In-Reply-To: <1222769160-31615-17-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Tuesday 30 September 2008, Felipe Balbi wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> This avoids oopsing in statically linked systems when some
> subsystems register I2C drivers in subsys_initcall() code,
> but those subsystems are linked (and initialized) before I2C.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

And as of this morning:

Signed-off-by: Jean Delvare <khali@linux-fr.org>


> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/i2c-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index b346a68..f520108 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -978,7 +978,7 @@ static void __exit i2c_exit(void)
>  	bus_unregister(&i2c_bus_type);
>  }
>  
> -subsys_initcall(i2c_init);
> +postcore_initcall(i2c_init);
>  module_exit(i2c_exit);
>  
>  /* ----------------------------------------------------
> -- 
> 1.6.0.2.307.gc427
> 
> 


