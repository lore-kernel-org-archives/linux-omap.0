From: halli manjunatha <hallimanju@gmail.com>
Subject: Display flicker problem with TOMI's display framework
Date: Wed, 29 Apr 2009 12:14:21 +0530
Message-ID: <ca6476860904282344g637e529bgeb1dc378256782fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:40673 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbZD2GoV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 02:44:21 -0400
Received: by yw-out-2324.google.com with SMTP id 5so595504ywb.1
        for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 23:44:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,
           I have ported  tomi's framework to 2.6.28 kernel and i am
using this with android
whenever i open  a window  or  widgets  i am getting flickers and
stabilizes. previously with
TI's display framework i got  the same problem that time i just increased the
FB_OMAP_CONSISTENT_DMA_SIZE to 4MB and the problem solved. I did the same
with the tomi's framework but no improvement.


-- 
Regards
Manjunatha H
