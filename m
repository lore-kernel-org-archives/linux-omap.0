From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] [SPI] SPI100k: Fix 8-bit and RX-only transfers
Date: Mon, 19 Jul 2010 21:22:28 -0600
Message-ID: <AANLkTilXQm2z22eXcEHRZDcT1sHDuyxA5ANlPzhKHY1u@mail.gmail.com>
References: <1275178343-28193-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45071 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758143Ab0GTDWt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jul 2010 23:22:49 -0400
Received: by pzk26 with SMTP id 26so1545473pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Jul 2010 20:22:49 -0700 (PDT)
In-Reply-To: <1275178343-28193-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>

On Sat, May 29, 2010 at 6:12 PM, Cory Maccarrone <darkstar6262@gmail.co=
m> wrote:
> This change fixes 8-bit transfers and RX-only transfers. =C2=A0The
> SPI100k framework requires minimum 16-bit words to be written, so 8-b=
it
> transfers must be shited by 8 bits and sent out as a 16-bit word.
>
> Additionally, receive-only transfers were failing due to the
> perceived need to fill the TX buffer with something. =C2=A0This is in
> fact not needed.
>
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
> =C2=A0drivers/spi/omap_spi_100k.c | =C2=A0 23 ++++++++++++-----------
> =C2=A01 files changed, 12 insertions(+), 11 deletions(-)
>

Any feedback on this?  I submitted it almost two months ago and
nothing seems to have happened with it.  Can this be included in the
next RC?

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
