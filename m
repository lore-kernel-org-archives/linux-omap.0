From: Ming Lei <tom.leiming@gmail.com>
Subject: OMAP4: IRQ line of CortexA9 performance monitor
Date: Tue, 22 Feb 2011 00:26:40 +0800
Message-ID: <AANLkTin3q+rv+fcgCE6nwTN+=v_uQzT-Sn++gr6ekXcp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59559 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035Ab1BUQ0l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 11:26:41 -0500
Received: by yxs7 with SMTP id 7so377505yxs.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 08:26:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi,

>From chapter 17 of "Interrupt controller", OMAP4 TRM, I can't
find what is the interrupt line of CortexA9 performance monitor
in omap4. Seems without this information, we can't use perf on
omap4.

Any suggestions or ideas about it?

-- 
Lei Ming
