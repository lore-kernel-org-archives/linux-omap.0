From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: Upcoming merge window, marked all the patchwork patches before
 v2.6.35 as archived
Date: Thu, 16 Sep 2010 00:14:16 +0530
Message-ID: <AANLkTikA1eOPe-GGW4egFHO9=Kw8bdEaTW8RC5o_A2JK@mail.gmail.com>
References: <20100915183141.GF4174@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:42055 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754906Ab0IOSoj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Sep 2010 14:44:39 -0400
Received: by mail-wy0-f169.google.com with SMTP id 36so739596wyb.14
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 11:44:37 -0700 (PDT)
In-Reply-To: <20100915183141.GF4174@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, Sep 16, 2010 at 12:01 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> Here's some important info regarding posted patches and the
> upcoming merge window.
>
>
> UPCOMING MERGE WINDOW
>
> Just to remind everybody, we want to have our omap patches reviewed
> and queued into for-next by -rc6. That is less than two weeks from
> today.
>
> If you have a larger set of patches, please set them up into a git
> branch after review for pulling. Please remember that anything
> touching arch/arm/*omap*/ must be also reviewed on the linux-arm-kernel
> list, so Cc that list too so I don't have to repost the patches before
> applying. Basically see the instructions here (server currently down?):
>
> http://www.elinux.org/OMAP_patch_merging_process
>
>
> POSTED PATCHES AND PATCHWORK
>
> To cope with the patch overload, I added all the patchwork
> patches into archived-v2.6.35 bundle when v2.6.35 got tagged:
>
> http://patchwork.kernel.org/bundle/tmlind/archived-v2.6.35/?archive=both
>
> However, at that point the patchwork instance on kernel.org was buggy,
> and I could not mark them all archived.
>
> Anyways, I've marked them all archived now. This means they do not
> appear as new patches any longer, and patchwork.kernel.org is
> usable again for tracking what's already queued up.
>
> I plan on archiving everything when a new major release comes out,
> maybe even after some -rc releases if necessary.
>
> So the current list of patches we're working with for the upcoming
> merge window is:
>
> http://patchwork.kernel.org/project/linux-omap/list/
>
> Please everybody, check if your patch got archived, and if so,
> repost as needed against v2.6.36-rc4.
>
> In general, if something got archived, please don't consider it
> rejected. It just means that you have to repost, fix and complain
> until the patch is ready and integrated :) The standard Linux way
> you know.
>

Tony,

I posted this patch [1] a while ago fixing a bunch of compile warnings
that show up with omap3_defconfig and omap_4430sdp_defconfig builds. I
can't seem to locate it in patchworks; not sure how that happened.

Any chance you can pick this up (before more folks on LAKML start
yelling about no-one caring for build warnings...)? Would you like me
to post this again?

- Anand

[1] http://marc.info/?l=linux-omap&m=128212353619711&w=2
