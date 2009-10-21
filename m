From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [Resend PATCH 1/2] twl4030: Do not dereference null pointer in
 error path
Date: Thu, 22 Oct 2009 00:22:11 +0200
Message-ID: <20091021222210.GC17796@sortiz.org>
References: <1256044973-14548-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:14516 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754762AbZJUWUN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 18:20:13 -0400
Content-Disposition: inline
In-Reply-To: <1256044973-14548-1-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi Ilkka,

On Tue, Oct 20, 2009 at 04:22:52PM +0300, Ilkka Koskinen wrote:
> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Patch applied to my for-linus and for-next branches.
I'll try to get that one merged for 2.6.32.

Cheers,
Samuel.


> ---
>  drivers/mfd/twl4030-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
> index e424cf6..8cf0a02 100644
> --- a/drivers/mfd/twl4030-core.c
> +++ b/drivers/mfd/twl4030-core.c
> @@ -792,7 +792,7 @@ twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  			twl->client = i2c_new_dummy(client->adapter,
>  					twl->address);
>  			if (!twl->client) {
> -				dev_err(&twl->client->dev,
> +				dev_err(&client->dev,
>  					"can't attach client %d\n", i);
>  				status = -ENOMEM;
>  				goto fail;
> -- 
> 1.6.0.4
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
