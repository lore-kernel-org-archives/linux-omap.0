From: Ryan <ryanphilips19@googlemail.com>
Subject: pin muxing
Date: Mon, 22 Feb 2010 17:53:46 +0530
Message-ID: <376636be1002220423h6617e8der15b736d614e3821a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:38004 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab0BVMXr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 07:23:47 -0500
Received: by gxk9 with SMTP id 9so3067576gxk.8
        for <linux-omap@vger.kernel.org>; Mon, 22 Feb 2010 04:23:46 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,
I need to add a couple of mux entries and am refer  to
arch/arm/mach-omap2/mux.c file.

I would like to what is the differences between  BALLNUM_34XX_ and
BALLNUM_3430_ entries.  I could not find any mux entries specific to
BALLNUM_35XX_.

How does one decide if a pin needs to be pulled up or pulldown.

Warm Regards,
 Ryan
