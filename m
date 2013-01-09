From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 17/18] ARM: OMAP2+: AM33XX: Select Mailbox when PM is
 enabled
Date: Wed, 9 Jan 2013 05:38:26 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDD08F@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-18-git-send-email-vaibhav.bedia@ti.com>
 <50EC39BD.2020204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43519 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab3AIFib convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jan 2013 00:38:31 -0500
In-Reply-To: <50EC39BD.2020204@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Tue, Jan 08, 2013 at 20:52:37, Shilimkar, Santosh wrote:
> On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> > PM services on AM33XX depend on mailbox for communication
> > with WKUP-M3 core so ensure that the right config options
> > are selected. Thanks to Kevin Hilman <khilman@deeprootsystems.com>
> > for the suggestion on updating the Kconfig and not just
> > the omap2plus_defconfig which was done in the previous version
> > of the AM33XX suspend-resume support.
> >
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > Cc: Tony Lingren <tony@atomide.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> Unrelated to series. You can post this patch separately.
> 

Ok. I kept it in this series so that it does not look to be 
some random patch.

Regards,
Vaibhav
