From: Rajendra Nayak <rnayak@ti.com>
Subject: handling clock nodes with both parent and divider selection
Date: Mon, 31 Jan 2011 19:36:59 +0530
Message-ID: <045d24bba9bbbe9fa47f0f8aa9901b7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35038 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755535Ab1AaOHD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 09:07:03 -0500
Received: by mail-ey0-f177.google.com with SMTP id 9so2313999eyd.36
        for <linux-omap@vger.kernel.org>; Mon, 31 Jan 2011 06:07:01 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org

Hi Paul,

On OMAP4, some aux clk nodes (part of SCRM) have control
for both parent and divider selection. Is there a way in the
current clock framework for OMAP's to handle this?

Regards,
Rajendra
