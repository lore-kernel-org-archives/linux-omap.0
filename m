From: Gary Thomas <gary@mlbassoc.com>
Subject: DSS2 & V4L2
Date: Mon, 19 Apr 2010 06:29:36 -0600
Message-ID: <4BCC4CB0.7090607@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:34017 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab0DSM3h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 08:29:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, hvaibhav@ti.com

I'm trying to get the DVSDK (3.01.00.03) working.  It uses
2.6.32 + DSS2 + V4L2.

What I'm having trouble with is how to configure/create/setup
a video overlay such that I get V4L2 device for the display.
In particular, what magic is required to create /dev/video1?

Note: I'd be glad to send this question to a more targeted list,
but the only one mentioned in the DVSDK documentation does not
really exist :-(

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
