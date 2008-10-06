From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: HEAD unbootable on 2430SDP
Date: Mon, 6 Oct 2008 16:33:43 -0700
Message-ID: <a46a26fd0810061633h788d7c96ke5eb4a1f5fe440d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:37866 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbYJFXdp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 19:33:45 -0400
Received: by an-out-0708.google.com with SMTP id d40so162545and.103
        for <linux-omap@vger.kernel.org>; Mon, 06 Oct 2008 16:33:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am running into a weird problem with the current HEAD on OMAP2430SDP.

It seems the execution goes into infinite loop in intc_bank_read_reg() function.

In the:
        while (!(intc_bank_read_reg(bank, INTC_SYSSTATUS) & 0x1))
                /* Wait for reset to complete */;

to be specific.

It seems that the address in bank->base_reg does not point to a
virtual address that is mapped to the INTC registers.

I'm using the omap_2430sdp_defconfig with CONFIG_GPIO_TWL4030 added.

Toolchain I used is: gcc version 4.2.3 (Sourcery G++ Lite 2008q1-126)

Before digging deeper I was wondering if anyone else sees this?


--
Madness takes it's toll. Please have exact change.
