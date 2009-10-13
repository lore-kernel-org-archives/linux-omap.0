From: Gary Thomas <gary@mlbassoc.com>
Subject: DSS2 frame buffer problem
Date: Tue, 13 Oct 2009 06:55:39 -0600
Message-ID: <4AD478CB.2040302@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:56276 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbZJMM4Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 08:56:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: OMAP Linux discussion <linux-omap@vger.kernel.org>

I have a new board that I'd like to run a frame buffer 800x600x24
When I boot, I get this error:
   omapfb: failed to allocate framebuffer

This board is derived from a board I'm already running DSS2 at
800x600x16 on.

What do I need to change to get this to work?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
