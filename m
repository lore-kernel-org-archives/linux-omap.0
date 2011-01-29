From: Grant Erickson <marathon96@gmail.com>
Subject: ARM Architecture and GENERIC_CMOS_UPDATE
Date: Fri, 28 Jan 2011 16:35:05 -0800
Message-ID: <5CF2B383-9CD5-4295-82C5-9466311E1E62@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33994 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623Ab1A2AfJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 19:35:09 -0500
Received: by pwj3 with SMTP id 3so724162pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Jan 2011 16:35:08 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Is there any reason, to date, that the ARM architecture has not had the following kernel configuration option?

	config GENERIC_CMOS_UPDATE
	    def_bool y

Regards,

Grant

