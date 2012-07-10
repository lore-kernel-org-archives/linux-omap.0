From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v2 02/14] ARM: OMAP: counter-32k: Select the CR register
 offset using the IP scheme.
Date: Tue, 10 Jul 2012 06:41:24 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA695E6@DBDE01.ent.ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-3-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B6C.7050003@ti.com>
 <CAMQu2gz0UU_RCFSvxo1s_XwDAmTtL4NadsFTg8qL7PtGwPqKtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37107 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240Ab2GJGrS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 02:47:18 -0400
In-Reply-To: <CAMQu2gz0UU_RCFSvxo1s_XwDAmTtL4NadsFTg8qL7PtGwPqKtQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Sricharan" <r.sricharan@ti.com>

On Mon, Jul 09, 2012 at 16:12:15, Shilimkar, Santosh wrote:
> On Mon, Jul 9, 2012 at 2:20 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> >
> >
> > On 7/6/2012 2:51 PM, Santosh Shilimkar wrote:
> >> From: R Sricharan <r.sricharan@ti.com>
> >>
> >> OMAP socs has a legacy and a highlander version of the
> >> 32k sync counter IP. The register offsets vary between the
> >> highlander and the legacy scheme. So use the 'SCHEME'
> >> bits(30-31) of the revision register to distinguish between
> >
> >
> > Just for my understanding, can we get further information on SCHEME
> > bit-fields? What kind of information we have it here.
> >
> > I may need this info to pass on to design team here.
> >
> Sure. You can refer to the OMAP4 TRM for the bit builds.
> SCHEME bit field tell you difference between a highlander
> and legacy IP as the patch says.
> 

Santosh,

Can you point to the section of OMAP4 TRM? 

I referred to both Public TRM and internal TRM, but both only did mention
"TI internal Data".

And as per code, we are not checking any value in 31-30 bit-fields, code 
just assumes that, non-zero value would be highlander IP. 

Thanks,
Vaibhav

