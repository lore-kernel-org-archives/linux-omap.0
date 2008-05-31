From: "mohammed shareef" <mdshareef@gmail.com>
Subject: zlib error in x-windows on omap osk
Date: Sat, 31 May 2008 12:10:31 +0530
Message-ID: <a1d91fa0805302340q10d4a00dn12087f0cf0e8c3dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:34029 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbYEaGkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 May 2008 02:40:35 -0400
Received: by ti-out-0910.google.com with SMTP id b6so87059tic.23
        for <linux-omap@vger.kernel.org>; Fri, 30 May 2008 23:40:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

Hi all,

when i run the autogen script for Xfonf in xlibs for x-windows, i get
the following error..

checking for gzopen in -lz... no
configure: error: *** zlib is required
[sbox-ARM-GLIBC: ~/xwin_snapshot/xlibs/Xfont] >


i have already installed zlib..
all the previous xlib files compiled without any error.

am following the tutorial:
http://linux.omap.com/pipermail/linux-omap-open-source/2005-March/003174.html

could someone tell me whats the solution to the above problem?

thank you,
