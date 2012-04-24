From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/19] ARM: OMAP4: Auto generate SAR layout contents
Date: Tue, 24 Apr 2012 09:37:34 -0700
Message-ID: <20120424163734.GM3739@atomide.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47150 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481Ab2DXQhh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 12:37:37 -0400
Content-Disposition: inline
In-Reply-To: <1334914432-26456-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [120420 02:38]:
> -void omap4_sar_overwrite(void)
> +void omap_sar_overwrite(void)
>  {
>  	u32 val = 0;
> -	u32 offset = 0;
> +	u32 usb_offset = 0x2ec;
> +	u32 usb_offset2 = 0x91c;
>  
> -	if (cpu_is_omap446x())
> -		offset = 0x04;
> +	if (cpu_is_omap446x()) {
> +		usb_offset = 0x2f4;
> +		usb_offset2 = 0x920;
> +	}

Here too you should initialized these during __init. Otherwise
we'll end up piling more and more if else cpu_is_omapxxxx for
future omaps that again might change the offsets.

Tony
