From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 07/12] OMAP: Serial: Allow UART parameters to be
 configured from board file
Date: Wed, 4 May 2011 02:55:46 -0700
Message-ID: <20110504095546.GY2092@atomide.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-8-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54542 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752355Ab1EDJzu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 05:55:50 -0400
Content-Disposition: inline
In-Reply-To: <1304080796-625-8-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Deepak K <deepak.k@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Jon Hunter <jon-hunter@ti.com>

* Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
> @@ -250,7 +251,7 @@ static void __init omap_2430sdp_init(void)
>  	omap2430_i2c_init();
>  
>  	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
> -	omap_serial_init();
> +	omap_serial_init(NULL);
>  	omap2_hsmmc_init(mmc);
>  	omap2_usbfs_init(&sdp2430_usb_config);
...
  
>  static inline void board_serial_init(void)
>  {
> -	omap_serial_init();
> +	omap_serial_init(NULL);
>  }

This change seems like "crazy churn" and probably not needed
if it's always null. Boards using platform_data can use
omap_serial_init_port instead, right?  

Tony
