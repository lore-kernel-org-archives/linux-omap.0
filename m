From: =?GB2312?B?seXA2g==?= <mykofzone@gmail.com>
Subject: OMAP3 ISP DMA status
Date: Mon, 7 Nov 2011 17:33:31 +0800
Message-ID: <CAORxB+CUEi-bykNky9T+nBOiV7mBpXnEv_uzfS=McxUdTeODSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33332 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab1KGJdc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 04:33:32 -0500
Received: by qyk2 with SMTP id 2so3243241qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 01:33:31 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi ALL,
   I meet a problem when developing scan device (such as a camera)
driver on OMAP3 platform (my MPU is AM3715). The scan application may
change the scan hardware settings (such as exposure time), and try to
find out the best one. But sometimes, after applied the new settings,
the scan hardware may did not output data, so the application blocked.
Since i can't modify the application, the driver should notify this
event to app. So my question is that, can the driver query the ISP DMA
status such as how many bytes the DMA has transferred?

BRs,
Lei.Bian
