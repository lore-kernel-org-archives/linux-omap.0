From: "Lesly Arackal Manuel" <leslyam@ti.com>
Subject: RE: [PATCH v5 3/5] omap3: pm: Generic TRITON power scripts forOMAP3 based boards
Date: Thu, 13 May 2010 16:22:14 +0530
Message-ID: <015501caf28a$5a984e20$ba8818ac@apr.dhcp.ti.com>
References: <1271677408-2143-1-git-send-email-leslyam@ti.com> <20100510143043.GA4703@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37672 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758639Ab0EMKwa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 06:52:30 -0400
In-Reply-To: <20100510143043.GA4703@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org, 'Lesly A M' <x0080970@ti.com>, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>


> -----Original Message-----
> From: Peter 'p2' De Schrijver [mailto:peter.de-schrijver@nokia.com]
> Sent: Monday, May 10, 2010 8:01 PM
> To: Lesly A M
> Cc: linux-omap@vger.kernel.org; Lesly A M; Nishanth Menon; David Derrick;
> Samuel Ortiz
> Subject: Re: [PATCH v5 3/5] omap3: pm: Generic TRITON power scripts
> forOMAP3 based boards
> 
> On Mon, Apr 19, 2010 at 01:43:28PM +0200, ext Lesly A M wrote:
> > This pacth will create the generic TRITON power scripts which can be
> used
> > by different OMAP3 boards with the same power companion chip (TWL4030
> series).
> >
> > Added the api(twl4030_get_scripts/twl4030_get_vc_timings) to update
> > the sleep/wakeup/warm_rest sequence & voltsetup_time in the board file.
> >
> 
> any reason why you use a different type for the messages sent for P3 and
> P1/P2
> transitions ?
> 
> > +/*
> > + * Sequence to control the TRITON Power resources,
> > + * when the system goes into sleep.
> > + * Executed upon P1_P2/P3 transition for sleep.
> > + */
> > +static struct twl4030_ins __initdata sleep_on_seq[] = {
> > +	/* Broadcast message to put res to sleep */
> > +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> > +							RES_STATE_SLEEP),
2},
> > +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> > +							RES_STATE_SLEEP),
2},
> > +};
> > +
> > +static struct twl4030_script sleep_on_script __initdata = {
> > +	.script	= sleep_on_seq,
> > +	.size	= ARRAY_SIZE(sleep_on_seq),
> > +	.flags	= TWL4030_SLEEP_SCRIPT,
> > +};
> > +
> > +/*
> > + * Sequence to control the TRITON Power resources,
> > + * when the system wakeup from sleep.
> > + * Executed upon P1_P2 transition for wakeup.
> > + */
> > +static struct twl4030_ins wakeup_p12_seq[] __initdata = {
> > +	/* Broadcast message to put res to active */
> > +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> > +							RES_STATE_ACTIVE),
2},
> > +};
> > +
> > +static struct twl4030_script wakeup_p12_script __initdata = {
> > +	.script	= wakeup_p12_seq,
> > +	.size	= ARRAY_SIZE(wakeup_p12_seq),
> > +	.flags	= TWL4030_WAKEUP12_SCRIPT,
> > +};
> 
> Cheers,
> Peter.

Hi Peter,

The RES_TYPE field is same for all messages.

The resource which can go to low-power mode with clk_req sig de-asserting is
configured as RES_TYPE2 = '2'. And the resource which can go to low-power
mode with sys_off sig de-asserting is configured as RES_TYPE2 = '1'.

The RES_TYPE2 is '2' for P3 wakeup and the msg will applicable for Resource
which have their TYPE2 field configured '2' (RES_VINTANA1, RES_VINTANA2,
RES_VINTDIG, VIO, RES_CLKEN, RES_HFCLKOUT).

RES_TYPE2 = '1' for P1_P2 wakeup.
(Applicable for res: RES_VPLL1, RES_VDD1, RES_VDD2, RES_REGEN,
RES_NRES_PWRON, RES_SYSEN)

Regards,
Lesly A M


