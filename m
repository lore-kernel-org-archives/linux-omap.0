From: Jason Kridner <jkridner@beagleboard.org>
Subject: Re: Staging tree for AM335x platforms
Date: Wed, 21 Sep 2011 17:50:52 -0400
Message-ID: <CA+T6QP=G7KmNY4e4hS5Rcf8URkVpzsemLTCKh2G+tEG+eSnVfQ@mail.gmail.com>
References: <CA+T6QP=H0=WYcrA0HL+06Az6mFk7=K0O3MYNR=t+5Za-vDSyJA@mail.gmail.com>
	<20110921202304.GI2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:54344 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab1IUVuy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 17:50:54 -0400
Received: by gwj16 with SMTP id 16so986631gwj.1
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 14:50:54 -0700 (PDT)
Received: by gwj16 with SMTP id 16so986610gwj.1
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 14:50:52 -0700 (PDT)
In-Reply-To: <20110921202304.GI2937@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Wed, Sep 21, 2011 at 4:23 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> Hi,
>
> * Jason Kridner <jkridner@beagleboard.org> [110921 10:56]:
>> Tony,
>>
>> I'm looking at creating a public repository to hold patches not yet =
in
>> shape for inclusion in linux-omap (if not personally, then someone a=
t
>> TI that meets the below charter). =A0I know there can be concern tha=
t
>> this becomes a distraction if we start pulling in community patches.
>> It seems it needs to be coupled with reworking systems for acceptanc=
e
>> upstream, but we'd like for there to be something where community
>> members can generate patches against while we are in the process of
>> cleaning up the underlying platform bits.
>
> OK cool.
>
>> Do you have any recommendations or guidelines that should be followe=
d
>> regarding anything about such a public repository? =A0Recommendation=
s
>> and guidelines can include, but not be limited to, where the
>> repository should live, where patches and pull requests should be
>> submitted, what types of patches should be accepted and what state
>> they should be in, when should it be rebased, who is suitable to
>> maintain this repository and what should be used for managing patch
>> status (ie. patchwork and which patchwork).
>
> Well in general the thing to watch out for is once you create a tree
> it becomes a complete mess in about three months. Or else it just
> becomes a graveyard of unmergeable patches :)

I'm not going to advertise a tree here and on the beagle list until
I'm confident I can stick with it a couple of years consistently.  I
like to keep some labels on old stuff, but I would commit to having it
rebased frequently and tested in an automated fashion.

>
> So keeping that in mind, ideally your tree would be just a daily merg=
e
> of various driver developers branches. And then try to set up things
> where the responsibility of merging code upstream is on the drivers
> developers. Trying to merge other people's patches upstream is not
> scalable.

Understood.  I'd be looking for contributors to show some commitment
or drop their patches.  I'm sure there will be a certain amount of
fire-and-forget patches coming from people that I'll want to try to
push for them, but I'll try to shed the cruft frequently.

>
> Other than that, you should be able to base it on some recent mainlin=
e
> tag and pick in some queued up patches as needed.
>
>> If this doesn't sound useful to you, then please feel free to shut m=
e
>> down on this. =A0The goal is to help and it is understood that
>> contributions to the infrastructure (dev tree, pwr mgmt, etc.) are
>> required to be productive.
>
> That totally sounds usable to me :) Assuming you can figure out some
> way to address the comments above.
>
> For helping with contributions, I can think of a few places where
> help is badly needed:
>
> 1. Remove dependencies in mainline kernel that block merging
>
> =A0 Maybe you can isolate some issues in mainline kernel that cause
> =A0 you problems merging your patches upstream? If so, whatever is
> =A0 needed should be done to patch away those dependencies. At least
> =A0 PM patches fit into this category..

Makes sense.

>
> 2. Merge all am335x/beagle clone board-*.c files together
>
> =A0 This would help a lot when we start converting drivers to use
> =A0 device tree as it reduces the number of board-*.c files

Sounds like a good task and something I can tackle.  I got some
push-back on this from internal developers, but I think I can start
merging some of it myself and send some code to ask advice on how to
make it most maintainable.

>
> 3. Help with device tree conversion of device drivers
>
> =A0 Which drivers do most am335x and beagle clones use? Maybe
> =A0 you can help converting those drivers to use device tree?

USB, GPIO, I2C and SPI are most critical from my perspective.  I need
to figure out which of those already have some owners pushing them
ahead.

> =A0 Sure some drivers depend on regulator framework conversion and
> =A0 the device tree omap_device glue layer, but there are already
> =A0 patches being posted for those

Great.  I guess it makes sense for this tree to include those patches
and hopefully the thrash when they change won't be unbearable.  I
won't know until I start doing it. :-)

>
> Regards,
>
> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
