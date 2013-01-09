From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 07/18] ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod
 with the right flags
Date: Wed, 9 Jan 2013 06:02:40 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDD132@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-8-git-send-email-vaibhav.bedia@ti.com>
 <50EC35C3.4020701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34778 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab3AIGCv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jan 2013 01:02:51 -0500
In-Reply-To: <50EC35C3.4020701@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Tue, Jan 08, 2013 at 20:35:39, Shilimkar, Santosh wrote:
> On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> > TPTC0 needs to be idled and put to standby under SW control.
> > Add the appropriate flags in the TPTC0 hwmod entry.
> >
> Can you please expand TPTC0 in chane log.

Third Party Transfer Controller. It's part of the DMA IP.
Will add it in the changelog.

> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> Patch is fine otherwise.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> 

