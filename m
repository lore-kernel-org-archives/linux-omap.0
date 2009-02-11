From: Gary Thomas <gary@mlbassoc.com>
Subject: OMAP I2C question
Date: Wed, 11 Feb 2009 09:58:43 -0700
Message-ID: <499303C3.3030101@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 137-67-76-76-skybeam.com ([76.76.67.137]:1334 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755738AbZBKQ6q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Feb 2009 11:58:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP <linux-omap@vger.kernel.org>

Why is I2C_FUNC_SMBUS_QUICK functionality missing in i2c-omap.c?

This prevents using drivers which use the generic i2c_probe()
method of finding devices.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
