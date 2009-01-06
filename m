From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: Spurious interrupt warning
Date: Tue, 6 Jan 2009 15:24:13 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02E6629AAC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34263 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbZAFJyf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 04:54:35 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n069sTf0025417
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 03:54:34 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n069sRsC026497
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 15:24:28 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I have ported the V4L2 driver on top of Tomi's DSS library.  DSS librar=
y has requested irq number 25.  It is never freeing it.  But whenever I=
 get interrupt from the DSS I get this warning intermittently.=20

<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25



Please note it's not continuous.  Driver is also working fine. Is it so=
mething to do with the latest spurious interrupt patch. =20
http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.git;a=
=3Dcommitdiff;h=3Dea153a1765dc754be688013192e8c83c40e008dc

Is there something to do in the driver to solve this interrupt warning =
issue.=20






Thanks and Regards,
Hardik Shah

=A0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
