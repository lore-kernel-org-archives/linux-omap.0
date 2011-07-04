From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: AM3505/3517 support
Date: Mon, 04 Jul 2011 15:29:09 -0400
Message-ID: <4E121485.6060700@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:48839 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802Ab1GDTzt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jul 2011 15:55:49 -0400
Received: from raph.usine.8d.com ([192.168.142.55])
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1QdopS-0001FX-4A
	for linux-omap@vger.kernel.org; Mon, 04 Jul 2011 15:29:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

We have a custom designed based on the AM3505 and we wish to run a mode=
rn kernel
on it. Unfortunately, it seems a lot of efforts have been made to suppo=
rt other=20
OMAP chips and that some work is still required to support the AM3505/3=
517=20
completely. (does not boot as-is)

Is there anyone working on this right now? Not knowing, I have already =
started
working on it.

The am3505 is apparently so similar to the 3430 that it was treated as =
such=20
(omap_chip.oc was being set to CHIP_IS_OMAP3430ES3_1). There are howeve=
r a
few differences that need to be addressed. I have therefore created a n=
ew
CHIP_IS and patched clocks, hwmod and power management related files
consequently. My system now boots until it complains that it is unable=20
to mount its root filesystem.

I will send my patches in a moment for comments and hopefully, after a=20
few iterations, they will be acceptable. I know a lot of cleanup is=20
happening right now and as a result my patches may not apply or conflic=
t.=20
Please let me know and I will be happy to rebase them as needed.

Looking forward to your comments and help.=20

One of the next things I'll look at is how to properly support the ZCN =
package.
Right now, the CBB package is used (board-am3517evm.c for instance) but=
 there
are differences that prevent some GPIOs from being configured properly.=
 It would
be nice to know if someone is working on this before I start...

Best regards,
Rapha=EBl Ass=E9nat
8D Technologies inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
