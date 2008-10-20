From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH] i2c: omap: highspeed only over 1000mhz
Date: Mon, 20 Oct 2008 07:42:17 -0500
Message-ID: <48FC7CA9.4040102@gmail.com>
References: <1224277795-17143-1-git-send-email-felipe.balbi@nokia.com> <20081020102659.GA31599@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:6520 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbYJTMmj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Oct 2008 08:42:39 -0400
Received: by yx-out-2324.google.com with SMTP id 8so279022yxm.1
        for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 05:42:38 -0700 (PDT)
In-Reply-To: <20081020102659.GA31599@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Tony Lindgren <tony@atomide.com>

Felipe,
Felipe Balbi said the following on 10/20/2008 05:26 AM:
> up to 1000khz it's Fast Mode+, not highspeed.
>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index a999606..53d6244 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -296,7 +296,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  		psc = psc - 1;
>  
>  		/* If configured for High Speed */
> -		if (dev->speed > 400) {
> +		if (dev->speed > 1000) {
>   
Ref: http://www.nxp.com/acrobat_download/literature/9398/39340011.pdf
Page 4:
"Serial, 8-bit oriented, bi-directional data transfers can be
made at *up to* 100 kbit/s in the Standard-mode, *up to*
400 kbit/s in the Fast-mode, or *up to* 3.4 Mbit/s in the
High-speed mode"

Why do say high speed is >1000khz?

Thanks and Regards,
Nishanth Menon
