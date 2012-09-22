From: Joni Lapilainen <joni.lapilainen@gmail.com>
Subject: tidspbridge build fails
Date: Sat, 22 Sep 2012 04:46:25 +0300
Message-ID: <CAOSRfZ7FsVw+MOUfGZZFiCrg2Ec1iSgypdY=Lijzn_x8NpkhLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59855 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757545Ab2IVBq1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 21:46:27 -0400
Received: by eaac11 with SMTP id c11so1258065eaa.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 18:46:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Building tidspbridge fails:

  CC [M]  drivers/staging/tidspbridge/core/tiomap3430.o
drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_start':
drivers/staging/tidspbridge/core/tiomap3430.c:421:25: error:
'OMAP343X_CTRL_BASE' undeclared (first use in this function)
drivers/staging/tidspbridge/core/tiomap3430.c:421:25: note: each
undeclared identifier is reported only once for each function it
appears in
make[3]: *** [drivers/staging/tidspbridge/core/tiomap3430.o] Error 1
