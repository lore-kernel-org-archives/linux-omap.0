From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 1/9] ARM: OMAP2+: AM33XX: CM: Get rid of unncessary
 header inclusions
Date: Mon, 21 Jan 2013 05:27:16 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECF09DB@DBDE01.ent.ti.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
 <1358493569-17142-2-git-send-email-vaibhav.bedia@ti.com>
 <50F94085.3030704@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43027 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab3AUF1d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 00:27:33 -0500
In-Reply-To: <50F94085.3030704@mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 18, 2013 at 18:01:01, Sergei Shtylyov wrote:
> On 18-01-2013 11:19, Vaibhav Bedia wrote:
> 
> > Some of the included header files are not needed so
> > remove them.
> 
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> > Change from RFC version:
> > 	No change
> 
> >   arch/arm/mach-omap2/cm33xx.h |    7 +------
> >   1 files changed, 1 insertions(+), 6 deletions(-)
> 
> > diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
> > index 5fa0b62..8009e13 100644
> > --- a/arch/arm/mach-omap2/cm33xx.h
> > +++ b/arch/arm/mach-omap2/cm33xx.h
> > @@ -17,16 +17,11 @@
> >   #ifndef __ARCH_ARM_MACH_OMAP2_CM_33XX_H
> >   #define __ARCH_ARM_MACH_OMAP2_CM_33XX_H
> >
> > -#include <linux/delay.h>
> > -#include <linux/errno.h>
> > -#include <linux/err.h>
> > -#include <linux/io.h>
> > -
> >   #include "common.h"
> >
> >   #include "cm.h"
> >   #include "cm-regbits-33xx.h"
> > -#include "cm33xx.h"
> > +#include "iomap.h"
> 
>     You don't comment on this addition in the changelog...

Hmm... ok. Will clarify this in the changelog for v2.

Regards,
Vaibhav
