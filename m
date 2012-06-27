From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Current state of AM33xx patches
Date: Wed, 27 Jun 2012 12:13:18 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com>
 <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com>
 <4FE9A00B.6010908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40030 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756554Ab2F0MN1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 08:13:27 -0400
In-Reply-To: <4FE9A00B.6010908@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>, Daniel Mack <zonque@gmail.com>
Cc: Jason Kridner <jkridner@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hernandez, Carlos" <ceh@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kridner, Jason" <jdk@ti.com>

On Tue, Jun 26, 2012 at 17:12:03, Nori, Sekhar wrote:
> Hi Daniel,
> 
> On 6/25/2012 11:47 PM, Daniel Mack wrote:
> > On 21.06.2012 15:50, Daniel Mack wrote:
> >> On 18.06.2012 10:15, Hiremath, Vaibhav wrote:
> >>> On Mon, Jun 11, 2012 at 19:21:21, Jason Kridner wrote:
> >>>> From: Daniel Mack <zonque@gmail.com>
> >>>>> Hey,
> >>>>>
> >>>>> can anybody give me a quick wrap-up about the current state of AM33xx
> >>>>> based SoCs in mainline? What are the next steps to get things merged?
> >>>>
> >>>> There is a wiki page [1] that is intended to provide a summary, but I'm
> >>>> confident it is not up-to-date.  
> >>>
> >>> Page updated now...
> >>>
> >>> http://processors.wiki.ti.com/index.php/Sitara_Linux_Upstream_Status#AM335x_Linux_Status
> >>
> >> Great, thanks. So if things get upstreamed, which is the repo/branch
> >> they appear in? In other words: where is the code people should write
> >> patches against? I couldn't find an answer to that yet.
> > 
> > ping?
> 
> Bug fixes are always accepted against Linus's tree[1].
> 
> For features, typically there is a -next branch that each subsystem
> maintainer has against which feature development happens. In case of
> OMAP, feature development happens against master branch of linux-omap
> tree[2]. One way to get to know the -next branches of all subsystem is
> to look at Next/Trees file of linux-next tree[3].
> 
> Note that in case of ARM, sub-arch maintainers send the code to arm-soc
> maintainers who in turn have a branch which gets merged to linux-next.
> 
> Hope that helps.
> 

Just to clarify from AM335x perspective,

In case of AM335x, since the patches and complete BasePort support is still
not present in the Mainline (neither in Linus's tree not in linux-omap), you 
need to use my Repo (https://github.com/hvaibhav: Closely follows linux-
omap/master) in order to test something on BeagleBone platform.

Once we have all bits-n-pieces accepted/merged in the mainline, then all the 
above process must be followed for patch submission.


Thanks,
Vaibhav
