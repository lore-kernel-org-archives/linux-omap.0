From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] PM / Runtime: Update documentation regarding driver removal
Date: Fri, 01 Jul 2011 15:49:45 -0700
Message-ID: <8739ipsjjq.fsf@ti.com>
References: <Pine.LNX.4.44L0.1107011711370.1624-100000@iolanthe.rowland.org>
	<201107020012.29661.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:56985 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757921Ab1GAWtt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 18:49:49 -0400
Received: by pvf24 with SMTP id 24so3308928pvf.20
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 15:49:48 -0700 (PDT)
In-Reply-To: <201107020012.29661.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 2 Jul 2011 00:12:29 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Commit e1866b33b1e89f077b7132daae3dfd9a594e9a1a (PM / Runtime: Rework
> runtime PM handling during driver removal) forgot to update the
> documentation in Documentation/power/runtime_pm.txt to match the new
> code in drivers/base/dd.c.  Update that documentation to match the
> code it describes.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Reviewed-by: Kevin Hilman <khilman@ti.com>

Thanks, it's clear now.

Kevin
