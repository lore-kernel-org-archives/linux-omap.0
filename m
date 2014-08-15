From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: DTR gpio handling removed by 985bfd54c826c0ba873ca0adfd5589263e0c6ee2
Date: Fri, 15 Aug 2014 08:08:44 +0200
Message-ID: <B18DC75F-EA0E-456F-996E-2F4BF496B68B@goldelico.com>
References: <CAAfyv36aMkE5e6Bo1hy1md+Z5EjrZjP+foZTyncp5GFtnaL_sg@mail.gmail.com> <20140814225802.GA12109@saruman.home>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140814225802.GA12109@saruman.home>
Sender: linux-serial-owner@vger.kernel.org
To: balbi@ti.com
Cc: Belisko Marek <marek.belisko@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, NeilBrown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

Am 15.08.2014 um 00:58 schrieb Felipe Balbi <balbi@ti.com>:

> Hi,
>=20
> On Thu, Aug 14, 2014 at 11:04:58PM +0200, Belisko Marek wrote:
>> during 3.15 release was removed by commit
>> 985bfd54c826c0ba873ca0adfd5589263e0c6ee2 code which was added by
>> 9574f36fb801035f6ab0fbb1b53ce2c12c17d100 by Neil Brown. We're using
>> DTR gpio in gta04 device. I plan to post DT binding for DTR gpio +
>> documentation and find out that Neil's code was removed by Felipe.
>> Greg can you please revert mentioned commit? We're using DTR gpio in
>> gta04 device. Or is there other way how to proceed? Thanks.
>=20
> there are *NO* users of that in tree, if you're using it, then please
> add a proper DTS for your device and figure out a way of passing DTR
> gpio through DT.

In fact we are in the middle of preparing DT and driver patches for ups=
treaming
the out of tree drivers Neil is mentioning. So there are no users *yet*=
 and
maybe we are the first one.

Neil has already completely argued and commented on that topic:

https://lkml.org/lkml/2014/4/23/736

Unfortunately he acked the removal with a completely non-technical argu=
ment:

> Just at the moment I'm finding it hard to care.
> So
>  Acked-by: NeilBrown <neilb@suse.de>

Now we have the problem that it got kicked out while we were preparing
the other parts :(

On the other hand, please consider that we don=92t have the manpower an=
d knowledge
to modify bigger parts of Linux besides plumbing together parts that al=
ready
exist and add drivers and DT nodes.

So please consider again to re-add 9574f36fb801035f6ab0fbb1b53ce2c12c17=
d100.

Or should we resubmit it together with our DT/drivers where we use it?

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
