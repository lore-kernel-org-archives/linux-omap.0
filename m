From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: Which git to clone for testing prior to submitting bugs?
Date: Thu, 27 Sep 2012 13:25:23 -0500
Message-ID: <CAOCHtYitbhOMv+YBaYgdTuYZQpZ_VLoP=QKVS=spmqPxEUkATA@mail.gmail.com>
References: <50648AA2.2010004@johnea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34429 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab2I0SZY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 14:25:24 -0400
Received: by vbbff1 with SMTP id ff1so2246918vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 11:25:23 -0700 (PDT)
In-Reply-To: <50648AA2.2010004@johnea.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@johnea.net
Cc: linux-omap@vger.kernel.org

On Thu, Sep 27, 2012 at 12:19 PM,  <linux@johnea.net> wrote:
>
> Hello,
>
> We're developing a system based on DM3730, and using Beagleboard-xM as a
> prototype platform.
>
> The 3.2 series kernels provided a working video output on Beagleboard-xM
> integrated HDMI connector.
>
> We use the kernel parameters: omapfb.mode=dvi:800x480MR-24@60
> omapfb.vram=0:6M,1:2M,2:2M omapdss.def_disp=dvi
>
> We upgraded to kernel 3.4.3 in order to take advantage of the kernel
> parameter: buddy=spidev
>
> This provided spidev access without requiring that we build a custom kernel.
>
> However in the 3.4 series, dvi output no longer works.
>
> In a subsequent distro upgrade to 3.4.4 neither dvi, nor buddy=spidev
> function anymore.

"buddy=xyz" is not upstream, so which 'tree'/'patchset' are you
currently using as a basis for your device?  The authors of that
patchset might be able to help out..

> I'd like to test the latest appropriate kernel prior to considering these
> issues as current bugs.
>
> Can someone please advise which git tree to clone, for testing and possible
> bisect, prior to reporting bugs to this list?

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
