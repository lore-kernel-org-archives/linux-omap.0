From: Mats Liljegren <liljegren.mats2@gmail.com>
Subject: Full nohz on TCI6638k2k (KeyStone II)
Date: Fri, 26 Apr 2013 09:06:25 +0200
Message-ID: <CA+xJJ18wBM7G=Nt12yMX8KLmTZWS+SnBsXb3F4X1xgq=Y=0y0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45446 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab3DZHG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 03:06:27 -0400
Received: by mail-ee0-f46.google.com with SMTP id c13so1547775eek.19
        for <linux-omap@vger.kernel.org>; Fri, 26 Apr 2013 00:06:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, meta-ti <meta-ti@yoctoproject.org>

I would like to perform a customer demo running a benchmark
application in full nohz mode on TCI6638k2k target, which as far as I
understand it is a KeyStone II architecture.

Does anyone know what the best Linux source code is to perform the
nohz port for this board? It should preferably be Linux 3.9 of any RC
level, but 3.8 should work as well.

I also need a hardware timer to be used as an interrupt source for the
interrupt latency measurements. Any suggestions for framework or
driver to use?

/Mats
