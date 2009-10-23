From: "Imberton Guilhem-gimb01" <guilhem.imberton@motorola.com>
Subject: RE: [PATCH 2/2 v2] OMAP3:PM:SR: SmartReflex Refactor Rev3.0
Date: Fri, 23 Oct 2009 11:12:58 +0100
Message-ID: <6A943D54E5EAED4BA437305D3EF62FB30326E9DC@zuk35exm61.ds.mot.com>
References: <1256232481-30636-1-git-send-email-nm@ti.com> <1256232481-30636-2-git-send-email-nm@ti.com> <1256232481-30636-3-git-send-email-nm@ti.com> <6A943D54E5EAED4BA437305D3EF62FB30326E922@zuk35exm61.ds.mot.com> <4AE1178E.5060302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail128.messagelabs.com ([216.82.250.131]:48798 "EHLO
	mail128.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbZJWKNT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 06:13:19 -0400
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id n9NADM2Y028058
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 03:13:22 -0700 (MST)
Received: from il06vts02.mot.com (il06vts02.mot.com [129.188.137.142])
	by il06exr04.mot.com (8.13.1/Vontu) with SMTP id n9NADMSu009595
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 05:13:22 -0500 (CDT)
Received: from zuk35exm61.ds.mot.com (zuk35exm61.ea.mot.com [10.178.4.19])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id n9NADLOn009592
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 05:13:22 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <4AE1178E.5060302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Reddy, Teerth" <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, =?iso-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, Mike Chan <mikechan@google.com>

 

> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com] 
> Sent: Friday, October 23, 2009 4:40 AM
> Imberton Guilhem-gimb01 had written, on 10/22/2009 04:04 PM, 
> the following:
> >  I have one small comment on the actual implementation
> >> +     do {
> >> +             value = prm_read_mod_reg(OMAP3430_GR_MOD,
> >> +                                      
> OMAP3_PRM_VC_BYPASS_VAL_OFFSET)
> >> +                 & OMAP3430_VALID;
> >> +             /* should i wait? */
> >> +             if (value && (count % 50))
> >> +                     udelay(10);
> >> +             count--;
> >> +             *timeout_us -= 5;
> >> +     } while (value && count);
> > 
> > Why are you removing 5us every read ?
> Thanks for catching this. Yep, I have got my counters mixed 
> up :(.. will 
> add it as part of v2 for tomorrow evening with other 
> potential comments 
> if any.
> 
> > If 50 iteration is 1us and we delay every loop by 10us we 
> should remove 11us
> > 
> > Shouldn't it be:
> > 
> > +       do {
> > +               value = prm_read_mod_reg(OMAP3430_GR_MOD,
> > +                                        
> OMAP3_PRM_VC_BYPASS_VAL_OFFSET)
> > +                   & OMAP3430_VALID;
> > +               /* should i wait? */
> > +               if (value && (count % 50)) {
> > +                       udelay(10);
> > +                     *timeout_us -= 11;
> > +           }
> > +               count--;
> > +       } while (value && count);
> > 
> here is a problem with the above logic:
> a) I dont know for sure if 50 iterations == 1 uSec.
> b) count = timeout*5
>    ==> if function is called with timeout = 10 uSec, count = 50, and 
> udelay(10) will be called once. now *timeout -=11 will make it a 
> negative value, which is not helpeful.
> 
> so, the decrement has to be by 10 OR i can pad timeout_us .. 
> not exactly 
> useful either..

Your right negative value wont be good
Let's use 10uSec (50 registers reading remains realy small amount of time)
And it will anyway give us a good idea of the time spent here

> -- 
> Regards,
> Nishanth Menon
>

Regards,

Guilhem 
