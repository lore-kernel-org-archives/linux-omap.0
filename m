From: "arun c" <arun.edarath@gmail.com>
Subject: omapfb driver support of DSS rotation and mirroring
Date: Fri, 14 Mar 2008 11:33:09 +0530
Message-ID: <c656a4d20803132303o9eed571ma33963219e4f9ddb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.250]:11748 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbYCNGDK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2008 02:03:10 -0400
Received: by hs-out-0708.google.com with SMTP id 4so2875100hsl.5
        for <linux-omap@vger.kernel.org>; Thu, 13 Mar 2008 23:03:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I am working on 2430 SDP and using the latest git kernel.

I tried to rotate the framebuffer by setting the following in the bootargs
video=omapfb:rotate:90
video=omapfb:rotate:180
video=omapfb:rotate:270

But it seemed to fail, the penguin is always appearing at the
top left corner.

Similar way i tried mirroring also, i got the same result.

Any mistakes in my bootargs ?
Can anybody give me the correct bootargs for rotation& mirroring?

Or the framebuffer driver don't support mirrorring and rotation
of graphics pipeline through DSS?

Thanks in advance

Regards,
Arun c
