From: mark gross <markgross@thegnar.org>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Fri, 26 Aug 2011 09:54:27 -0700
Message-ID: <20110826165427.GC9437@gvim.org>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
 <1309446685-17502-3-git-send-email-j-pihet@ti.com>
 <CAJ0PZbRCvoh8-rJAR92Ak_JPk4FyR0dp_OeKOUkWtD5AdFsPCw@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56772 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab1HZQyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Aug 2011 12:54:33 -0400
Received: by gxk21 with SMTP id 21so2992684gxk.19
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 09:54:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJ0PZbRCvoh8-rJAR92Ak_JPk4FyR0dp_OeKOUkWtD5AdFsPCw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: jean.pihet@newoldbits.com, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, Jean Pihet <j-pihet@ti.com>

On Fri, Aug 26, 2011 at 11:25:13AM +0900, MyungJoo Ham wrote:
> On Fri, Jul 1, 2011 at 12:11 AM,  <jean.pihet@newoldbits.com> wrote:
> > @@ -129,19 +146,19 @@ static const struct file_operations pm_qos_po=
wer_fops =3D {
> > =A0/* unlocked internal variant */
> > =A0static inline int pm_qos_get_value(struct pm_qos_object *o)
> > =A0{
> > - =A0 =A0 =A0 if (plist_head_empty(&o->requests))
> > + =A0 =A0 =A0 if (plist_head_empty(o->requests))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return o->default_value;
> >
> > =A0 =A0 =A0 =A0switch (o->type) {
> > - =A0 =A0 =A0 case PM_QOS_MIN:
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_first(&o->requests)->pri=
o;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case PM_QOS_MIN:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_first(o-=
>requests)->prio;
> >
> > - =A0 =A0 =A0 case PM_QOS_MAX:
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_last(&o->requests)->prio=
;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case PM_QOS_MAX:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_last(o->=
requests)->prio;
> >
> > - =A0 =A0 =A0 default:
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* runtime check for not using enum *=
/
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* runtime check for =
not using enum */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
> > =A0 =A0 =A0 =A0}
> > =A0}
>=20
> Hello,
>=20
>=20
> Sorry to jump in this late, but, I've got a question in choosing QoS
> value from the list with pm_qos_get_value function and pm_qos_type.
>=20
> For QoS objects such as network throughput, wouldn't "PM_QOS_ADD" be
> more appropriate than PM_QOS_MAX?
> If A is requesting 10MB/s on NIC-X and B is requesting 5MB/s on NIC-X=
,
> I guess PM QOS should say NIC-X that it needs to provide 15MB/s, not
> 10MB/s. Or, are we assuming that A and B will never put streams at th=
e
> same time?

This was brought up a few years back as well.  The reason we kept the
aggregate QoS for network Throughput as a max instead of a sum was that
there where already a number of interfaces for network shaping and we
didn't have a good answer to the problem of what to do when the
throughput qos requested exceeds hardware capabilities. =20

Now that I have more experience with handsets I'm not sure it makes any
practical difference to sum or max the throughput qos requests.  So if
someone would like it to aggregate throughputs by summation of requests
that could be done. =20

It turns out its the latency requests that are really used.

The network qos parameters also have a problem with discriminating
between what physical interface the QoS is for.  This limitation in the
ABI is partially addressed with some of the work that Jean Pihet's
patches are doing.

--mark

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
