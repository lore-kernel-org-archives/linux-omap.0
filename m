From: Catalin Crenguta <catalin.crenguta@gmail.com>
Subject: TLV320AIC3104 Sample rate problem
Date: Mon, 24 Nov 2014 18:03:33 +0200
Message-ID: <CABH3fy9DXUu32b8J-QA6FkpZ7eFNu6gfR=8tApLnQTzfubpsYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f195.google.com ([209.85.212.195]:42966 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaKXQDf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 11:03:35 -0500
Received: by mail-wi0-f195.google.com with SMTP id h11so2351352wiw.2
        for <linux-omap@vger.kernel.org>; Mon, 24 Nov 2014 08:03:33 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, beagleboard@googlegroups.com

Hello,

I'm using an Audio Cape Rev. B connected to BeagleBone Black
(MCLK=12MHz) and I'm trying to record audio at sample rate 8KHz.
Recording and playback using ALSA is OK, but when playing the recorded
samples on PC you can hear that the actual sample rate is lower (the
pitch shifted to a lower tone).
I have added debug messages throughout the alsa driver tlv320aic3x.c,
and I found out that the PLL parameters are computed correctly as in
TLV320AIC3104 Datasheet Table found at page 27. (p: 1 j: 8 d: 1920 r:
1).
Has anyone else encountered a problem like this? Can someone with more
experience check the driver?

Kernel: https://github.com/beagleboard/linux , commit 2bcc89c, 3.14.19+.

Best regards,
Catalin Crenguta
