From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Fri, 15 Jun 2012 10:33:53 -0500
Message-ID: <4FDB55E1.6060207@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com> <4FD64D6D.3020401@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com> <4FD77EF1.8000600@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com> <4FD8A906.8080202@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9994A6@DBDE01.ent.ti.com> <4FDA4EE6.1070106@ti.com> <alpine.DEB.2.00.1206141819130.25628@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59457 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932138Ab2FOPd6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jun 2012 11:33:58 -0400
In-Reply-To: <alpine.DEB.2.00.1206141819130.25628@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On 06/14/2012 07:20 PM, Paul Walmsley wrote:
> On Thu, 14 Jun 2012, Jon Hunter wrote:
> 
>> What does make this a bit more difficult is the function
>> gpmc_round_ns_to_ticks(). It appears to convert nanoseconds to ticks and
>> back to nanoseconds. I am guessing to account for some rounding error. I
>> am curious what impact this function is having on the timing. Ideally
>> this should be handle in gpmc_cs_set_timings().
> 
> I don't have the code in front of me at the moment, nor my old GPMC timing 
> spreadsheet, so this comment may be superfluous.  But since kernel 
> arithmetic needs to be in integers, it might be necessary to do some of 
> the timing calculations in picosecond units to avoid roundoff issues.

A lot of the GPMC timing functions are converting to pico-seconds and
then rounding up to nano-seconds. So I think that the calculations are ok.

The real problem is, that as Afzal has highlighted, is that there is no
common method between GPMC peripherals (onenand, smsc, etc) for
populating the gpmc timings structure. This is going to cause a bit of a
headache for migrating them over to DT. So what we need to do and maybe
this is another series, separate from Afzal's series, is really clean-up
the populating of the timings.

Cheers
Jon
