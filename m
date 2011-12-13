From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/4] fixes for twl4030-irq in mainline
Date: Tue, 13 Dec 2011 21:52:56 +0100
Message-ID: <20111213205256.GG2796@sortiz-mobl>
References: <20111126201334.16080.85045.stgit@notabene.brown>
 <20111212173819.GT13952@sortiz-mobl>
 <CAMP44s1D+HXP_prHVwEztLCd1XJpnzukFeNKH_xEZrq06jEouA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28598 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab1LMUrv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 15:47:51 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s1D+HXP_prHVwEztLCd1XJpnzukFeNKH_xEZrq06jEouA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: NeilBrown <neilb@suse.de>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi Felipe,

On Tue, Dec 13, 2011 at 04:12:02PM +0200, Felipe Contreras wrote:
> Hi,
>=20
> On Mon, Dec 12, 2011 at 7:38 PM, Samuel Ortiz <sameo@linux.intel.com>=
 wrote:
> > On Sun, Nov 27, 2011 at 07:17:41AM +1100, NeilBrown wrote:
> >> =A0 The recent tidying up of twl4030-irq seems to have left it bro=
ken.
> >> At least it doesn't work for me on my gta04 (www.gta04.org). =A0Th=
e
> >> first interrupt from the device freezes the whole system (by being
> >> constantly delivered)
> >>
> >> The following 4 patches make it work for me and addresses some oth=
er
> >> less critical issues like a typo in a comment :-)
> >
> > Thanks, I applied all 4 of them.
>=20
> Did you apply them for 3.2 or 3.3? Without the first patch any system
> that has a twl4030 chip will immediately hang on the first interrupt,
> and many functions of twl4030 will just not work without the second
> one.
Thanks for the heads up. I applied the first 2 patches to my for-linus =
branch.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
