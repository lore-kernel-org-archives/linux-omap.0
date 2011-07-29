From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC/PATCH 0/7] decouple platform_device from omap_device
Date: Fri, 29 Jul 2011 16:59:38 -0700
Message-ID: <87hb64ocyd.fsf@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<20110727140457.GA8558@manju-desktop>
	<CALyTGODe8r9zr4fA+AX=-XhpLjNXKtfHzxFUWMNSehDawEDMBA@mail.gmail.com>
	<20110728045057.GA31297@manju-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:39174 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752960Ab1G2X7o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 19:59:44 -0400
Received: by iyi12 with SMTP id 12so5922937iyi.2
        for <linux-omap@vger.kernel.org>; Fri, 29 Jul 2011 16:59:43 -0700 (PDT)
In-Reply-To: <20110728045057.GA31297@manju-desktop> (Manjunath Kondaiah G.'s
	message of "Thu, 28 Jul 2011 10:20:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> On Wed, Jul 27, 2011 at 02:45:33PM -0700, Hilman, Kevin wrote:
>> Hi Manjunath,
>>=20
>> On Wed, Jul 27, 2011 at 7:04 AM, G, Manjunath Kondaiah <manjugk@ti.c=
om> wrote:
>> > Kevin,
>> >
>> > On Thu, Jul 21, 2011 at 04:52:10PM -0700, Kevin Hilman wrote:
>> >> Here's a first whack, proof-of-concept on how we could start to
>> >> decouple the platform_device from an omap_device.
>> >>
>> >> The main RFC is in the last patch, and everything leading up to i=
t are
>> >> misc. omap_device cleanups that make the last patch cleaner and
>> >> clearer. =C2=A0It's really the last patch that does the decouplin=
g.
>> >>
>> >> This will be necessary if we're going to decouple the platform_de=
vice
>> >> creation from the omap_device/omap_hwmod creation etc. =C2=A0This=
 patch
>> >> leaves them both done in omap_device_build(), but shows that they=
 can
>> >> be decoupled.
>> > Can you pls mention baseline used for these patches? I tried apply=
ing on
>> > latest mainline, v3.0 and =C2=A0git://git.pwsan.com/linux-2.6 prcm=
-devel-3.1
>>=20
>> Oops, sorry.  I forgot to mention it.
>>=20
>> Due to some misc. dependencies (mainly on Beagle board file), I've
>> temporarily based it on the for-next branch of the arm-soc tree[1]
>> since that has everything already queued for the next merge window. =
I
>> also based it on the omap_device patch I posted which changes the pr=
_*
>> prints to dev_*.
>>=20
>> For convenience, I've pushed this series to the 'wip/od-devres' bran=
ch
>> of my tree[2].
>>=20
>> Sorry for the confusion,
>>=20
>> Kevin
>>=20
>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.=
git
>>=20
>> [2] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap=
-pm.git
>
> This series results in boot crash. However, it boots fine without thi=
s
> series.  I have not tried to debug but it looks like from boot log,
> the res structure has invalid entries in mmc probe. As mentioned by
> Grant in 7/7, the scope of devres is not lifetime hence it needs to b=
e
> fixed.

This limitation was also clearly described in the changelog of patch
7/7.

However, I don't think that problem should cause a problem on boot, onl=
y
a from the driver core (which, suprisingly,  I don't see in your bootlo=
g.)

I suspect your crash is because you're not also testing with the MMC
runtime PM series that is merging for v3.1.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
