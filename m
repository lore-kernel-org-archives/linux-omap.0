From: twebb <taliaferro62@gmail.com>
Subject: MMC retry after DATA CRC error
Date: Mon, 27 Jul 2009 12:32:57 -0400
Message-ID: <dbdb2ea60907270932u7a27b6bcxdff0f294bd064e20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:53111 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbZG0Qc5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2009 12:32:57 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1685049qwh.37
        for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2009 09:32:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

I'm trying to understand if a retry mechanism exists for MMC upon
recognition of a DATA CRC error.=A0 I can't find it in code, but it
seems like Jarko refers to it several months ago...
(http://marc.info/?l=3Dlinux-omap&m=3D123063047527932&w=3D2)

He says, "Retrying multi-block read in case of data CRC seems
effective and has never failed on the test board.  The performance
penalty of the retry is obviously minimal."

Can anyone provide any details on the retry mechanism?  I'm seeing
occasional DATA CRC errors on MMC transfers (both RD and WR) on MMC2
connected to eMMC.  I'm using OMAP 3530 silicon rev 3.1 so it
shouldn't be the old errata that TI has published - though it seems
very similar.

Thanks,
twebb
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
