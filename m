From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 0/4] Cleanup PRM and CM regbit headers
Date: Fri, 5 Jul 2013 00:03:48 -0700
Message-ID: <20130705070347.GP5523@atomide.com>
References: <1372076143-12955-1-git-send-email-rnayak@ti.com>
 <20130625071428.GC5523@atomide.com>
 <51C95839.6050307@ti.com>
 <20130704115819.GJ5523@atomide.com>
 <51D56743.9080800@ti.com>
 <alpine.DEB.2.02.1307041627540.6258@utopia.booyaka.com>
 <51D65CE8.4050004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52286 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751222Ab3GEHDx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jul 2013 03:03:53 -0400
Content-Disposition: inline
In-Reply-To: <51D65CE8.4050004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "benoit.cousson@gmail.com" <benoit.cousson@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130704 22:49]:
> On Thursday 04 July 2013 10:14 PM, Paul Walmsley wrote:
> > You mentioned that these patches were generated with some kind of a=
wk/grep=20
> > scripting.  Can you integrate that in an automated way into the=20
> > autogeneration flow?  If the answer is yes, then keep the header.  =
If the=20
> > answer is no, then the header should be dropped.  Beno=C3=AEt, mayb=
e you have=20
> > an opinion too?
>=20
> Ok, I'll try and integrate those scripts so all this can be done in a=
n
> automated way even for newer SoCs.
>=20
> >=20
> > As far as whether this should go in -rcX or not, my view is that, a=
s a=20
> > matter of policy, large changes like this should wait until v3.12. =
 Now,=20
> > having written that, I also was under the impression that the OMAP5=
=20
> > changes weren't going to be sent upstream unless the total diffstat=
 would=20
> > be balanced to roughly zero or negative lines.  As far as I know, t=
hat=20
> > didn't happen.  So I guess, v3.11-rc it is...  kernel development b=
y=20
> > diffstat :-(
>=20
> I don't mind these going in -rcX or 3.12, either way is fine.

Removal of unused code should be OK for the early -rc. I doubt that
anybody would object it especially considering that's it's a huge
pile of unused defines that most likely won't ever be needed for
DT based booting.
=20
> > Finally, please repost the whole series once you're done with your=20
> > changes, as a non-RFC, along with your pull request (if you plan to=
 send=20
> > one).  I guess I should be the one to take these, since I wound up =
taking=20
> > the OMAP5 addition...
>=20
> :) I thought so too that you should be the one sending the pull.
> I will post these out as non-RFC after I do a clean integration into
> the autogen scripts, and then you can take a call on sending the pull=
 for
> either -rcX or 3.12

I'd prefer to have it done now for the early -rc series. But if it
drags on, we should not merge it during the -rc series.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
