From: Palachanda JayaPrakash Uthappa <uthappa@mistralsolutions.com>
Subject: Activity on ARM (OMAP5912) boosting u-wire TX DMA???
Date: Fri, 12 Nov 2010 16:28:34 -0800
Message-ID: <AANLkTi=w_H-6W-yON0ZKYj4VemW9vHF-7LeC+vDKtSA4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49115 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab0KMA2f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Nov 2010 19:28:35 -0500
Received: by iwn10 with SMTP id 10so4085489iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Nov 2010 16:28:34 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hello Everyone,

    I am facing a peculiar problem. I am working on the u-wire
interface of OMAP5912. The kernel I am using is pretty old (linux
2.6.16). But it works pretty well for OMAP5912. The u-wire interface
on OMAP5912 supports TX via DMA (RX via DMA is not available). If I
perform the DMA transfer for TX, it works, but very slowly. However,
instead of stopping at a wait_for_completion() for the DMA callback
(complete()) to happen (the usual approach) if I keep the ARM busy
with some kind of register access (not necessarily a u-wire register),
the DMA transfer happens real fast.

    Has anyone faced this kind of issue before (not necessarily u-wire
interface). Please share your experience. I am looking for clues.

Best regards,
Uthappa
