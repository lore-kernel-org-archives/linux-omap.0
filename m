From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from board file
Date: Wed, 3 Nov 2010 15:02:36 +0200
Message-ID: <AANLkTikKMnzHR5DZqzGdJJbnCXhCpxKA7K2C2ZtPhNke@mail.gmail.com>
References: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
	<1285596710-25658-5-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59167 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab0KCNCh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Nov 2010 09:02:37 -0400
Received: by qyk12 with SMTP id 12so69012qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Nov 2010 06:02:36 -0700 (PDT)
In-Reply-To: <1285596710-25658-5-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Vimal Singh <vimalsingh@ti.com>, Artem.Bityutskiy@nokia.com

On Mon, Sep 27, 2010 at 5:11 PM, Sukumar Ghorai <s-ghorai@ti.com> wrote=
:
> This patch makes it possible to select sw or hw (different layout opt=
ions)
> ecc scheme supported by omap nand driver. =A0And hw ecc layout select=
ed for
> sdp and zoom boards, by default.
>
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>

Any news on this? Commit 2c01946c accidentally (?) enabled hardware
ECC and now my board is broken, as the driver always used sw ecc and
my NAND partitions are formatted accordingly. We should at least
switch the default back to sw ecc, don't you think?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
