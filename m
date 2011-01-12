From: Thomas Winkler <tom.winkler@gmail.com>
Subject: Q: OMAP 4430 FDIF (Face Detection Interface)
Date: Wed, 12 Jan 2011 17:42:22 +0100
Message-ID: <AANLkTimZqR3OTKzJ=KdLNYGjOfPFZtCKtrJMqZGPP+rb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51391 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab1ALQmX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 11:42:23 -0500
Received: by iwn9 with SMTP id 9so684441iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Jan 2011 08:42:22 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dear OMAP Developers,

I'm working on a driver for the face detection interface (FDIF) IP
core that is part of the OMAP 4430 SoC.
My development platform is the Pandaboard. I'm make good progress - I
was able to set up the IP
core according to the TI documents (SWPU231N). For now, I'm not using
interrupts but poll while waiting
for the results. Starting the FDIF engine (FD_CTRL RUN bit) works as
expected and the completion of the
procedure is indicated via the FD_CTRL FINISH bit as described by the
documentation. So far so good.
The issue I have is that no matter what data (i.e., 320x240 grayscale
image with faces on it) i send to the
core, I always get 0 detections reported in the FD_DNUM register.
I've been playing around with the "performance parameters" exposed by
the core via the FD_COND and
FD_LHIT registers but had no luck. I have no idea why I'm not getting
any detections. And since I do not
get any other feedback than the 0 in FD_DNUM from the core, this is
difficult to debug.
Are there somewhere  test images available that are known to produce
results other than 0 faces? Maybe
someone from TI who is familiar with the FDIF subsystem could help me
with this one.
I'd really appreciate that!

Thank you,
Thomas
