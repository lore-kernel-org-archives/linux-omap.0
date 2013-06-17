From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 0/2] Remove unused voltagedomain data for AM33xx
Date: Mon, 17 Jun 2013 05:08:20 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83ECB9CD9@DBDE04.ent.ti.com>
References: <1371118124-15910-1-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.02.1306140243380.5514@utopia.booyaka.com>
 <8738skaj16.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41054 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab3FQFIw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 01:08:52 -0400
In-Reply-To: <8738skaj16.fsf@linaro.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, June 14, 2013 7:31 PM
> To: Paul Walmsley
> Cc: Nayak, Rajendra; Hiremath, Vaibhav; linux-omap@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 0/2] Remove unused voltagedomain data for AM33xx
> 
> Paul Walmsley <paul@pwsan.com> writes:
> 
> > cc Kevin, Vaibhav
> >
> > On Thu, 13 Jun 2013, Rajendra Nayak wrote:
> >
> >> The powerdomain framework today expects to always have a
> voltagedomain
> >> associated with a given powerdomain. We already have AM33xx which
> >> has no Voltage Controller/Voltage Processor as part of PRCM.
> >> There are more SoCs' to follow starting with AM437x and DRA7xx
> >> which do not have VC/VP.
> >>
> >> Instead of adding dummy voltage domain data files, make the
> powerdomain
> >> framework aware of the fact that some SoCs' might not really have
> >> scalable voltage domains.
> >
> > Fine with me in principle if AM335x doesn't support voltage scaling.
> > Vaibhav, if this is okay for you, please ack it.
> >
> > Then, in terms of merging, probably Kevin would be the right person
> for
> > this since he's done much of the voltagedomain work.
> 
> Yeah, I'll take this series after the minor issues I commented on are
> fixed, and Vaivhav ack's the AM33xx parts.
> 

Yeup, Feel free to add my Ack here.


Thanks,
Vaibhav 

