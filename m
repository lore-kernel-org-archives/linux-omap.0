From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
Date: Tue, 22 Apr 2008 14:48:33 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com>
References: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57058 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755042AbYDVJUP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 05:20:15 -0400
Content-class: urn:content-classes:message
In-Reply-To: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Koen Kooi
> Sent: Tuesday, April 22, 2008 1:28 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
> 
> In case of broken-mailer-white-space-damage:
> http://amethyst.openembedded.net/~koen/beagleboard/0001-omap3beagle-
> register-SD-interface.patch
> 
>  From a4127c880913185919f065800535c8d90751ac3c Mon Sep 17 00:00:00 2001
> From: Koen Kooi <koen@openembedded.org>
> Date: Tue, 22 Apr 2008 09:45:45 +0200
> Subject: [PATCH] omap3beagle: register SD interface
> 
> Signed-off-by: Koen Kooi <koen@openembedded.org>
> - ---
> arch/arm/mach-omap2/Makefile            |    3 ++-
> arch/arm/mach-omap2/board-omap3beagle.c |   11 +++++++++++


> arch/arm/mach-omap2/board-omap3beagle.h |   12 ++++++++++++

Why new header file ? We can use the existing include/asm-arm/arch-omap/board-omap3beagle.h

Regards,
Khasim
