From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v2 02/14] ARM: OMAP: counter-32k: Select the CR register
 offset using the IP scheme.
Date: Tue, 10 Jul 2012 07:25:07 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA6974A@DBDE01.ent.ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-3-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B6C.7050003@ti.com>
 <CAMQu2gz0UU_RCFSvxo1s_XwDAmTtL4NadsFTg8qL7PtGwPqKtQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA695E6@DBDE01.ent.ti.com>
 <CAMQu2gzubK7r4OEsusXBSGEW5YLWeMkt0tp8X9ERBLjse_5=MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51260 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab2GJHZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 03:25:28 -0400
In-Reply-To: <CAMQu2gzubK7r4OEsusXBSGEW5YLWeMkt0tp8X9ERBLjse_5=MA@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Sricharan" <r.sricharan@ti.com>

On Tue, Jul 10, 2012 at 12:42:46, Shilimkar, Santosh wrote:
> On Tue, Jul 10, 2012 at 12:11 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> > On Mon, Jul 09, 2012 at 16:12:15, Shilimkar, Santosh wrote:
> >> On Mon, Jul 9, 2012 at 2:20 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> >> >
> >> >
> >> > On 7/6/2012 2:51 PM, Santosh Shilimkar wrote:
> >> >> From: R Sricharan <r.sricharan@ti.com>
> >> >>
> >> >> OMAP socs has a legacy and a highlander version of the
> >> >> 32k sync counter IP. The register offsets vary between the
> >> >> highlander and the legacy scheme. So use the 'SCHEME'
> >> >> bits(30-31) of the revision register to distinguish between
> >> >
> >> >
> >> > Just for my understanding, can we get further information on SCHEME
> >> > bit-fields? What kind of information we have it here.
> >> >
> >> > I may need this info to pass on to design team here.
> >> >
> >> Sure. You can refer to the OMAP4 TRM for the bit builds.
> >> SCHEME bit field tell you difference between a highlander
> >> and legacy IP as the patch says.
> >>
> >
> > Santosh,
> >
> > Can you point to the section of OMAP4 TRM?
> >
> > I referred to both Public TRM and internal TRM, but both only did mention
> > "TI internal Data".
> >
> Last time I refereed the internal TRM version. Public TRM doesn't
> carry that information
> for some reason.
> 
> > And as per code, we are not checking any value in 31-30 bit-fields, code
> > just assumes that, non-zero value would be highlander IP.
> >
> There are only two types of IP's today and hence it will be either
> 0x0 or 0x1. So that check if just fine. The highlander IP may have
> more versions but for known OMAPs and upcoming OMAP, this is
> the only one supported version.
> 
> Some more information on the SCHEME bit field.
> -----------------
> 31:30
> SCHEME
> Used to distinguish between old scheme and current.
> 
> RO Read Only
> 
> 0x0 -  LEGACY
> 
> 0x1 - Highlander 0.8 scheme
> --------------------------------


Thanks Santosh,

This is what I was looking for, may be it is worth to put this information 
in either commit description of in code-comment.

Thanks,
Vaibhav
