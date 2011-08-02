From: Koen Kooi <koen@dominion.thruhere.net>
Subject: omap_vout build error with latest linus
Date: Tue, 2 Aug 2011 15:09:19 +0200
Message-ID: <0DADC92F-8EF3-4948-846B-F78EA50BADE4@dominion.thruhere.net>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37977 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab1HBNJX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 09:09:23 -0400
Received: by wwe5 with SMTP id 5so6714898wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 02 Aug 2011 06:09:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
Cc: Jason Kridner <jkridner@beagleboard.org>

Hi,

When trying to build latest linus[1] for beagleboard I get:

|   CC      drivers/media/video/omap/omap_vout.o
| drivers/media/video/omap/omap_vout.c: In function =91omap_vout_probe=92=
:
| drivers/media/video/omap/omap_vout.c:2202:15: error: =91struct omap_d=
ss_driver=92 has no member named =91set_update_mode=92
| drivers/media/video/omap/omap_vout.c:2203:12: error: =91struct omap_d=
ss_driver=92 has no member named =91set_update_mode=92
| drivers/media/video/omap/omap_vout.c:2204:8: error: =91OMAP_DSS_UPDAT=
E_MANUAL=92 undeclared (first use in this function)
| drivers/media/video/omap/omap_vout.c:2204:8: note: each undeclared id=
entifier is reported only once for each function it appears in
| drivers/media/video/omap/omap_vout.c:2206:15: error: =91struct omap_d=
ss_driver=92 has no member named =91set_update_mode=92
| drivers/media/video/omap/omap_vout.c:2207:12: error: =91struct omap_d=
ss_driver=92 has no member named =91set_update_mode=92
| drivers/media/video/omap/omap_vout.c:2208:8: error: =91OMAP_DSS_UPDAT=
E_AUTO=92 undeclared (first use in this function)
| make[4]: *** [drivers/media/video/omap/omap_vout.o] Error 1
| make[3]: *** [drivers/media/video/omap] Error 2
| make[2]: *** [drivers/media/video] Error 2
| make[1]: *** [drivers/media] Error 2
| make: *** [drivers] Error 2
| make: *** Waiting for unfinished jobs=85.

It looks like the v4l2 driver needs some updates to work with the lates=
t dss2

regards,

Koen

[1] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommit;h=3Dc027a474a68065391c8773f6e83ed5412657e369--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
