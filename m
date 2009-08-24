From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/5] ARM: OMAP2/3/4: Split OMAP2_IO_ADDRESS to L3 and L4
Date: Mon, 24 Aug 2009 11:43:23 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA434AEC@dbde02.ent.ti.com>
References: <1251034495-10107-1-git-send-email-santosh.shilimkar@ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F996E313@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA29C290@dbde02.ent.ti.com>
 <002c01ca2481$82c30340$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39471 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbZHXGN3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 02:13:29 -0400
In-Reply-To: <002c01ca2481$82c30340$LocalHost@wipultra793>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "V, Hemanth" <hemanthv@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: V, Hemanth
> Sent: Monday, August 24, 2009 11:40 AM
> To: Shilimkar, Santosh; Pandita, Vikram; tony@atomide.com;
> khilman@deeprootsystems.com
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/5] ARM: OMAP2/3/4: Split OMAP2_IO_ADDRESS to L3 and
> L4
> 
> ----- Original Message -----
> From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
> >> ---
> >> #define L3_IO_OFFSET 0x90000000
> >> #define __L3_IO_ADDRESS(pa) ((pa) + L3_IO_OFFSET)/* Works for L3 */
> >> #define __OMAP2_L3_IO_ADDRESS(pa) ((pa) + L3_IO_OFFSET)/* Works for L3
> >> */
> >> #define l3_io_v2p(va) ((va) - L3_IO_OFFSET)/* Works for L3 */
> >>
> >> #define IO_OFFSET 0xb2000000
> >> #define __IO_ADDRESS(pa) ((pa) + IO_OFFSET)/* Works for L4  */
> >> #define __OMAP2_IO_ADDRESS(pa) ((pa) + IO_OFFSET)/* Works for L4 */
> >> #define io_v2p(va) ((va) - IO_OFFSET)/* Works for L4*/
> >> ---
> >>
> >> This way you don't have to introduce new L4 macro at all => much lesser
> >> code impact.
> > Initially I thought about this but later preferred to split it. The only
> > change what you are suggesting is instead of calling
> > "OMAP2_L4_IO_ADDRESS", we keep >that as "OMAP2_IO_ADDRESS". But the idea
> > was to differentiate between various IO accesses because at some point
> of
> > time all these has to be removed in
> > favor of ioremap() + read*()/write*() one by one and that time this
> would
> > be beneficial.
> 
> Does that mean all drivers, including the ones in other trees like camera,
> dss etc need to be modified if they are using IO_ADDRESS macros. The idea
> of
> having a macro as below was to reduce this impact.
Going forward yes.  Refer the mailing thread comments from Tony/Kevin/Richard on below thread.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg14015.html


Regards,
Santosh
