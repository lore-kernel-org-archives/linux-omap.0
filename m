From: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 09/25] i2c/i2c-omap: add a const qualifier
Date: Mon, 23 Jul 2012 22:57:48 +0530
Message-ID: <CANQgH-Yx_iA0ANSLGjzgttBAfDFTJFQqYdo2PpJvtGN8=rdTrQ@mail.gmail.com>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1343034810-3386-10-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343034810-3386-10-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 23, 2012 at 2:43 PM, Uwe Kleine-K=F6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
>
>         drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_probe':
>         drivers/i2c/busses/i2c-omap.c:1025: warning: assignment disca=
rds qualifiers from pointer target type
>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Reviewed-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
