From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 7/8] drivers: introduce rpmsg, a remote-processor messaging bus
Date: Thu, 15 Sep 2011 09:42:05 +0930
Message-ID: <87d3f2hdey.fsf@rustcorp.com.au>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com> <1308640714-17961-8-git-send-email-ohad@wizery.com> <87liwu8u3q.fsf@rustcorp.com.au> <BANLkTi=7TBMqnEf2qustrmSaubtTam79Bw@mail.gmail.com> <CAK=WgbY0zMkHw9XHDKPEfVQZVRfGP=nMmyJgm6jD5FEkBZkMRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:47731 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519Ab1IOAci convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 20:32:38 -0400
In-Reply-To: <CAK=WgbY0zMkHw9XHDKPEfVQZVRfGP=nMmyJgm6jD5FEkBZkMRQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>

On Wed, 14 Sep 2011 21:38:43 +0300, Ohad Ben-Cohen <ohad@wizery.com> wr=
ote:
> Hi Rusty,
>=20
> On Wed, Jun 22, 2011 at 1:46 PM, Ohad Ben-Cohen <ohad@wizery.com> wro=
te:
> > On Wed, Jun 22, 2011 at 5:42 AM, Rusty Russell <rusty@rustcorp.com.=
au> wrote:
> >> On Tue, 21 Jun 2011 10:18:33 +0300, Ohad Ben-Cohen <ohad@wizery.co=
m> wrote:
> >>> +#define VIRTIO_ID_RPMSG =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A010 /* virtio remote processor messaging */
> >>
> >> I think you want 6. =C2=A0Plan 9 jumped ahead to grab 9 :)
> >
> > 6 it is :)
>=20
> Looking at the virtio-spec, it seems that 6 is taken by 'ioMemory'.
> There's no indication for it in virtio_ids.h though, and the
> virtio-spec has no appendix for this id, so maybe it's available afte=
r
> all ?
>=20
> If it is available, I'll take it for rpmsg, and will also update
> virtio-spec appropriately. Otherwise, we'll settle on 7 ? :)

7... numbers are cheap :)

Cheers,
Rusty.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
