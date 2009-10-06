From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: Question on OPP table handling
Date: Tue, 6 Oct 2009 14:49:20 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB055AD5@dbde02.ent.ti.com>
References: <1254420194-4757-1-git-send-email-premi@ti.com>
	<4AC76810.1040206@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDC08B10@dbde02.ent.ti.com>
 <87ws39zsn4.fsf@deeprootsystems.com> <4ACA2A86.7060300@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB055A1D@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDC09122@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40485 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711AbZJFJUE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 05:20:04 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDC09122@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@deeprootsystems.com>

> -----Original Message-----
> From: Premi, Sanjeev
> Sent: Tuesday, October 06, 2009 2:14 PM
> To: Shilimkar, Santosh; Menon, Nishanth; linux-omap@vger.kernel.org
> Cc: Kevin H
> Subject: RE: Question on OPP table handling
> 
> 
> > -----Original Message-----
> > From: Shilimkar, Santosh
> > Sent: Tuesday, October 06, 2009 1:36 PM
> > To: Menon, Nishanth; linux-omap@vger.kernel.org
> > Cc: Premi, Sanjeev; Kevin H
> > Subject: RE: Question on OPP table handling
> >
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Nishanth Menon
> > > Sent: Monday, October 05, 2009 10:49 PM
> > > To: linux-omap@vger.kernel.org
> > > Cc: Premi, Sanjeev; Kevin H
> > > Subject: Re: Question on OPP table handling
> > >
> > > Kevin Hilman had written, on 10/05/2009 11:56 AM, the following:
> > > > "Premi, Sanjeev" <premi@ti.com> writes:
> > > >
> > > >>> -----Original Message-----
> > > >>> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
> > > >>> Sent: Saturday, October 03, 2009 8:35 PM
> > > >>> To: Premi, Sanjeev
> > > >>> Cc: linux-omap@vger.kernel.org
> > > >>> Subject: Question on OPP table handling
> > > >>>
> > > >>> Sanjeev Premi said the following on 10/01/2009 01:03 PM:
> > > >>>> +struct omap_opp omap3_mpu_rate_table[] = {
> > > >>>> +	{0, 0, 0},
> > > >>>> +	/*OPP1*/
> > > >>>> +	{S125M, VDD1_OPP1, 0x1E},
> > > >>>> +	/*OPP2*/
> > > >>>> +	{S250M, VDD1_OPP2, 0x26},
> > > >>>> +	/*OPP3*/
> > > >>>> +	{S500M, VDD1_OPP3, 0x30},
> > > >>>> +	/*OPP4*/
> > > >>>> +	{S550M, VDD1_OPP4, 0x36},
> > > >>>> +	/*OPP5*/
> > > >>>> +	{S600M, VDD1_OPP5, 0x3C},
> > > >>>> +};
> > > >>>>
> > > >>> For those involved,
> > > >>> if we wanted to convert omap3_mpu_table[] into
> > > >>> *omap3_mpu_table so that
> > > >>> we dynamically initialize it based on cpu type - what
> > would be the
> > > >>> recommendations?
> > > >> Nishanth,
> > > >>
> > > >> Good idea!
> > > >>
> > > >> As a table, previous patch enables it (not as intent, but due to
> > > syntax):
> > > >>
> > > >>   >  +/* struct omap_opp_table - View OPP table as an object
> > > >>   > + * @min: Minimum OPP id
> > > >>   > + * @max: Maximim OPP id
> > > >>   > + * @opps: Pointer to array defining the OPPs.
> > > >>   > + *
> > > >>   > + * An OPP table has varied length. Knowing minimum
> > and maximum
> > > >>   > + * OPP ids allow easy traversal.
> > > >>   > + */
> > > >>   > +struct omap_opp_table {
> > > >>   > +       u8      min;
> > > >>   > +       u8      max;
> > > >>   > +       struct omap_opp* opps;
> > > >>   > +};
> > > >>
> > > >> But now, I think it would be good to have an API that can fill an
> > > opp_table:
> > > >>
> > > >> int add_opp_definition(u8 id, u32 freq, u16 vsel);
> > > >>
> > > >> ...and, if an array is preferred, length can be set as:
> > > >> int set_opp_table_length (u8 max);
> > > >
> > > > I'm all for dynamic OPP setting, but not as an array.  A
> > list should
> > > > probably be used.
> > >
> > > Won't a list implementation cause more than necessary
> > overhead? I agree
> > > that something like set_opp_table_length probably might be
> > redundant in
> > > that case.
> > >
> > >
> > > >> If I were to extend the discussion from other thread on
> > toggling the
> > > valid OPPs
> > > >> based on "enable_off_mode", these could be handy.
> > > >>
> > > >> int set_opp_valid(bool flag);
> > > >> bool is_opp_valid(void);
> > > >>
> > > >
> > > > Yes, we need a concept of a valid OPP, not just for OFF
> > mode, but for
> > > > OSWR and possibly for a full constraint framework as well.
> > > Ack.
> > Even though above approach is possibly better a simple fix
> > could be just adding a flag in the structure (OPP
> > valid/invalid) and populating this flag run time using CPU type.
> >
> 
> [sp] This is exactly in the original patch.
OK

Regards,
Santosh

