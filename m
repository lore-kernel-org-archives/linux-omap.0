From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 15/19] omap3+: sr: introduce notifier_control
Date: Wed, 23 Feb 2011 13:44:10 +0530
Message-ID: <AANLkTi=ALP8aTTPYW=TC1mu=UZdeWU5h+xt7+=y5+g2_@mail.gmail.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com> <1298116918-30744-16-git-send-email-nm@ti.com>
 <765c3f6e8053293455100f296fb76ae5@mail.gmail.com> <4D609D86.8040608@ti.com> <e161df1aa3dda3a792d1db6f93abbf98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:54550 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754174Ab1BWIOc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 03:14:32 -0500
Received: by wwb29 with SMTP id 29so139507wwb.18
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 00:14:30 -0800 (PST)
In-Reply-To: <e161df1aa3dda3a792d1db6f93abbf98@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

On Wed, Feb 23, 2011 at 12:16, Vishwanath Sripathy <vishwanath.bs@ti.co=
m> wrote:
>
[...]
> > >> +int sr_notifier_control(struct voltagedomain *voltdm, bool enab=
le)
> > >> +{
> > >> + =A0struct omap_sr *sr =3D _sr_lookup(voltdm);
> > >> + =A0u32 value =3D 0;
> > >> + =A0if (IS_ERR_OR_NULL(sr)) {
> > >> + =A0 =A0 =A0 =A0 =A0pr_warning("%s: sr corresponding to domain =
not found\n",
> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
> > >> + =A0 =A0 =A0 =A0 =A0return -EINVAL;
> > >> + =A0}
> > >> + =A0if (!sr->autocomp_active)
> > >> + =A0 =A0 =A0 =A0 =A0return -EINVAL;
> > > Why you do you return here? Class driver should still be able to =
place
> > > it's request even if sr is disabled though it will be effective o=
nly
> after
> > > sr is enabled.
> >
> > my intents were as following: which useful event would come without=
 SR
> > avs being enabled? what kind of event do you expect with the AVS
> > disabled which is useful for class driver, whose clase init alone w=
as
> > called and not class enable?
> The point I am making here is, why should SR class driver be prevente=
d to
> register for some events when SR is disabled? If it is prevented here=
,
> then it needs to keep track that the request is denied and needs to m=
ake
> the request again when SR is enabled later.
Let me try another way:
a) none of the notifications(SR_NOTIFY_MCUACCUM, SR_NOTIFY_MCUVALID,
SR_NOTIFY_MCUBOUND, SR_NOTIFY_MCUDISACK)
are possible once the SR class is disabled (class1,1.5,2,3) -
essentially coz the SR is expected to be disabled after class->deinit
is called (deinit is called when the autocomp is disabled for the
class driver).
b) class drivers are expected to release all resources once class
deinit is called, essentially meaning that SR module cannot trust to
have a notifier still capable of handling notifications once the
deinit is called.

So I come back to my question - "why does SR class driver need to
enable notification if it was told to be disabled?". Can you
illustrate with an example what I am missing?

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
