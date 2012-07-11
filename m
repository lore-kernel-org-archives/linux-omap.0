From: Kevin Hilman <khilman@ti.com>
Subject: mismerge of 'omap-cleanup-for-v3.6' into tmp-merge
Date: Wed, 11 Jul 2012 13:10:43 -0700
Message-ID: <87fw8yjby4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:35055 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932452Ab2GKUKn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jul 2012 16:10:43 -0400
Received: by pbbrr4 with SMTP id rr4so2470837pbb.9
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 13:10:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Mark A. Greer" <Mark.Greer@AnimalCreek.com>

Hi Tony,

In your current master branch, commit 3dd50d054 (Merge tag
'omap-cleanup-for-v3.6' into tmp-merge) added back the mpu_3xxx_clkdm
into the common clockdomains that was removed by commit 16e5e2c47 (ARM:
OMAP AM35x: clockdomain data: Fix clockdomain dependencies)

This causes duplicate registration attempts for mpu_clkdm and the secon=
d
registration causes a warning from the clockdomain layer:

   clockdomain: mpu_clkdm: powerdomain ({Z=EF=BF=BD=18=D7=82=EF=BF=BD d=
oes not exist

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
