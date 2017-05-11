From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Thu, 11 May 2017 13:27:27 -0700
Message-ID: <20170511202726.GZ3489@atomide.com>
References: <20170327171534.GA4403@uda0271908>
 <20170327175536.GP10760@atomide.com>
 <20170511185038.GE7154@uda0271908>
 <20170511185528.GW3489@atomide.com>
 <20170511190100.GF7154@uda0271908>
 <20170511191005.GG7154@uda0271908>
 <20170511192013.GA4459@uda0271908>
 <20170511193810.GX3489@atomide.com>
 <20170511200220.GH7154@uda0271908>
 <20170511202306.GY3489@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170511202306.GY3489@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, Moreno Bartalucci <moreno.bartalucci@tecnorama.it>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170511 13:26]:
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -270,6 +270,10 @@ static int dsps_check_status(struct musb *musb, void *unused)
>  		musb_writel(musb->ctrl_base, wrp->coreintr_set,
>  			    MUSB_INTR_VBUSERROR << wrp->usb_shift);
>  		break;
> +	case OTG_STATE_A_HOST:
> +		if (glue->vbus_irq)
> +			dsps_mod_timer(glue, 20000);	/* 20s */
> +		break;
>  	default:
>  		break;
>  	}
> -- 

Heh that's the wrong way around.. I think we can leave out the check
for vbus_irq.

8< ---------------
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -270,6 +270,10 @@ static int dsps_check_status(struct musb *musb, void *unused)
 		musb_writel(musb->ctrl_base, wrp->coreintr_set,
 			    MUSB_INTR_VBUSERROR << wrp->usb_shift);
 		break;
+	case OTG_STATE_A_HOST:
+		/* Keep VBUS on after disconnect for 20 seconds */
+		dsps_mod_timer(glue, 20000);
+		break;
 	default:
 		break;
 	}
-- 
2.13.0
