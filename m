From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/2] WLAN regression fixes for omap4 after moving to DT
 based booting
Date: Fri, 13 Sep 2013 22:10:17 -0700
Message-ID: <CAOesGMgzMfxoJpEOXhs8dQrpqavpWxG6_RfXHMEpDnEnOrP7iw@mail.gmail.com>
References: <20130913190811.24617.97699.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:50727 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab3INFKS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Sep 2013 01:10:18 -0400
Received: by mail-wi0-f176.google.com with SMTP id cb5so1589114wib.15
        for <linux-omap@vger.kernel.org>; Fri, 13 Sep 2013 22:10:17 -0700 (PDT)
In-Reply-To: <20130913190811.24617.97699.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

Hi,

Not related to wlan but with DT conversion; I noticed the following in
dmesg on Panda ES with omap2plus_defconfig on current mainline:

[    0.000000] smp_twd: clock not found -2

and:

[    0.440399] omap-gpmc 50000000.gpmc: error: clk_get


-Olof
