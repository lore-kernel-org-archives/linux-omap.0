From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: HEAD unbootable on 2430SDP
Date: Mon, 6 Oct 2008 18:46:35 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620365AE0E8F@dlee02.ent.ti.com>
References: <a46a26fd0810061633h788d7c96ke5eb4a1f5fe440d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50291 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbYJFXqn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 19:46:43 -0400
In-Reply-To: <a46a26fd0810061633h788d7c96ke5eb4a1f5fe440d4@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> I am running into a weird problem with the current HEAD on OMAP2430SDP.
>
> It seems the execution goes into infinite loop in intc_bank_read_reg()
> function.
>
> In the:
>         while (!(intc_bank_read_reg(bank, INTC_SYSSTATUS) & 0x1))
>                 /* Wait for reset to complete */;

Did your board boot loader setup the peripheral port remap register?

If not you must make sure the INTC is mapped to non-shared-device mapping else you won't be seeing the INTC registers properly.

Using the remap register works, but if you inspect TLBs you'll see it uses all 4k'ers instead of a single 1M section entry for L4 range.  This will cut performance some.

In a local hack a while back we had used some reserved L4 space to provide a separate mapping for the INTC with non-shared-device mapping.  If you do this you can shut down the remap register.

Probably most people are not appreciating benefit of that setup.

Regards,
Richard W.

