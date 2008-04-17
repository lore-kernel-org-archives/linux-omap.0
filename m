From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Add usb support to omap3beagle
Date: Thu, 17 Apr 2008 11:26:54 -0700
Message-ID: <200804171126.54874.david-b@pacbell.net>
References: <CE83D2E2-7DC8-471C-AD14-14A6FED413A9@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:36177 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751066AbYDQSlD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Apr 2008 14:41:03 -0400
In-Reply-To: <CE83D2E2-7DC8-471C-AD14-14A6FED413A9@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>, khasim@ti.com
Cc: linux-omap@vger.kernel.org

On Thursday 17 April 2008, Koen Kooi wrote:
> 
> @@ -69,6 +70,7 @@
>  	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
>  	omap_serial_init();
>  	sdp_mmc_init();
> +	sdp3430_usb_init();
>  }
>
>  arch_initcall(omap3_beagle_i2c_init);

I hope someone makes those sdp_*() routines generic ... or does
"SDP" not stand for "Software Development Platform" (different board)?
