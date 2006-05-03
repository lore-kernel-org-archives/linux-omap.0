From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix tlv320aic23.c
Date: Wed, 3 May 2006 05:56:07 -0700
Message-ID: <20060503125606.GG30376@atomide.com>
References: <4452384E.7080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4452384E.7080409@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [060428 08:45]:
> 
> ARM: OMAP: Fix error from GCC 4.1.0:
> 
> drivers/i2c/chips/tlv320aic23.c:157: error: expected '='
> before '{' token
> drivers/i2c/chips/tlv320aic23.c:161: error: expected '}'
> before '.' token
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 
> -- cut, comment not to go into git below --
> 
> Seems that the first part of
> 
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=51c0cddf5027bd4e5c1903845047d7d7e266c79b
> 
> was lost somewhere??

> --- ./drivers/i2c/chips/tlv320aic23.c_orig	2006-04-28 17:29:49.000000000 +0200
> +++ ./drivers/i2c/chips/tlv320aic23.c	2006-04-28 17:30:55.000000000 +0200
> @@ -154,7 +154,7 @@ static int aic23_attach_adapter(struct i
>  }
>  
>  static struct i2c_driver aic23_driver = {
> -	.driver {
> +	.driver = {
>  		.name	= "OMAP+TLV320AIC23 codec",
>  		/*.flags	= I2C_DF_NOTIFY,*/
>  	},
> 

Thanks, pushed your patch.

I think the earlier patch chunk has gotten auto-hosed by git merge in
Juha's recent merge:

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=330c1eb9a689973326cdece277d0b4b409833bb9

Mika & Dirk, can you guys check if some of the other audio files got
hosed or some old audio files got added back?

Regards,

Tony
