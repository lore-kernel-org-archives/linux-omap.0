From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: sakoman-linux-omap-2.6/omap-2.6.38 branch: mmcblk0: retrying
 using single block read
Date: Sat, 30 Apr 2011 17:36:17 -0700
Message-ID: <BANLkTikUjuMM7yCNO5ZJku9qJOWKQ+X7Ug@mail.gmail.com>
References: <C73B43B7-AC74-4DBD-94E1-CA213B93EFEC@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33045 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab1EAAgT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Apr 2011 20:36:19 -0400
Received: by vxi39 with SMTP id 39so3567746vxi.19
        for <linux-omap@vger.kernel.org>; Sat, 30 Apr 2011 17:36:17 -0700 (PDT)
In-Reply-To: <C73B43B7-AC74-4DBD-94E1-CA213B93EFEC@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

On Sat, Apr 30, 2011 at 1:21 AM, Elvis Dowson <elvis.dowson@mac.com> wr=
ote:
> Hi,
> =A0 =A0 =A0 I'm using a Gumstix Overo Fire COM module (TI OMAP 3530 E=
S2.1) with Chestnut43 expansion board.
>
> I built the linux kernel using the omap-2.6.38 branch located here:
>
> http://www.sakoman.com/cgi-bin/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3D=
shortlog;h=3Drefs/heads/omap-2.6.38
>
> I use the omap3_defconfig supplied in this branch. When I boot, I get=
 the following mmc errors:
>
> Freeing init memory: 180K
> omap_device: omap_i2c.1: new worst case deactivate latency 0: 61035
> mmcblk0: retrying using single block read
> mmcblk0: retrying using single block read
> mmc1: new SDIO card at address 0001
> mmcblk0: retrying using single block read
> mmcblk0: retrying using single block read
> mmcblk0: retrying using single block read
> mmcblk0: retrying using single block read
> mmcblk0: retrying using single block read
> mmcblk0: retrying using single block read
>
> Does anyone have a patch or fix for this issue?

I haven't seen this issue.  Perhaps a bad card?  Have you tried a diffe=
rent one?

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
