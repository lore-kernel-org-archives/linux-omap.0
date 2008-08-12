From: David Brownell <david-b@pacbell.net>
Subject: Re: USB-webcam support
Date: Tue, 12 Aug 2008 15:49:43 -0700
Message-ID: <20080812224943.5C56D3631A4@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <c656a4d20808120332v224c5053r7225c086acd8c2cd@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0256A366A2@dbde02.ent.ti.com>
 <E78C46F1-DB17-4BE0-A310-D1F5072B26B8@student.utwente.nl>
 <20080812223844.48AB1362B0F@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:24627 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751928AbYHLWoE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Aug 2008 18:44:04 -0400
In-Reply-To: <20080812223844.48AB1362B0F@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: k.kooi@student.utwente.nl, gadiyar@ti.com, arunedarath@mistralsolutions.com
Cc: linux-omap@vger.kernel.org

> > >> If I have a USB camera with good Linux support, can I connect it
> > >> to omap3evm(or any omap2) and make it functional?
>
> I'm told some folk have used ISO transfer support, but when I last did
> much work with the musb code, none of it was tested.

Oh, one more point:  it should work pretty well with EHCI.  There
are some glitches with the periodic scheduling (it's really messy
even before you start thinking about how to code it), but folk have
successfully used it with a variety of hardware.

So if you can use EHCI on your EVM, that should be solvable.

