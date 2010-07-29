From: Laine Walker-Avina <lwalkera@pasco.com>
Subject: OMAP DSS2 coming out of OFF mode without restoring context
Date: Thu, 29 Jul 2010 14:29:12 -0700
Message-ID: <AANLkTimpATpjeaq5OYf_5zy-o1ho2UxppjF6+Re9QqUb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48940 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab0G2V3N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 17:29:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org

Hi,

I'm having a problem where the DSS driver isn't restoring the
framebuffer parameters after going in and out of blanking with OFF
mode enabled. The problem appears to be in dss_get_ctx_id() in that
pdata->get_last_off_on_transaction_id is 0. Commenting out the call to
dss_need_ctx_restore() in dss_clk_enable() appears to do the right
thing. I'm using the current master branch of linux-omap.

-- 
Laine Walker-Avina
Firmware Engineer
PASCO scientific
