From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Omap3 omap3_clk_lock_dpll5() problem
Date: Fri, 16 Jul 2010 18:27:21 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C917@dbde02.ent.ti.com>
References: <AANLkTinHudaXyhk3qc1sFydzZaGs3PZKW6DObw_acxOc@mail.gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323A2C8DE@dbde02.ent.ti.com>
 <AANLkTim9fOR4G6zpvzNApHS0uW9c5zgmFKJ7IxMC6_2W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50149 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965374Ab0GPM52 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jul 2010 08:57:28 -0400
In-Reply-To: <AANLkTim9fOR4G6zpvzNApHS0uW9c5zgmFKJ7IxMC6_2W@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arno Steffen <arno.steffen@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Thanks Anand,
> I don't have any USB working on the board.
> If this only for this USB - is it save to comment that out?
> 

If you're not using EHCI/OHCI, it ought to be safe to comment
it out.

My best guess is that you are using some non-standard frequencies
and you've made changes to the code/bootloader that cause this
path to not be able to find a good value to program in the DPLL
configuration registers.

Quite possibly, this is also the cause of your other problems.
Can you explain what you are doing so we understand the issue
better?

- Anand