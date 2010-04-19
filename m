From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Please use proper threading while sending patches
Date: Mon, 19 Apr 2010 15:38:52 +0300
Message-ID: <p2h94a0d4531004190538o57f3f6c8n1cfdbcffaa38b229@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:52234 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab0DSMiy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 08:38:54 -0400
Received: by ewy20 with SMTP id 20so1406393ewy.1
        for <linux-omap@vger.kernel.org>; Mon, 19 Apr 2010 05:38:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I've noticed that many people use bad threading while sending patches.

Bad:
http://thread.gmane.org/gmane.linux.ports.arm.omap/34138

Good:
http://thread.gmane.org/gmane.linux.ports.arm.omap/33112

In order to configure git to use proper threading do this:
 % git config sendemail.chainreplyto false

This is already the default in git 1.7.

I've also updated omapmedia accordingly:
http://omappedia.org/wiki/Releasing_to_Linux_kernel_using_patches_and_emails

Cheers.

-- 
Felipe Contreras
