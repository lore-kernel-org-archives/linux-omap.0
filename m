From: "N, Mugunthan V" <mugunthanvnm@ti.com>
Subject: how to specify dma_mask and coherent_dma_mask in hwmod
Date: Thu, 7 Jun 2012 16:22:17 +0000
Message-ID: <EB1619762EAF8B4E97A227FB77B7E0293E9AB214@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39689 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab2FGQWZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 12:22:25 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi=20

While converting platform device registry to Hwmod for CPSW Ethernet dr=
iver which is present in AM335X (OMAP2+), I am not finding a way to spe=
cify
dma_mask and coherent_dma_mask.
Is there a way to specify dma_mask and coherent_dma_mask in hwmod?

---
Regards,
Mugunthan V N.=A0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
