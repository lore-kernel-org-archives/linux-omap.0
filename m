From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/9 v3] usb: musb: Adding names for IRQs in resource
 structure
Date: Tue, 28 Sep 2010 15:44:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009281543290.5439@utopia.booyaka.com>
References: <1285201631-26266-1-git-send-email-hemahk@ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E94027863D959@dbde02.ent.ti.com> <AANLkTim=ARtDA99XWP+RuB5nBh5FNAJHfSV34fiwtAk8@mail.gmail.com> <alpine.DEB.2.00.1009281515590.5439@utopia.booyaka.com>
 <AANLkTi=UpeYtuQDuxEt2FNSajB-rtMpMZwseD=GUao2Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-201294673-1285710288=:5439"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50061 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab0I1Vot (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 17:44:49 -0400
In-Reply-To: <AANLkTi=UpeYtuQDuxEt2FNSajB-rtMpMZwseD=GUao2Y@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>, "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-201294673-1285710288=:5439
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 Sep 2010, Mike Frysinger wrote:

> On Tue, Sep 28, 2010 at 17:18, Paul Walmsley wrote:
> > On Tue, 28 Sep 2010, Mike Frysinger wrote:
> >> well, currently, your resource definition must always be in the order
> >> of dev int and then dma int. =C2=A0if it isnt, then i dont think musb =
is
> >> going to work.
> >>
> >> not sure why you wouldnt simply change your platform resources to
> >> match the what the driver expects ...
> >
> > The resource data is getting automatically populated from a set of data
> > generated from TI's hardware database for the OMAP platform, at least.
> > While we could hack in some exceptions to that tool to generate resourc=
es
> > in a specific order, it seems less fragile to use the resource name
> > instead. =C2=A0That way, no matter what order the resources are generat=
ed, the
> > driver should still work.
>=20
> guessing you're not referring to a device tree setup, but something
> even more convoluted ?

No need to disparage it before you've seen it :-)

> i'd highly suggest that this patch be resent with the info you've just
> provided in its changelog so people can get a better understanding of
> the "why" ... i'm not against the patch, it just seemed to be lacking
> any background info

Hema, would you care to update the patch changelog accordingly?


- Paul
--155748971-201294673-1285710288=:5439--
