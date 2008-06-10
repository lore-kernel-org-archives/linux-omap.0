From: "mohammed shareef" <mdshareef@gmail.com>
Subject: omap osk audio
Date: Tue, 10 Jun 2008 20:03:56 +0530
Message-ID: <a1d91fa0806100733o71e5f1dx5bed802e65275ccc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:60032 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbYFJOd6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 10:33:58 -0400
Received: by ti-out-0910.google.com with SMTP id b6so701880tic.23
        for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 07:33:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>, linux-newbie@vger.kernel.org

Dear all,

I am working on omap osk. i want to enable audio on it. But am not
able to do that. The kernel boot log says it has initialized audio
device. but i am not able to configure the audio setting nor run some
recording code. the system hangs and i have to restart.

the kernel boot code says:

TLV320AIC23 I2C version 1.8 (10-Feb-2006)
audio support initialized
ALSA device list:
 #0: OSK AIC23

i have created nodes:

# mknod /dev/mixer c 14 0
# mknod /dev/dsp c 14 3

thanx,
Shareef
