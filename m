From: Tony Lindgren <tony@atomide.com>
Subject: Re: What is the purpose of function omap_get_config()
Date: Wed, 5 Nov 2008 08:17:48 -0800
Message-ID: <20081105161748.GQ28924@atomide.com>
References: <4bd972300811050430t151f582aq33a687e428a8355f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50419 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbYKEQRx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 11:17:53 -0500
Content-Disposition: inline
In-Reply-To: <4bd972300811050430t151f582aq33a687e428a8355f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?56ug5p2w?= <zhj8407@gmail.com>
Cc: linux-omap@vger.kernel.org

* =E7=AB=A0=E6=9D=B0 <zhj8407@gmail.com> [081105 04:31]:
> Hello,
>=20
>    I am porting a lcd panel to OMAP2430. It didn't enter the probe
> entry of the omapfb. I found that it did not register the device in
> fb.c located in arch/arm/plat-omap. Because the function
>  omap_get_config( OMAP_TAG_LCD, struct omap_lcd_config )
>  which is invoked before platform_device_register returns NULL.
>=20
> So I wonder the purpose of omap_get_config and where it gets the
> configuration. Can anybody tell me in detail? Thanks very much!

The omap specific ATAGs will be going away soon, so please rely only
on the configuration in your board-*.c file.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
