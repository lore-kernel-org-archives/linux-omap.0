From: Gary Thomas <gary@mlbassoc.com>
Subject: DSS2 TV settings
Date: Wed, 10 Jun 2009 11:17:57 -0600
Message-ID: <4A2FEAC5.1060107@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:2807 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760797AbZFJRR5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2009 13:17:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

Tomi,

I'm running your latest DSS2 tree and have some questions about
the TV settings.  The timings, as published, don't work all that
well on our TV sets.  When I display a frame buffer to the TV
(using the recipe from the Documentation directory), some of
the actual frame buffer does not show on the screen.  In particular,
if I have "tux" from the default system console framebuffer
showing, the top of his head is chopped off, as is a fair
amount of his left side.  Further tests show that some amount
of the frame buffer is not present on all margins.

Is this to be expected?
Can the timings be adjusted so that the whole frame buffer shows?

[not 100% related] The documentation says that TI is working on
the V4L2 support.  Do you know the status of this?  where I might
find it?

Thanks for your comments

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
