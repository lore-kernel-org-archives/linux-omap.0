From: Belisko Marek <marek.belisko@gmail.com>
Subject: 2.6.38 not booting on sbc8100 (aka devkit8000)
Date: Thu, 24 Mar 2011 10:52:37 +0100
Message-ID: <AANLkTikAO+FA+0fCNiVj=9wVZ3t+vfx9tJX_SnJ7FGSd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60950 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695Ab1CXJwi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Mar 2011 05:52:38 -0400
Received: by iwn34 with SMTP id 34so9490133iwn.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 02:52:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Try to run 2.6.38 on my sbc8100
(use mach-type for devkit8000 because boards are similar) board but
when u-boot load it to ram I see just:
## Booting kernel from Legacy Image at 80300000 ...
   Image Name:   Linux-2.6.38-06570-g79c21b4
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2967164 Bytes =  2.8 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK
Starting kernel ...

I have changed bootargs to: bootargs=console=ttyO2,115200n8 doesn't
help. Any ideas what could be checked?

Regards,

Marek Belisko

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
