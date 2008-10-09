From: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>
Subject: RE: omapfb: help from userspace
Date: Thu, 9 Oct 2008 11:50:26 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B0108CAB@dbde02.ent.ti.com>
References: <e5e6ade50810081136n2067600csf3c77195da0ef110@mail.gmail.com>
 <e5e6ade50810081321h6f638cafjbe00f4c8a3a50f2c@mail.gmail.com>
 <13B9B4C6EF24D648824FF11BE89671620365B58844@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36782 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890AbYJIGUh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 02:20:37 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620365B58844@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Nathan Monson <nmonson@gmail.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

>The need for this has been discussed on this list a few times in the past.  >Not having it is a bug to me for OMAP3.
>
>There shouldn't really be any performance side effects the way it is being >used.

I agree, I did not notice any performance impact - we are using this setting for couple of months now without any problem. But there are some future compatibility concerns in below thread - it should be fine for OMAP3 though 

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg02949.html

> Let's go back to having a strongly ordered memory model.  Please.

On pre-ARMv6, updates to CPSR are guaranteed to take place in program
order with a strongly-ordered memory access. This is still true on
ARMv6/v7 for backward compatibility but the feature is deprecated and it
might not be true for future architecture versions. At some point
barriers might be needed.

Regards,
Pratheesh
