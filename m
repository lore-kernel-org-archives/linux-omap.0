From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Early prints on different UART's for same machine type
Date: Wed, 10 Aug 2011 00:37:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108100034510.12674@utopia.booyaka.com>
References: <mailman.7147.1312868034.20023.linux-arm-kernel@lists.infradead.org> <B85A65D85D7EB246BE421B3FB0FBB593024DF9E2C1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44792 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab1HJGh0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 02:37:26 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DF9E2C1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-arm-kernel-bounces@lists.infradead.org" <linux-arm-kernel-bounces@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>

Hi

On Tue, 9 Aug 2011, Mohammed, Afzal wrote:

> This is regarding board with multiple variations using an upcoming SoC from TI.
> Variation of the board is detected by reading EEPROM using I2C after
> init_machine gets invoked. In one of the variation UART# used is different.
> Because of this decompressor logs (and early prints) can't be captured for the
> board variant using this different UART#. Our solution for this problem is to
> use different mach-id for the board using different UART#. But this solution
> seems to be overkill as only to capture decompressor logs, we have to use
> a new machine id.
> 
> As I2C will not work at the decompressor stage, I2C can't be used to detect
> the board type.
> 
> As far as I know, ATAG is not parsed in decompressor stage and so ATAG cannot
> be used to determine board variant or UART#. Otherwise we will have to add
> capability in decompressor to parse ATAG, detect console to be used, and
> modify uncompress.h to select proper console for capturing decompressor logs.
> This seems a bad solution.
> 
> Our bootloader has the capability to detect the board variant.
> 
> So the best solution for us so far seems to add a new machine id, if any
> better solutions are possible, please let us know.

You might get more feedback if you E-mail 
<linux-arm-kernel@lists.infradead.org>, rather than 
<linux-arm-kernel-bounces@lists.infradead.org>.


- Paul
