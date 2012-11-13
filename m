From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 13 Nov 2012 15:57:54 +0000
Message-ID: <50A26E02.9080702@mimc.co.uk>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com> <508FB226.20604@mimc.co.uk> <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com> <508FE8BA.1080404@ti.com> <50912A6F.1040501@mimc.co.uk> <79CD15C6BA57404B839C016229A409A83EB563F8@DBDE01.ent.ti.com> <5097EF44.5030706@mimc.co.uk> <79CD15C6BA57404B839C016229A409A83EB63609@DBDE01.ent.ti.com> <5098DC9E.3090307@mimc.co.uk> <50A266C2.4030303@mimc.co.uk> <alpine.DEB.2.00.1211131531430.22487@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:58376 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752812Ab2KMP54 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 10:57:56 -0500
In-Reply-To: <alpine.DEB.2.00.1211131531430.22487@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 13/11/12 15:35, Paul Walmsley wrote:
> 
> instead of this:
> 
>>> $ cat arch/arm/boot/uImage arch/arm/boot/am335x-bone.dtb > arch/arm/boot/uImage-dtb.am335x-bone
>>> $ cp arch/arm/boot/uImage-dtb.am335x-bone /media/boot/uImage
> 
> something like this is what you need to do instead:
> 
> $ cat arch/arm/boot/zImage arch/arm/boot/am335x-bone.dtb > arch/arm/boot/zImage-dtb.am335x-bone
> $ scripts/mkuboot.sh -A arm -O linux -C none  -T kernel -a 0x80008000 -e 0x80008000 -n 'Linux' -d arch/arm/boot/zImage-dtb.am335x-bone arch/arm/boot/uImage-dtb.am335x-bone

Works like a charm ... thanks.

Mark J.

