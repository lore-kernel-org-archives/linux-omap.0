From: "Fillinger, Michael" <m-fillinger@ti.com>
Subject: 2420 sDMA address mapping typo
Date: Tue, 15 Mar 2011 17:44:02 +0100
Message-ID: <E8606C3FD412994585953171ED63A9340217F287D9@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55902 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932332Ab1COQnx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 12:43:53 -0400
Content-Class: urn:content-classes:message
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Balbi, Felipe" <balbi@ti.com>, "tony@atomide.com" <tony@atomide.com>

Hi,

There is a small issue introduced in 2.6.38 on the address space of sDMA for OMAP2420, which seems to be a mix of OMAP2 & newer OMAP addresses :

arch/arm/mach-omap2/omap_hwmod_2420_data.c

static struct omap_hwmod_addr_space omap2420_dma_system_addrs[] = {
        {
                 .pa_start   = 0x48056000,
                 .pa_end     = 0x4a0560ff,
                 .flags      = ADDR_TYPE_RT
        },
};

pa_end should be 0x480560ff unless I'm mistaken.

Regards,

Michael

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



