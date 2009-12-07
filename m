From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 and power supplies
Date: Mon, 07 Dec 2009 10:44:42 +0200
Message-ID: <1260175482.2342.49.camel@tubuntu.research.nokia.com>
References: <6ed0b2680912040253m3b25950fuf49e6ec75ad13067@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54477 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933580AbZLGIox (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 03:44:53 -0500
In-Reply-To: <6ed0b2680912040253m3b25950fuf49e6ec75ad13067@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, 2009-12-04 at 11:53 +0100, ext Grazvydas Ignotas wrote:
> hi,
> 
> it seems DSS block in OMAP needs SDI/DSI supplies to operate properly
> even with parallel displays, or else it doesn't drive some data lines
> resulting in missing/wrong colors. Take a look at figure 15-1 on OMAP3
> TRM (page 2119 on spruf98d), some dss_data lines are going out of
> SDI/DSI blocks, which are fed by vdds_sdi and vdds_dsi supplies
> (vdss_sdi in fig 15-1 seems to be a typo). Those 2 are typically
> connected to VPLL2 on TWL4030/TPS65950 (see fig. 25-2 on p3482), so
> that regulator needs to be activated for proper operation (if you have
> a parallel display and a board with TWL4030 you can reproduce this by
> not enabling VPLL2 in bootloader and kernel; mainline u-boot enables
> it).

Hmm, this would explain the color errors. Have you seen this on some
other board than TI's SDP?

To me the fig 15-1 does not tell that the powers are needed. The
DSS_DATA[] pins do not come from SDI/DSI blocks, but from the main DSS
block. And the pin muxing component is outside also. This of course
doesn't really prove anything. =)

> Right now DSS2 requests vdds_dsi in DSI driver only, any plans to
> request vdds_dsi/vdds_sdi for parallel displays too?

I didn't have any plans, but if what you said is true, it sure needs to
be added.

 Tomi

Ps. Adding l-o, as others may be interested also.


