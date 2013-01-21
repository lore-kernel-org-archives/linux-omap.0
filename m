From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 0/9] ARM: OMAP2+: AM33XX: Misc fixes/updates
Date: Mon, 21 Jan 2013 05:27:16 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECF09E0@DBDE01.ent.ti.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46531 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab3AUF1c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 00:27:32 -0500
In-Reply-To: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi Paul, Benoit,

On Fri, Jan 18, 2013 at 12:49:20, Bedia, Vaibhav wrote:
> Hi,
> 
> The following patches were earlier posted as part the AM33XX
> suspend-resume support series [1]. Based on the suggestion
> from Santosh Shilimkar <santosh.shilimkar@ti.com> i have split
> out the changes which update the various data files related
> to AM33XX support.
> 
> These patches apply on top of v3.8-rc3
> 
> Regards,
> Vaibhav
> 
> [1] http://marc.info/?l=linux-arm-kernel&m=135698501821074&w=2
> 
> Vaibhav Bedia (9):
>   ARM: OMAP2+: AM33XX: CM: Get rid of unncessary header inclusions
>   ARM: OMAP2+: AM33XX: CM/PRM: Use __ASSEMBLER__ macros in header files
>   ARM: OMAP2+: AM33XX: hwmod: Register OCMC RAM hwmod
>   ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with the right flags
>   ARM: OMAP2+: AM33XX: hwmod: Fixup cpgmac0 hwmod entry
>   ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3 hwmod with reset
>     status bit
>   ARM: OMAP2+: AM33XX: Update the hardreset API
>   ARM: DTS: AM33XX: Add nodes for OCMC RAM and WKUP-M3
>   ARM: OMAP2+: AM33XX: control: Add some control module registers and
>     APIs
> 

Any comments on these before I resend addressing the comments from Sergei?

Regards,
Vaibhav
