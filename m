From: Rebecca Schultz Zavin <rebecca@android.com>
Subject: Re: Fwd: dss2 with dsi
Date: Thu, 16 Apr 2009 11:21:35 -0700
Message-ID: <aed62de90904161121q5167594xb2dbbf29a7577121@mail.gmail.com>
References: <aed62de90904151916h5a218e9bgf3419ea96c3ed262@mail.gmail.com>
	 <aed62de90904151917l21419edo12df2dc3ad5c707c@mail.gmail.com>
	 <1239875936.6696.125.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:7261 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbZDPSVk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2009 14:21:40 -0400
Received: from spaceape12.eur.corp.google.com (spaceape12.eur.corp.google.com [172.28.16.146])
	by smtp-out.google.com with ESMTP id n3GILc5o021769
	for <linux-omap@vger.kernel.org>; Thu, 16 Apr 2009 11:21:39 -0700
Received: from rv-out-0708.google.com (rvbk29.prod.google.com [10.140.87.29])
	by spaceape12.eur.corp.google.com with ESMTP id n3GILZTk015516
	for <linux-omap@vger.kernel.org>; Thu, 16 Apr 2009 11:21:36 -0700
Received: by rv-out-0708.google.com with SMTP id k29so528451rvb.36
        for <linux-omap@vger.kernel.org>; Thu, 16 Apr 2009 11:21:35 -0700 (PDT)
In-Reply-To: <1239875936.6696.125.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Apr 16, 2009 at 2:58 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> Please send DSS2 issues directly to me (cc l-o if you want to). I may
> miss them otherwise.
>
> On Thu, 2009-04-16 at 04:17 +0200, ext Rebecca Schultz Zavin wrote:
>> I'm using dss2 on a dsi panel and I've run into a few limitations in
>> the present implementation. =A0I'd like to post the fixes, but I'd
>> appreciate some guidance, especially since I'm working without the
>> mipi spec so it isn't always clear to me what's a function of the
>> implementation vs. the spec.
>
> The DSI implementation is generally quite limited currently. I have o=
nly
> one DSI display configuration to test it with, so I opted to leave ou=
t
> the complexity of full VC control for now. There has been enough
> problems just to get it working properly with one DSI peripheral =3D)=
=2E

I know!  I've never met a serial display interface that wasn't a total
pain to get going.

>
>> 1- I think the destination vc set in dsi.vc[n].dest_per should be
>> specifiable from either the dsi controller or the board file? =A0Any
>> preference on which? =A0Could be added to omap_ctrl or to
>> omap_dss_display_type.
>
> I believe it should be in the board file. As I said I have only one D=
SI
> display with hardcoded vc-id, but I imagine it would be possible to h=
ave
> DSI peripherals that can respond to a configurable vc-id. Thus board
> file would be the only place where they can be spesified.

I'll make this change and send you a patch.

>
>>
>> 2- The code hard codes vc0 for L4 and v1 for dispc. =A0My controller
>> exepects the reverse. =A0Again I think this should come from some st=
ruct
>> in either the controller or the board file. =A0Preferences?
>
> The OMAP DSI virtual channel implementation is a bit confusing at fir=
st.
> The VC register sets do not say where the packets go. So if you send
> data with VC0, it doesn't mean that the packets go to the peripheral
> with vc-id 0.
>
> So even if L4 and DISPC code use different VC register sets, they bot=
h
> go to the same peripheral with id 0. This id is defined in the dest_p=
er
> field mentioned above.
>
> I used two separate VCs just to make debugging simpler, as I only nee=
d
> to configure the VC once and thats it. Otherwise I would need to chan=
ge
> the VC0 back and forth between L4 mode to DISPC mode. I don't see why
> this wouldn't work, and my plan is to use just one VC register set fo=
r
> one peripheral at some point.

That clarifies things a lot.  I don't have the MIPI dsi spec so I'm
working from reference code from TI and the limited documentation in
the omap TRM.  I'll see if I can't get things working without that
change.

>
>>
>> 3- The code hard codes the complexio timing values used for setting
>> DSIPHY_CFG0, 1 and 2. =A0I think these values should be specified in=
 the
>> omap_ctrl the way rfbi_timings are.
>
> I don't remember what settings there is but aren't they specified in
> MIPI DSI spec? If so, they should be the same for all peripherals. At
> least in theory =3D).

I don't know about this, again I don't have the spec.  I'll see if I
can use your values.  Were they specified as a range possibly?

Speaking of which, one of the other things I ran into was the
controller expecting some packets with different data_type fields.
The reference code I'm working from called these "generic" but I have
no idea if they are part of the spec or just vendor specific.  I added
a couple of functions that let you pass the data_type, but if they are
common to the spec it'd be easier to just treat them the same way you
did with the dcs types.  Do you remember whether the spec specified
any additional types?  I have these:

#define GENERIC_WRITE_LONG_CMD             0x29
#define GENERIC_WRITE_SHORT_1                 0x23
#define GENERIC_WRITE_SHORT_0                 0x13
#define GENERIC_READ_CMD                          0x14
#define GENERIC_SHORT_READ1                    0x11
#define GENERIC_SHORT_READ2                    0x12
#define GENERIC_LONG_READ                        0x1a


>
> =A0Tomi
>
>
>

Thanks,

Rebecca
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
