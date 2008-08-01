From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] Volume Down key on the Zoom MDK
Date: Fri, 1 Aug 2008 12:58:23 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608701C2BF9A14@dbde02.ent.ti.com>
References: <18567.41720.48693.458775@gargle.gargle.HOWL>
	<FCCFB4CDC6E5564B9182F639FC35608701C29872CD@dbde02.ent.ti.com>
 <18577.63193.946879.783279@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58247 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbYHAH2c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Aug 2008 03:28:32 -0400
In-Reply-To: <18577.63193.946879.783279@gargle.gargle.HOWL>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: George Jahad <george.jahad@windriver.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: George Jahad [mailto:george.jahad@windriver.com]
> Sent: Thursday, July 31, 2008 11:01 PM
> To: Pandita, Vikram
> Cc: George Jahad; linux-omap@vger.kernel.org
> Subject: RE: [PATCH] Volume Down key on the Zoom MDK
>
>  Sorry I didn't make that clear.
>
>  This is against the TI bsp found here:
>  http://omapzoom.org/gf/project/omapkernel/frs/
>

Hi
Let me give some brief background on the code organization on omapzoom.org

On omapzoom.org, TI maintains two kernel versions:

(1) A stable, older-kernel (2.6.24), functionality complete v1.4 tarball at: http://omapzoom.org/gf/project/omapkernel/frs/
The intention is to showcase what TI has internally developed on all OMAP3 features,
but the kernel version may not be latest.

(2) A TI-GIT tree:
An up-to-date 2.6.26 kernel in sync with linux-omap git
This can be got by git clone -
git clone http://git.omapzoom.org/repo/omapkernel

+ The intention of this ti-git tree is to port stable kernel features of (1) to the latest kernel.

+ For some features there are deviations from linux-omap git Eg: PM and
there are some advanced features that will be submitted to linux-omap git subsequently Eg: DSP bridge

+ The intention is to make available to community what TI has developed internally

+ To get comments/review from community on TI design/implementation

+ To get comments on deviation areas like PM

Refer wiki for more details: http://omapzoom.org/gf/project/omapkernel/wiki/

Hope this clarifies things.
Vikram


>  When I forwarded the patch to my contact at TI, he suggested I also post it here.
>
>  Thanks,
>  George
>
>  On Tuesday, July 29, 2008 03:44
>  Pandita, Vikram wrote:
>   > Hi Jahad
>   > What is the code base over which you are trying to make the keypad change?
>   >
>   > > -----Original Message-----
>   > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> George
>   > > Jahad
>   > > Sent: Wednesday, July 23, 2008 4:31 PM
>   > > To: linux-omap@vger.kernel.org
>   > > Cc: George J.
>   > > Subject: [PATCH] Volume Down key on the Zoom MDK
>   > >
>   > >
>   > >   Here is a patch to fix the omap-twl4030keypad.c keypad driver to support the volume down key
> on the
>   > > Zoom MDK/Labrador.
>   > >
>   > >
>   > >   George Jahad
>   > >   Wind River Systems
>   >
>   >

