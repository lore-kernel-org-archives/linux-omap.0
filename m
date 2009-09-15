From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Tue, 15 Sep 2009 17:17:40 +0100
Message-ID: <20090915161740.GA19336@n2100.arm.linux.org.uk>
References: <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com> <20090815181711.GG29616@n2100.arm.linux.org.uk> <20090817173343.GA17323@debian> <20090817174718.GU10764@n2100.arm.linux.org.uk> <20090817180145.GA17378@debian> <20090817180455.GW10764@n2100.arm.linux.org.uk> <A24693684029E5489D1D202277BE89444A8201BE@dlee02.ent.ti.com> <20090818030148.GA2283@debian> <20090907142210.GB23361@n2100.arm.linux.org.uk> <20090915113256.GB1328@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40182 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbZIOQSn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Sep 2009 12:18:43 -0400
Content-Disposition: inline
In-Reply-To: <20090915113256.GB1328@ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rabin Vincent <rabin@rab.in>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Sep 15, 2009 at 01:32:56PM +0200, Pavel Machek wrote:
> I believe you can just return cmp here.

Maybe... unfortunately this comment is after Linus has merged the patch.
Might as well leave it as is since we know it works.
