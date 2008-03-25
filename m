From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: VRFB based rotation for omapfb
Date: Tue, 25 Mar 2008 16:56:45 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A00181B1BF@dbde01.ent.ti.com>
References: <c656a4d20803250153x344a8706j9fbba527576044e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:53191 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278AbYCYL0y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Mar 2008 07:26:54 -0400
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20803250153x344a8706j9fbba527576044e0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>, linux-omap@vger.kernel.org

Hi Arun,

> 
> Hi all,
> 
> I am trying to implement vrfb based rotation for the git omapfb
> driver.
> 
> It requires change of fb_fix_screeninfo ( Physical address of fb and
> such things)
> and fb_info (virtual address of buffer) because different rotation
> angles require
> different physical addresses for VRFB based rotation. Moreover this
> changes
> has to be done dynamically.
> 
> In the current implementation it assumes the framebuffer position
> (address) is
> not changed and passes the control to DSS (dispc.c) to rotate the
> framebuffer.
> This will work nicely for controllers (eg blizzard) which changes some
> register
> bits for rotation.
> 
> Can anybody suggest me some hints how to implement this dynamic changes??
> 
When the angle changes FB applications will update the var structure and call the fb_<api>, here you can check if the rotation angle is changed and do the necessary calls to DSS library to change the DMA settings.

By default you can configure it to -1 (means no VRFB based rotation) or if there is a bootargs parameter then use that value.

I am sorry, I was bit busy with other work was not able to reply you quickly.

You also have to look at offset computation and the contiguous memory requirement (2048 x pixel size x height x number of such buffers)

Regards,
Khasim
