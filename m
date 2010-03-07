From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] omap: i2c: Add i2c support on omap4 platform
Date: Sat, 6 Mar 2010 20:38:38 -0800
Message-ID: <6cb013311003062038q7f729be5m18fdefd59a421b54@mail.gmail.com>
References: <1266597180-25139-1-git-send-email-santosh.shilimkar@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C42E10AD@dbde02.ent.ti.com>
	<20100225214703.GJ28173@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C43BF6C3@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C43BFC61@dbde02.ent.ti.com>
	<20100227204049.GK17041@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C43BFCFA@dbde02.ent.ti.com>
	<20100302225445.GA14164@atomide.com> <1267922826.19029.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1267922826.19029.22.camel@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Angelo Arrifano <miknix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Syed, Rafiuddin" <rafiuddin.syed-l0cyMroinI0@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linwizard-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 6, 2010 at 4:47 PM, Angelo Arrifano <miknix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
> On Ter, 2010-03-02 at 14:54 -0800, Tony Lindgren wrote:
>> * Shilimkar, Santosh <santosh.shilimkar-l0cyMroinI0@public.gmane.org> [100227 21:28]:
>> > > -----Original Message-----
>> > > From: Tony Lindgren [mailto:tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org]
>> > > Sent: Sunday, February 28, 2010 2:11 AM
>> > > To: Shilimkar, Santosh
>> > > Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c@v=
ger.kernel.org; Syed, Rafiuddin; Cory
>> > > Maccarrone; akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
>> > > Subject: Re: [PATCH] omap: i2c: Add i2c support on omap4 platfor=
m
>> > >
>> > > * Shilimkar, Santosh <santosh.shilimkar-l0cyMroinI0@public.gmane.org> [100226 20:05]:
>> > > > Tony,
>> > > > What we do with patch now? It's more almost 6 months that this=
 patch is
>> > > > floating without merge.
>> > >
>> > > Well first we should test it for all omaps. So let's add it into
>> > > omap-testing for a few days to make sure it does not break anyth=
ing.
>> > >
>> > > Then let's ask Ben to queue it.
>> > >
>> > Ok with me.
>>
>> I've tried it out and seems to work just fine on 2420. I've applied
>> it for testing into omap-testing (and master) branches now.
>>
>> Would be nice to get an ack from people using 7xx too on this.
>>
>> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
> I just tested this on omap-testing with my HTC Wizard (omap850) using
> board-htcherald with little modifications.
> - I2C works as expected here.
>
> Acked-by: Angelo Arrifano <miknix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Tested-by: Angelo Arrifano <miknix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> --
> Angelo Arrifano AKA MiKNiX
> miknix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> http://www.arrifano.com
>
> MsC Student / Researcher
> Lab. I3S - CNRS/UNSA, France
> arrifano-kSrUrczbTpn985uAA1p3mw@public.gmane.org
> http://www.i3s.unice.fr/~arrifano/
>
> Gentoo Linux OMAP850/Embedded Official Developer
> http://www.gentoo.org/~miknix
> miknix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
>
> Linwizard Project Leader/Developer
> miknix-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>
> PGP Pubkey 0x3D92BB0B
>
>

I concur, I just tested it with an HTC Herald, and I2C works beautifull=
y.

Acked-by: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Tested-by: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

- Cory
