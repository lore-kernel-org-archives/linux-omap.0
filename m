From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: 32-bit access to 16-bit register on L4_PER
Date: Wed, 2 Oct 2013 15:13:32 +0300
Message-ID: <CAArO44tq+3bxWKkxN8anoj0bi-qGA1fRHJZwpHGpZzQ0dpbRdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:47119 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495Ab3JBMNd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 08:13:33 -0400
Received: by mail-bk0-f48.google.com with SMTP id my13so280295bkb.7
        for <linux-omap@vger.kernel.org>; Wed, 02 Oct 2013 05:13:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Recent commit 76bac1987ca181d54f8c9456d20997cb1020af2d
"OMAP: UART: Fix the revision register read" changed UART_MVR 16-bit
read to 32-bit.

But pre-OMAP4 devices have 16-bit MVR register.
Is it safe to assume that 32-bit access will return 0's in upper
16-bits in this case?

-- 
Regards,
Taras Kondratiuk
