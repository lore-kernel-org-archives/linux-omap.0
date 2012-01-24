From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: Why was the gptimer_wakup from suspend removed?
Date: Tue, 24 Jan 2012 23:45:05 +0100
Message-ID: <3D8305F5-07DF-4B04-981D-762214113CDB@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33031 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752274Ab2AXWpK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 17:45:10 -0500
Received: by lagu2 with SMTP id u2so357958lag.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 14:45:08 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

It was removed in:
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=98e182a26bbbf5575457622337684ef61493e864

The commit message says a bit about what was done, but not why.

I'm trying to get suspend somewhat working on my board. The board is based on the beagleboard and uses the 1.8V to charge some external equipment. My thought was to suspend, wake occasionally to check if the charging is done, and shutdown if it is. In 2.6.39 which I'm currently using, it's still there, but since it is gone in 3.0 and later I'm wondering if I should not rely on it.

Tasslehoff