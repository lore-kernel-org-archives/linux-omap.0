From: Phaneendra Kumar Alapati <phani@embwise.com>
Subject: MMC_CAP_SDIO IRQ for OMAP35xx
Date: Wed, 28 Oct 2009 12:32:59 +0530
Message-ID: <54d94f230910280002j5a4f710frd76a640f3d15aa01@mail.gmail.com>
References: <54d94f230910272337n150d4ec0kfa382d774479f10e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail10.myhsphere.biz ([64.71.235.184]:42171 "EHLO
	mail10.myhsphere.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757449AbZJ1HJz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 03:09:55 -0400
Received: by pwj9 with SMTP id 9so631013pwj.21
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 00:03:19 -0700 (PDT)
In-Reply-To: <54d94f230910272337n150d4ec0kfa382d774479f10e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

All,

I have not seen any further discussion on the MMC_CAP_SDIO IRQ for
OMAP3430 topic.

I have a working solution for sdio irq support on omap35xx. I have
verified and tested the functionality on omap3530evm with Marvell
88W8686 WLAN cards with linux kernel 2.6.31.rc7=A0 The wifi performance
was 12Mbps for downlink and 10Mbps for uplink. The performance results
and stability are greatly improved compared to the sdio polling. I
will be posting the patch soon.

Regards,
Phani
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
