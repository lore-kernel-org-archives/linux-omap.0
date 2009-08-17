From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Mon, 17 Aug 2009 19:04:55 +0100
Message-ID: <20090817180455.GW10764@n2100.arm.linux.org.uk>
References: <20090808170300.GA23481@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com> <20090813173327.GA14872@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com> <20090815153357.GF29616@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com> <20090815181711.GG29616@n2100.arm.linux.org.uk> <20090817173343.GA17323@debian> <20090817174718.GU10764@n2100.arm.linux.org.uk> <20090817180145.GA17378@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47957 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbZHQSF6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 14:05:58 -0400
Content-Disposition: inline
In-Reply-To: <20090817180145.GA17378@debian>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 17, 2009 at 11:31:45PM +0530, Rabin Vincent wrote:
> When mid == 0, the loop exits because the condition you have is :
> 
>   while ((mid = (right - left) / 2) > 0) {
>                                   ^^^^^^
> 
> Thus bank[0] will never be checked.

Ah yes, right.  Damn it.

Oh well, this will probably have to wait a couple of weeks now (by
which time I expect I will have forgotten about the problem.)
