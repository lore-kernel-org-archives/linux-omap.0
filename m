From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: TVP5146 support on OMAP3EVM?
Date: Tue, 10 Aug 2010 22:09:21 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044EF4D9B7@dbde02.ent.ti.com>
References: <4C617448.8030605@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37918 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932370Ab0HJQjd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 12:39:33 -0400
In-Reply-To: <4C617448.8030605@matrix-vision.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Michael Jones
> Sent: Tuesday, August 10, 2010 9:16 PM
> To: linux-omap@vger.kernel.org
> Subject: TVP5146 support on OMAP3EVM?
> 
> I'm evaluating OMAP using the OMAP3EVM eval board.  I originally had a
> 2.6.32 kernel 'linux-omap-psp-2.6.32' (http://arago-
> project.org/git/people/?p=sriram/ti-psp-omap.git;a=summary).  I have since
> moved to the latest 'devel' branch on omap3camera (2.6.35).  There, as on
> the current linux-omap, there seems to no longer be support for the TVP5146
> decoder *on the OMAP3EVM*.  In my 2.6.32 branch, there was a file "board-
> omap3evm-camera.c" which defined the TVP on the OMAP3EVM.
> 
[Hiremath, Vaibhav] First of all I still have to add support for OMAP3EVM and TVP5146 decoder ontop of latest omap3camera/devel branch and that is the reason you won't find support for board-omap3evm-camera.c.

> Has support for the TVP5146 decoder on the OMAP3EVM been dropped, or am I
> overlooking something?
> 
[Hiremath, Vaibhav] No, you are not overlooking anything here, as I mentioned above the fact is, earlier you were using PSP release which supports TVP5146 video decoder interface.

I had started working on this sometime back but again had to put on hold due to other high priority issues, but yes soon I will be adding support for OMAP3EVM on top of omap3camera/devel branch.

I will keep you posted on this.

Thanks,
Vaibhav


> Does anyone know of a demo for the OMAP3EVM for capturing images to test the
> OMAP?  The TVP seems ideal because I don't need a daughter card with an
> image sensor, just video input.  Perhaps I need to fall back on the 2.6.29
> kernel that came with the board with PSP-02.01.03.11.
> 
> thanks,
> Michael
> 
> MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
> Registergericht: Amtsgericht Stuttgart, HRB 271090
> Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-
> Joachim Reich
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
