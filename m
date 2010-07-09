From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [Regression] ads7846.c touchscreen controller driver reports
	wrong X,Y values
Date: Fri, 9 Jul 2010 15:17:09 -0700
Message-ID: <AANLkTilh7VrS1zZLSmuj-BFYvm34mkF_uwk9B7TpyYYz@mail.gmail.com>
References: <AANLkTinwrfeYybZysJ-hyZC4MCxjtAFSVos6ZOguZ9VE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64458 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab0GIWRL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 18:17:11 -0400
Received: by qyk38 with SMTP id 38so3350221qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 09 Jul 2010 15:17:10 -0700 (PDT)
In-Reply-To: <AANLkTinwrfeYybZysJ-hyZC4MCxjtAFSVos6ZOguZ9VE@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mickael Chazaux <mickael.chazaux@gmail.com>
Cc: linux-omap@vger.kernel.org, Roman Tereshonkov <roman.tereshonkov@nokia.com>

On Tue, May 25, 2010 at 8:54 AM, Mickael Chazaux
<mickael.chazaux@gmail.com> wrote:
> Hi,
>
> I am working on adding the support of an omap3 based board in the
> kernel. This board uses an ADS7843 touchscreen controller, on the SPI
> bus. The in-kernel driver (drivers/input/touchscreen/ads7646.c) works
> fine with the 2.6.33 kernel. When updating to the 2.6.34 kernel the
> values reported by the driver were garbage. I had to revert this
> commit [1] to make it work again. Can someone confirm that this drive=
r
> still works with other OMAP boards?
>
> [1] a330ce2001b290c59fe98c37e981683ef0a75fdf

I can confirm that the above patch also breaks the ADS7846 driver on
Overo.  Reverting it results in correct operation.

Steve





> Regards,
>
> Mickael
>
> Adeneo Embedded - Adetel Group
> 2, chemin du Ruisseau
> 69134 ECULLY - FRANCE
> T=E9l. : +33 (0)4 72 18 08 40 - Fax : +33 (0)4 72 18 08 41
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
