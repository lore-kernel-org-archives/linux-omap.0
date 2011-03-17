From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Thu, 17 Mar 2011 16:41:27 +0530
Message-ID: <1300360287.1909.62.camel@lappyti>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>
	 <1299827578.2567.1.camel@deskari> <4D79E0A0.9040900@openelec.tv>
	 <1299849774.2479.3.camel@deskari> <4D7A4B44.2030801@openelec.tv>
	 <1299868049.2479.33.camel@deskari> <4D7A6D0F.40906@openelec.tv>
	 <AANLkTin+fnZfFte5v8+G0saDcjCqsT=oQ4U_oGSm-UGn@mail.gmail.com>
	 <4D7CD588.3080100@openelec.tv> <4D7CEEC8.50803@openelec.tv>
	 <1300258302.1917.32.camel@lappyti>
	 <AANLkTinNynOpnJyHZeyA01E5oVMcs_PnAYRH4dSznJ_d@mail.gmail.com>
	 <4D814C72.9010300@openelec.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55945 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab1CQLLj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Mar 2011 07:11:39 -0400
In-Reply-To: <4D814C72.9010300@openelec.tv>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephan Raue <mailinglists@openelec.tv>
Cc: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 2011-03-16 at 18:49 -0500, Stephan Raue wrote:

> i tried this test tree with omap2plus_defconfig.
> 
> it seems the kernel crashes and poweroff the board on loading this hdmi 
> stuff, but dont print any crashlog. is there a way any backtraces will 
> be printed?
> output from serial console: http://paste.pocoo.org/show/354850/
> kernel config (omap2plus_defconfig, added squashfs support, added 
> support to include initramfs in kernel, build omapfb stuff statically 
> into the kernel): http://paste.pocoo.org/show/354853/

Have the HDMI on your setup worked in any (prebuilt) image? What I'm
asking is if you are sure the HDMI HW works on your board?

Powering off quietly sounds strange. Is your power supply sufficient?
Well, I don't think that would explain the first crash you posted...

 Tomi


