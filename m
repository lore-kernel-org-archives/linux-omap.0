From: "mohammed shareef" <mdshareef@gmail.com>
Subject: nano-x for onap5912 osk
Date: Tue, 3 Jun 2008 19:13:30 +0530
Message-ID: <a1d91fa0806030643q4781ce86qf0b2442f6cddbe7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:64149 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbYFCNnc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 09:43:32 -0400
Received: by ti-out-0910.google.com with SMTP id b6so517340tic.23
        for <linux-omap@vger.kernel.org>; Tue, 03 Jun 2008 06:43:30 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

Dear all,

i am trying to compile nano-x for omap-osk..

as given in the below link:

http://oskfordummies.hp.infoseek.co.jp/howto/nanox.html

when i do "make" i get the following error.. infact i get lot more errors..


[root@localhost src]# make
Compiling engine/image_jpeg.c ...
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:49:21:
jpeglib.h: No such file or directory
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:54: error: parse
error before "cinfo"
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c: In function
`init_source':
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:56: error:
`cinfo' undeclared (first use in this function)

what could be wrong..

regards,
Shareef
