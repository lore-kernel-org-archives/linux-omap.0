From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] i2c-omap: Set latency requirements only once for several messages
Date: Tue, 16 Nov 2010 08:19:36 -0800
Message-ID: <87wrodi6lj.fsf@deeprootsystems.com>
References: <1289896100-28881-1-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46406 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441Ab0KPQTj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 11:19:39 -0500
Received: by ywg8 with SMTP id 8so428470ywg.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 08:19:39 -0800 (PST)
In-Reply-To: <1289896100-28881-1-git-send-email-samu.p.onkalo@nokia.com> (Samu
	Onkalo's message of "Tue, 16 Nov 2010 10:28:20 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Samu Onkalo <samu.p.onkalo@nokia.com> writes:

> Ordinary I2C read consist of two messages. First a write operation
> to tell register address and then read operation to get data.
> CPU wake up latency is set and removed twice in read case.
> Set latency requirement before the message processing loop
> and remove the requirement after the loop to remove latency
> adjustment operations between the messages.
>
> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Samu,

Can you collect the acks and repost to linux-i2c@vger.kernel.org 
and Cc Ben Dooks <ben-linux@fluff.org>.

This one should go upstream via Ben.

Thanks,

Kevin

> ---
>  drivers/i2c/busses/i2c-omap.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index b33c785..3e9323e 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -616,12 +616,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	 * REVISIT: We should abort the transfer on signals, but the bus goes
>  	 * into arbitration and we're currently unable to recover from it.
>  	 */
> -	if (dev->set_mpu_wkup_lat != NULL)
> -		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
>  	r = wait_for_completion_timeout(&dev->cmd_complete,
>  					OMAP_I2C_TIMEOUT);
> -	if (dev->set_mpu_wkup_lat != NULL)
> -		dev->set_mpu_wkup_lat(dev->dev, -1);
>  	dev->buf_len = 0;
>  	if (r < 0)
>  		return r;
> @@ -672,12 +668,18 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  	if (r < 0)
>  		goto out;
>  
> +	if (dev->set_mpu_wkup_lat != NULL)
> +		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
> +
>  	for (i = 0; i < num; i++) {
>  		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
>  		if (r != 0)
>  			break;
>  	}
>  
> +	if (dev->set_mpu_wkup_lat != NULL)
> +		dev->set_mpu_wkup_lat(dev->dev, -1);
> +
>  	if (r == 0)
>  		r = num;
