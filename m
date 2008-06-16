From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] Added sleep support to UART
Date: Mon, 16 Jun 2008 11:16:08 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE3943024CEFF@vaebe110.NOE.Nokia.com>
References: <> <1213106931-17954-1-git-send-email-tero.kristo@nokia.com> <alpine.DEB.1.00.0806111712520.21166@utopia.booyaka.com> <B71CE868F2BC2847B3F23C5A8EE3943024C0F4@vaebe110.NOE.Nokia.com> <alpine.DEB.1.00.0806131830200.21863@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:31688 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756592AbYFPJI0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2008 05:08:26 -0400
Content-class: urn:content-classes:message
In-Reply-To: <alpine.DEB.1.00.0806131830200.21863@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org

>
>What race are you referring to?  Wouldn't such a race exist 
>with the current code?  (i.e., a shift should not cause any 
>further race)

Two simultaneous writes to the same register, both accessing their own
halves of it. One of the writes would potentially be lost with 32 bit
accesses. As far as I understand, Cortex + caches provides a mechanism
for accessing device addresses in 16bit format, which prevents this kind
of race condition on machine level. (Well, I must admit that my code
does not really write anything to the registers so it does not cause any
race condition, this is just something I did out of habit.)

-Tero
