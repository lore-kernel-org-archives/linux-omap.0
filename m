From: Santosh <santosh.shilimkar@ti.com>
Subject: [POWER DOMAIN suspend callbacks] Observation.
Date: Tue, 23 Aug 2011 19:49:40 +0530
Message-ID: <4E53B6FC.8030507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53028 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751869Ab1HWOTu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 10:19:50 -0400
Received: by mail-yi0-f54.google.com with SMTP id 19so129419yib.41
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 07:19:47 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
Cc: Govindraj R <govindraj.raja@ti.com>

Rafael, Kevin,

On latest kernel( V3.1-rc1+), the subsystem(driver) suspend
callbacks are not getting called because power domain callbcaks
are populated.

And as per commit 4d27e9dc{PM: Make power domain callbacks take
precedence over subsystem ones}, it's expected bahavior.

Who is suppose to call the driver suspend callback?
Some drivers/subsystem would have state machine which needs to
be suspended.

Is the power domain suspend callback, suppose to take care of
it ? If yes, then that seems to be missing for OMAP.

Thanks for clarification.

Regards
Santosh
