From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: can't show in the lcd / display
Date: Thu, 20 Aug 2009 13:26:14 -0700
Message-ID: <d9ca78710908201326v641a3463t646335c351c0ce57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:64909 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbZHTU0N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 16:26:13 -0400
Received: by ywh3 with SMTP id 3so226596ywh.22
        for <linux-omap@vger.kernel.org>; Thu, 20 Aug 2009 13:26:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

hi all

how to show the busybox / shell / desktop in the omap display / lcd?

i try that but failed..:(

OMAP34XX LAB # setenv bootargs console=ttyS0,115200n8 root=/dev/mmcblk0p2
OMAP34XX LAB # mmcinit
OMAP34XX LAB # fatload mmc 0:1 80300000 uImage

my lcd can't respon anything

best regards,
Aldyth M
