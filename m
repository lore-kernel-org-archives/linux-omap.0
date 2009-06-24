From: Tony Lindgren <tony@atomide.com>
Subject: Re: git tree
Date: Wed, 24 Jun 2009 14:10:25 +0300
Message-ID: <20090624111024.GO7352@atomide.com>
References: <376636be0906240234n2b9f9e77g12c8a6494bbd245e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49925 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbZFXLK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 07:10:26 -0400
Content-Disposition: inline
In-Reply-To: <376636be0906240234n2b9f9e77g12c8a6494bbd245e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Ryan <ryanphilips19@googlemail.com> [090624 12:42]:
> Hi,
> =A0 Looking at the linux-omap tree using the gitweb interface. Apart
> from the "master" branch and tags.
> =A0 why do we have lots of branches? How and when do they intertact w=
ith
> each other.
>=20
>=20
> 17 hours ago omap1-upstream shortlog | log | tree
> 17 hours ago omap2-upstream shortlog | log | tree
> 17 hours ago omap3-boards shortlog | log | tree
> 17 hours ago omap3-upstream shortlog | log | tree
> 17 hours ago omap4 shortlog | log | tree
> 17 hours ago pm shortlog | log | tree
> 19 hours ago omap-headers shortlog | log | tree
> 19 hours ago omap-upstream shortlog | log | tree
> 19 hours ago omap-fixes shortlog | log | tree
> 47 hours ago master shortlog | log | tree
> 2 weeks ago omap-decimate shortlog | log | tree
> 2 weeks ago omapfb-upstream shortlog | log | tree
> 2 weeks ago omap-pool shortlog | log | tree
> 3 weeks ago for-next-2.6.30 shortlog | log | tree
> 4 weeks ago for-next shortlog | log | tree
> 4 weeks ago iommu shortlog | log | tree
> 2 months ago omap-2.6.29 shortlog | log | tree
> 3 months ago clks-testing shortlog | log | tree
> 3 months ago delete shortlog | log | tree
> 4 months ago omap-2.6.28 shortlog | log | tree
> 4 months ago tidspbridge shortlog | log | tree
> 5 months ago dspgateway shortlog | log | tree
> 5 months ago linus shortlog | log | tree
> 6 months ago musb shortlog | log | tree
>=20
>=20
> Can anyone explain what exactly goes into each of them?
> Some are straight forward like pm, usb, tidspbridge, gateway. not sur=
e
> about for-next-2.6.30, omap-fixes.

More or less the various branches are topic branches of patches
going to the mainline kernel. For example, omap-fixes contains fixes to
be sent during the -rc cycle, omap-upstream contains omap common patche=
s
for the next merge window, omap1-upstream omap1 specific patches for
the next merge window and so on.

The master branch is more or less merge of all the topic branches.
Currently missing from it are the pm branch and the dss2 branch.

> Trying to understand things/mode of development in here.

Hope this helps. In general, your should now be able to do almost
all the patches against Linus' mainline kernel. Of course until
we get pm and dss2 into the mainline kernel, those patches need to
be done against pm and dss2 branches.

So everybody, where possible, please base all the patches against
Linus' kernel stable something or -rc someting, that way they are
easy to merge in.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
