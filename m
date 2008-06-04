From: "mohammed shareef" <mdshareef@gmail.com>
Subject: X11 - makekeys fails with floating point exception
Date: Wed, 4 Jun 2008 10:28:50 +0530
Message-ID: <a1d91fa0806032158o436483dduc658f39af168e6a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:57067 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbYFDE6v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2008 00:58:51 -0400
Received: by ti-out-0910.google.com with SMTP id b6so720983tic.23
        for <linux-omap@vger.kernel.org>; Tue, 03 Jun 2008 21:58:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

Hi,

when i compile x-windows, the xlib--X11 fails with a floating point exception.

../src/util/makekeys < /usr/include/X11/keysymdef.h > ks_tables_h
/bin/sh: line 1: 12048 Floating point exception../src/util/makekeys <
/usr/include/X11/keysymdef.h > ks_tables_h
make[1]: *** [ks_tables.h] Error 136
make[1]: Leaving directory `/root/omap5912/xwin_snapshot/xlibs/X11/src'
make: *** [install-recursive] Error 1

could someone please tell me how to solve this

thank you,
Shareef
