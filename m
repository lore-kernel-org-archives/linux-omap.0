From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 14/18] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
Date: Wed, 9 Jan 2013 05:38:25 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDD089@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-15-git-send-email-vaibhav.bedia@ti.com>
 <50EC3964.3060708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33857 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060Ab3AIFid convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jan 2013 00:38:33 -0500
In-Reply-To: <50EC3964.3060708@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Tue, Jan 08, 2013 at 20:51:08, Shilimkar, Santosh wrote:
> On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> > Add minimal APIs for writing to the IPC and the M3_TXEV registers
> > in the Control module. These will be used in a subsequent patch which
> > adds suspend-resume support for AM33XX.
> >
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > Cc: Tony Lingren <tony@atomide.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> On Control module, we are trying to move driver/module
> specific code to respective drivers. Can you not
> add below code to ipc related driver component.
> 
> If not, then patch as such is fine with me.
> 

I had it in the pm33xx.c in the previous version. Kevin had asked me to
move it to control.c. Should I revert move it back there?

Regards,
Vaibhav
