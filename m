From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 08/15] ARM: OMAP2+: hwmod: Fix the omap_hwmod_addr_space
 for CPGMAC0
Date: Sun, 4 Nov 2012 15:26:16 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFFD33@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-9-git-send-email-vaibhav.bedia@ti.com>
 <509543E8.60209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43173 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356Ab2KDP0W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Nov 2012 10:26:22 -0500
In-Reply-To: <509543E8.60209@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Sat, Nov 03, 2012 at 21:48:48, Shilimkar, Santosh wrote:
> On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> > The first entry for CPGMAC0 should be ADDR_MAP_ON_INIT
> > instead of ADDR_TYPE_RT to ensure the omap hwmod code
> > maps the memory space at init and writes to the SYSCONFIG
> > registers.
> >
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > ---
> Sorry again similar question.
> 
> Why CPGMAC0 should be mapped and sysconfig updated early ?
> 

Hmm I need to revisit this one. CPGMAC0 was not going to standby
without this. Maybe something else is wrong in the hwmod data and
needs fixing.

Regards,
Vaibhav
