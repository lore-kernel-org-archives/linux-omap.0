From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 0/5] OMAP SMPS regulator driver
Date: Wed, 13 Jul 2011 12:00:37 -0700
Message-ID: <87r55uxay2.fsf@ti.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:51638 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751657Ab1GMTAn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jul 2011 15:00:43 -0400
Received: by iwn6 with SMTP id 6so5868039iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Jul 2011 12:00:42 -0700 (PDT)
In-Reply-To: <1310565638-13140-1-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Wed, 13 Jul 2011 17:00:33 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Paul Walmsley <paul@pwsan.com>

+Paul

Tero Kristo <t-kristo@ti.com> writes:

> Based on the comments for the previous version of this set, I implemented
> a regulator driver for the OMAP SMPS now. It could actually be moved under
> arch/arm/mach-omap2/ directory instead of drivers/regulator, I think it
> should work from there also. This would also require less hacking for the
> header files. Any thoughts on this?

Actually, I'd prefer it stay in drivers/regulator.  We're trying to move
driver-type stuff out of arch/arm/* into the right place in drivers/*.
In fact, I wonder if our VP/VC layers might better live under
drivers/regulator also.

I'd appreciate any input from Mark/Liam on how to organize things.

For some background, see Figures 3-75 and 3-76 in the OMAP4430 Public
TRM[1].  The SMPSs are physically on an external PMIC, but all the
control is typically done via on-chip resources: voltage processor (VP),
voltage controller (VC).  There's also an optional SmartReflex (SR)
block involved which can drive the VP.  I'm not as familiar with other
non-OMAP SoCs, but I don't imagine this is unique to OMAP.

Currently, we have separate drivers for VC, VP and SR in
arch/arm/mach-omap2.  In mainline, these are currently more like
libraries than drivers and are a bit hackish and interwoven with each
other.  We're currently separating these out into separate VC, VP and SR
layers[2], and I'm wondering exactly how we should structure this, and
where they should live under drivers/*.

What Paul and I have discussed so far is that SR should just be
implemented as a sensor under hwmod.  For VC/VP, I think it makes the
most sense that these be part of drivers/regulator someplace.  In this
series, the proposed driver is just small shell that calls the VP
functions.  

Mark/Liam, are you OK with having some "helper" libraries in
drivers/regulator?  I'm thinking specifically of our VC/VP layers (see
arch/arm/mach-omap2/vc*.c and vp*.c here in my pm-wip/voltdm branch[2].)

So far, I'm just brainstorming on how to cleanup/restructure this stuff,
so any advice from you guys would be appreciated.

Thanks,

Kevin

[1] http://focus.ti.com/pdfs/wtbu/OMAP4430_ES2.x_PUBLIC_TRM_vU.zip
[2] latest are in pm-wip/voltdm branch of my git tree
    git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
