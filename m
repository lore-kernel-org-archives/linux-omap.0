From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl-core: Clean up module by removing twl603x pdata
 handling
Date: Mon, 2 Dec 2013 13:13:31 +0000
Message-ID: <20131202131331.GE31626@lee--X1>
References: <1385036008-1727-1-git-send-email-ruslan.ruslichenko@globallogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:60672 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab3LBNNf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 08:13:35 -0500
Received: by mail-ie0-f169.google.com with SMTP id e14so20656592iej.14
        for <linux-omap@vger.kernel.org>; Mon, 02 Dec 2013 05:13:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1385036008-1727-1-git-send-email-ruslan.ruslichenko@globallogic.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Ruslichenko <ruslan.ruslichenko@globallogic.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, 21 Nov 2013, Ruslan Ruslichenko wrote:

> Since currently nobody uses TWL603x platform data and all new
> users will supply it through device tree, handling of these
> data within twl-core will never be used, so remove it.
>=20
> Signed-off-by: Ruslan Ruslichenko <ruslan.ruslichenko@globallogic.com=
>
> ---
>=20
> Tested on TI SDP/Tablet OMAP4460 board
> Based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> commit 5e01dc7 Linux 3.12
>=20
>  drivers/mfd/twl-core.c | 198 ---------------------------------------=
----------
>  1 file changed, 198 deletions(-)

Okay, I'm suitably happy with yours and Tony's responses.

Patch applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
