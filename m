From: =?windows-1252?Q?Peter_K=FCmmel?= <syntheticpp@gmx.net>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Tue, 06 Jan 2015 12:25:12 +0100
Message-ID: <54ABC618.8070906@gmx.net>
References: <54A58E23.5080103@gmx.net> <20150101182053.GG582@fuloong-minipc.musicnaut.iki.fi> <20150102161911.GA3298@atomide.com> <54A6E408.1090908@gmx.net> <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi> <20150102204018.GF3298@atomide.com> <20150102223451.GL582@fuloong-minipc.musicnaut.iki.fi> <20150103000220.GE3279@atomide.com> <20150103121622.GN582@fuloong-minipc.musicnaut.iki.fi> <20150105154313.GA19336@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:51102 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754911AbbAFL0A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jan 2015 06:26:00 -0500
In-Reply-To: <20150105154313.GA19336@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Russell King <rmk+kernel@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>



Am 05.01.2015 um 16:43 schrieb Felipe Balbi:

>
> Just booted AM335x with CONFIG_PREEMPT and haven't seen any problem.
> Perhaps this is something related to another OMAP3-only driver ? Perhaps
> HSI/SSI ?
>
> cheers
>

I see a ssi error directly before the IN-Band error:

[    0.339935] platform 48058000.ssi-controller: Cannot lookup hwmod 'ssi'
[    0.346893] In-band Error seen by MPU  at address 0
[    0.346923] ------------[ cut here ]------------

Peter
