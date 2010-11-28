From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [Query]McSPI testing help on N800
Date: Sun, 28 Nov 2010 13:15:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011281313010.2515@utopia.booyaka.com>
References: <1290524213-395-1-git-send-email-charu@ti.com> <1290524213-395-2-git-send-email-charu@ti.com> <20101126043829.GB6598@lixom.net> <AANLkTi=9RpAw4gi92M_7JLkS+VHPUp_YPdwRRin0u8Jx@mail.gmail.com>
 <0680EC522D0CC943BC586913CF3768C004137FE3F8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53135 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab0K1UPX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Nov 2010 15:15:23 -0500
In-Reply-To: <0680EC522D0CC943BC586913CF3768C004137FE3F8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 26 Nov 2010, Datta, Shubhrajyoti wrote:

> We were wondering how to test McSPI on N800.
> Is there any peripheral connected to McSPI?

These devices are configured in the board file for the 
device, which is arch/arm/mach-omap2/board-n8x0.c


- Paul
