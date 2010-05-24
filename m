From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Mon, 24 May 2010 20:49:18 +0200
Message-ID: <201005242049.18920.rjw@sisk.pl>
References: <1274482015-30899-1-git-send-email-arve@android.com> <201005240246.55043.rjw@sisk.pl> <20100524043224.GA31700@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100524043224.GA31700@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-omap@vger.kernel.org

On Monday 24 May 2010, Felipe Balbi wrote:
> On Mon, May 24, 2010 at 02:46:54AM +0200, ext Rafael J. Wysocki wrote=
:
> >On Saturday 22 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> This patch series adds a suspend-block api that provides the same
> >> functionality as the android wakelock api. This version adds a
> >> delay before suspending again if no suspend blockers were used
> >> during the last suspend attempt.
> >
> >Patches [1-6/8] applied to suspend-2.6/linux-next
>=20
> funny thing is that even without sorting out the concerns plenty of=20
> developers had on the other thread, this series is still taken. What'=
s=20
> the point in dicussing/reviewing the patches then ?

I don't think the concerns you're referring to can be solved out.  Some=
 people
just don't like the whole idea and I don't think there's any way we can=
 improve
the patches to make them happy.  The only "solution" they would be sati=
sfied
with would simply be rejecting the feature altogether, although there a=
re no
practically viable alternatives known to me.

OTOH I do think there are quite a few reasons to take the patchset, so =
I'm
going to push it to Linus as I told in one of my replies to Kevin.  If =
Linus
decides not to pull it, so be it.

Thanks,
Rafael
