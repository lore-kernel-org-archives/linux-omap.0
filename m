From: InKi Dae <daeinki@gmail.com>
Subject: Hello Tomi Valkeinen, I have some questions about dss2 driver.
Date: Wed, 11 Mar 2009 13:57:30 +0900
Message-ID: <90b950fc0903102157q21dec037m65edee4afe104d6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:65098 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbZCKE5d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 00:57:33 -0400
Received: by wa-out-1112.google.com with SMTP id v33so1494364wah.21
        for <linux-omap@vger.kernel.org>; Tue, 10 Mar 2009 21:57:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

I am using your dss2 driver downloaded from your git server and tried
to rotate an image(RGB24U and YUV2 format) using OMAPFB_ROT_DMA
command.
but I can't see rotated image on screen. I added variables for
rotating like below. as the result, LCD Panel is stoped.

omapfb.rotate=2
omapfb.vrfb=n


and then I tried again using OMAPFB_ROT_VRFB command like below.

omapfb.rotate=2
omapfb.vrfb=y

In this case, I can see rotated image(only RGB24U format) on screen.
You asid "Rotation and mirroring currently only supports RGB565 and
RGB8888 modes. VRFB does not support mirroring" through
/Documentation/arm/OMAP/DSS file.

Doesn't your dss2 driver support DMA rotation?
I am trying to add rotation feature for YUV2 image using VRFB to your
dss2 driver.

for this, I think that it have to change rot and mirror become 0 if
rotation_type is OMAPFB_ROT_VRFB to be rot=ofbi->rotation and mirror =
ofbi->mirror (in omapfb-main.c file) and
add codes for calculating offset0, offset1, pixel increment and row
increment value for YUV2 format also pixel size becomes 4 in YUV2 case
(in dispc.c fild).
omap_vrfb_setup function must be modifed also (in vrfb.c file)?

Do you have any idea?
I need your help and advice.

Thank you.
- InKi-
