From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: DSS2 & V4L2
Date: Mon, 19 Apr 2010 14:58:59 +0200
Message-ID: <7FBB6B9E-A996-46E8-945D-0DC04F06CF24@student.utwente.nl>
References: <4BCC4CB0.7090607@mlbassoc.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:47265 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916Ab0DSM7F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 08:59:05 -0400
Received: by wwb24 with SMTP id 24so2494013wwb.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Apr 2010 05:59:04 -0700 (PDT)
In-Reply-To: <4BCC4CB0.7090607@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, hvaibhav@ti.com


Op 19 apr 2010, om 14:29 heeft Gary Thomas het volgende geschreven:

> I'm trying to get the DVSDK (3.01.00.03) working.  It uses
> 2.6.32 + DSS2 + V4L2.
> 
> What I'm having trouble with is how to configure/create/setup
> a video overlay such that I get V4L2 device for the display.
> In particular, what magic is required to create /dev/video1?

The trick is usually "do not create >2 framebuffers". My understanding is that an overlay can either be a framebuffer or a v4l device, but not both.

regards,

Koen