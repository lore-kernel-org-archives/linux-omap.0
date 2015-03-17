From: Ran Shalit <ranshalit@gmail.com>
Subject: omap voltage driver errors
Date: Tue, 17 Mar 2015 21:12:06 +0200
Message-ID: <CAJ2oMhJGLZQc4rSG6LtZ=Sk-uggbawADKSZtdBL=aGZn1Ux6ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35664 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbbCQTMH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2015 15:12:07 -0400
Received: by wibdy8 with SMTP id dy8so71373670wib.0
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2015 12:12:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hello,

I receive the following errors in boot:

....

omap_voltage_early_init: voltage driver support not added
regulator: core version 0.5
regulator: dummy:
NET: Registered protocol family 16
omap_voltage_domain_lookup: Voltage driver init not yet happened.Faulting!
omap_voltage_add_dev: VDD specified does not exist!

.....
It seems that omap_voltage_early_init should be called somehow, but I
don't see it being called anywhere in kernel.
Is anyone familiar with this ?

Regards,
Ran
