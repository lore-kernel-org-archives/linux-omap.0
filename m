From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: prepatch: work around broken brf6150 PM code
Date: Sat, 30 May 2009 18:25:13 +0100
Message-ID: <20090530182513.214244z6d3s8cb9c@lidskialf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_43b4sx9a1b0g"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:38402 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760317AbZE3RZM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 May 2009 13:25:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ville.tervo@nokia.com

This message is in MIME format.

--=_43b4sx9a1b0g
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, this patch took a while to track down. The brf6150.c from the =20
original Nokia n770 kernel source (kernel-source-2.6.16-2.6.16-osso29) =20
works. However, the brf6150.c that was added to the linux-omap tree on =20
the 8th feb 2006 (commit 9f43ca7f2eca4de6f145bc1d165df4a415546258) =20
does not (for this n770 anyway :).

In the linux-omap commit, there is a lot of new neat power management =20
code that uses two GPIOs: one for the host to signal the brf6150 when =20
to wake up and one for the brf6150 to signal the host to wake up.

The problem is that on the hardware I'm using these GPIOs do not =20
change, so the host never "wakes up", and consequently never schedules =20
packets to be transferred to the brf6150. I've tested the platform =20
GPIO library is working properly and appears to be.

The n770 code is configured to use the following brf6510 GPIOS: =20
reset:4, hostwake:61, btwake:194.

The attached patch forces this schedule, but isn't really a good patch =20
as the (non-functional) PM stuff is still in there.

Can anyone shed any light on this situation? Note that I am using the =20
brf6150fw.bin firmware binary from the =20
SU-18_2006SE_1.2006.26-8_PR_F5_MR0_ARM OS release.

The bluetooth firmware from SU-18_2006SE_2.2006.39-14_PR_F5_MR0_ARM is =20
corrupt (has loads of zero bytes at the start, which the code reveals =20
is invalid).

The bluetooth firmware from SU-18_2006SE_3.2006.49-2_PR_F5_MR0_ARM is =20
ALSO corrupt; this time its been truncated to 8192 bytes so the loader =20
runs off the end.

If this can't be resolved, and since I don't have any docs on the =20
brf6150 or newer firmware images, I'd be tempted to simply kill the PM =20
code since its not actually doing anything useful. I'd prefer to get =20
it to work though....

--=_43b4sx9a1b0g
Content-Type: text/x-patch;
	charset=UTF-8;
	name="brf6150-fix-tx.patch"
Content-Disposition: attachment;
	filename="brf6150-fix-tx.patch"
Content-Transfer-Encoding: 7bit

commit 3dd6f369919225473c77db006a60af0d1ca66ce4
Author: Andrew de Quincey <adq@lidskialf.net>
Date:   Sat May 30 18:04:24 2009 +0100

    schedule tx when packet submitted due to non-working power management GPIOs

diff --git a/drivers/bluetooth/brf6150.c b/drivers/bluetooth/brf6150.c
index 4f0112a..50caa74 100644
--- a/drivers/bluetooth/brf6150.c
+++ b/drivers/bluetooth/brf6150.c
@@ -187,6 +187,7 @@ static void brf6150_disable_pm_tx(struct brf6150_info *info)
 	}
 	if (gpio_get_value(info->btinfo->host_wakeup_gpio))
 		tasklet_schedule(&info->tx_task);
+	tasklet_schedule(&info->tx_task);
 }
 
 static void brf6150_pm_timer(unsigned long data)

--=_43b4sx9a1b0g--

