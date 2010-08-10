From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [SPI] SPI100k: Fix 8-bit and RX-only transfers
Date: Tue, 10 Aug 2010 10:40:20 -0600
Message-ID: <AANLkTikJ69g1ORzboEh0-dz8oyuPObCuxDQhRkYjqbz+@mail.gmail.com>
References: <1275178343-28193-1-git-send-email-darkstar6262@gmail.com>
	<AANLkTimJfM2BLTS2Uf9kMV4pT2nqSXZtur9cb0Qi7g7u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37303 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370Ab0HJQkk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 12:40:40 -0400
Received: by gxk23 with SMTP id 23so3818276gxk.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 09:40:40 -0700 (PDT)
In-Reply-To: <AANLkTimJfM2BLTS2Uf9kMV4pT2nqSXZtur9cb0Qi7g7u@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

On Mon, Aug 2, 2010 at 9:34 AM, Cory Maccarrone <darkstar6262@gmail.com=
> wrote:
> On Sat, May 29, 2010 at 5:12 PM, Cory Maccarrone <darkstar6262@gmail.=
com> wrote:
>> This change fixes 8-bit transfers and RX-only transfers. =A0The
>> SPI100k framework requires minimum 16-bit words to be written, so 8-=
bit
>> transfers must be shited by 8 bits and sent out as a 16-bit word.
>>
>> Additionally, receive-only transfers were failing due to the
>> perceived need to fill the TX buffer with something. =A0This is in
>> fact not needed.
>>
>> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>> ---
>> =A0drivers/spi/omap_spi_100k.c | =A0 23 ++++++++++++-----------
>> =A01 files changed, 12 insertions(+), 11 deletions(-)
>>[...]
>
> Adding another name to the list.

This patch has been in my next-spi branch for a while, and I have a
pull request pending out to Linus.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
