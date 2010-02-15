From: Stephen Berry <steve@gravityperformance.net>
Subject: VPFE on OMAP?
Date: Mon, 15 Feb 2010 09:21:02 -0500
Message-ID: <4B79584E.2000005@gravityperformance.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp102.biz.mail.re2.yahoo.com ([68.142.229.216]:25633 "HELO
	smtp102.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755244Ab0BOO1n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Feb 2010 09:27:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I am interested in porting my 5 mega pixel CMOS sensor design to the
beagle board (OMAP3) but after checking out two different kernel trees
and checking the beagle and OMAP lists, I can't find support for the
VPFE hardware for this processor.

I did find a patch on this list that created a ti-media directory for
VPFE support, but it was commented that it would need to be re-based and
resubmitted. I'd rather not develop on a patch if it isn't going anywhere.

Does anyone know what is going on with the VPFE?

