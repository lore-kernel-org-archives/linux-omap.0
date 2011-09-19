From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC PATCH 1/6] usb: musb: omap: Configure OTG_INTERFSEL for
 proper charger detection
Date: Mon, 19 Sep 2011 10:12:34 -0700
Message-ID: <20110919171234.GC31542@suse.de>
References: <1316096403-6013-1-git-send-email-kishon@ti.com>
 <1316096403-6013-2-git-send-email-kishon@ti.com>
 <4E731B6D.2040007@ru.mvista.com>
 <CAAe_U6KaFJGM61=Pkm2q-EBQeEtSAOBuC2jgFRd7DV4xKOjJdg@mail.gmail.com>
 <20110916141339.GA31093@suse.de>
 <CANrkHUaNhzLgYhF745=cs8cNjjNL3nc884+AoFwRjz3WEUhCcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55078 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896Ab1ISROj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Sep 2011 13:14:39 -0400
Content-Disposition: inline
In-Reply-To: <CANrkHUaNhzLgYhF745=cs8cNjjNL3nc884+AoFwRjz3WEUhCcw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, heikki.krogerus@linux.intel.com, p-basak2@ti.com, x0153364@ti.com, m-sonasath@ti.com, vishp@ti.com, hemahk@ti.com

On Mon, Sep 19, 2011 at 08:26:08PM +0530, T Krishnamoorthy, Balaji wrot=
e:
> On Fri, Sep 16, 2011 at 7:43 PM, Greg KH <gregkh@suse.de> wrote:
> > On Fri, Sep 16, 2011 at 07:21:41PM +0530, ABRAHAM, KISHON VIJAY wro=
te:
> >> Sergei,
> >>
> >> Thanks for your comments.
> >>
> >> On Fri, Sep 16, 2011 at 3:18 PM, Sergei Shtylyov <sshtylyov@mvista=
=2Ecom> wrote:
> >> > Hello.
> >> >
> >> > On 15-09-2011 18:19, Kishon Vijay Abraham I wrote:
> >> >
> >> >> Setting OTG_INTERFSEL to UTMI interferes with charger detection=
 resulting
> >> >> in incorrect detection of charger type. Hence OTG_INTERFSEL is =
configured
> >> >> to
> >> >> ULPI initially and changed to UTMI only after receiving USB_EVE=
NT_ID or
> >> >> USB_EVENT_VBUS notification.
> >> >
> >> >> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
> >> >> Signed-off-by: Balaji T K<balajitk@ti.com>
> >> >
> >> > =A0 AFAIK, full name is needed here.
> >>
> >> is it not the prerogative of the person giving his signed-off by??
> >
> > Not really.
> >
>=20
> Certainly did not want to compete for long names :-)
> But Is Real Name + unique email id not sufficient.
> patches with this Signed-off  .

Real Name + unique email is sufficient.  If "Balaji T K" is the real
name here, then my sincere apologies at getting this incorrect.  If it
isn't, a few more letters might be sufficient, or even, native utf-8
characters for the name in the native language is also ok.

I know I get enough problems with my "odd" last name to be aware that
there are lots of misconceptions about what is a real and not-real way
to spell/handle a name, so again, if I am mistaken here, please let me
know.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
