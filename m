From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: cam_mclk clock not responding properly in OMAP3430
Date: Thu, 4 Sep 2008 16:51:13 -0500
Message-ID: <A24693684029E5489D1D202277BE894411A86D15@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34472 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754474AbYIDVvV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 17:51:21 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

I'm working on camera implementation, and I want to debug why the cam_mclk clock is returning me a "count exceeded" message, although seems to be properly taken. (i.e. MT9P012 + ISP sensor works fine)

I'm having this message when trying to acquire it:

Clock cam_mclk didn't enable in 100000 tries

Any clue why is that?

Regards,
Sergio
