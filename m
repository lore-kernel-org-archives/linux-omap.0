From: Olof Johansson <olof@lixom.net>
Subject: Re: Latest OMAP4 build errors
Date: Wed, 7 Mar 2012 14:18:19 -0800
Message-ID: <CAOesGMiNSyc9F+Wf5pXPG=hRAfnG6aMHtccLBwvekuB3HpyevQ@mail.gmail.com>
References: <20120228090209.GC18045@n2100.arm.linux.org.uk>
	<CAK=WgbZEDr_fYSonBQr3XNcTx5vefsH7LJfqycaxsqg-yechWQ@mail.gmail.com>
	<20120306165545.GB15392@n2100.arm.linux.org.uk>
	<201203061701.54141.arnd@arndb.de>
	<20120307100615.GA17404@n2100.arm.linux.org.uk>
	<20120307171044.GE12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39770 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030324Ab2CGWSU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 17:18:20 -0500
Received: by yhmm54 with SMTP id m54so3259828yhm.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 14:18:19 -0800 (PST)
In-Reply-To: <20120307171044.GE12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, Mar 7, 2012 at 9:10 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> Arnd & Olof, some urgent changes are needed, see below.
>
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120307 01:34]:
>> On Tue, Mar 06, 2012 at 05:01:53PM +0000, Arnd Bergmann wrote:
>> > On Tuesday 06 March 2012, Russell King - ARM Linux wrote:
>> > > On Tue, Feb 28, 2012 at 12:11:37PM +0200, Ohad Ben-Cohen wrote:
>> > > > On Tue, Feb 28, 2012 at 12:01 PM, Arnd Bergmann <arnd@arndb.de=
> wrote:
>> > > > > I think 'depends' would be better here, because selecting IO=
MMU_SUPPORT
>> > > > > has other side-effects that a user might not want. It's just=
 as likely
>> > > > > that someone wants to disable IOMMU_SUPPORT and needs to fin=
d OMAP_REMOTEPROC
>> > > > > as wanting to enable OMAP_REMOTEPROC and having to find IOMM=
U_SUPPORT.
>> > > > >
>> > > > > In most cases, the defconfig should just set both.
>> > > >
>> > > > Ok, 'depends on' it is.
>> > >
>> > > We're a week on, which means I now have a full set of 7 builds o=
n the
>> > > website for OMAP4430 all of which have failed in part due to thi=
s
>> > > as yet unresolved problem.
>> > >
>> > > What's happening to get it fixed and those fixes into whatever t=
ree is
>> > > necessary for them (presumably arm-soc)?
>> >
>> > Ohad has sent a series of patches for review and there were no com=
ments
>> > on those. The fix was part of it as far as I remember. I'm still w=
aiting
>> > for a pull request from Ohad.
>>
>> Given that we're coming to the end of what could be the _final_ week
>> before the merge window opens, this is not good news. =A0Read: maybe
>> three days before final.
>>
>> The fact is that OMAP is - yet again - in a totally rotten state in =
terms
>> of what's queued up in the armsoc tree. =A0It is - yet again - compl=
etely
>> unbuildable for many configurations. =A0Just go and have a look at:
>>
>> =A0 =A0 =A0 http://www.arm.linux.org.uk/developer/build/
>>
>> to see what an utterly crappy state OMAP is in again. =A0Last nights=
 build
>> was my tree plus latest arm-soc. =A0Some of those issues have patche=
s (I
>> had been applying one patch manually to the build tree) but that's n=
ot
>> the point - they're not in arm-soc, so the OMAP code in arm-soc is n=
ot
>> yet ready for mainline.
>
> Yes looks like there's an issue with getting urgent patches applied i=
nto
> the arm-soc tree.. The patches to fix these issues are known and
> other issues and warnings should be all sorted out now except for som=
e
> MMC changes that are still being discussed.
>
>> So, as OMAP is soo broken, and as promised after the last merge wind=
ow -
>> I don't want any OMAP stuff going upstream from armsoc until we get =
error
>> free builds from the allno and old configs on the builder.
>
> What I got queued up in fixes-non-critical-part2 should fix all those
> errors and warnings.
>
> Arnd & Olof, I've posted one fix that should be applied to arm-soc tr=
ee
> at [1]. I've also posted a request to revert one commit in arm-soc tr=
ee
> at [2].
>
> As it seems that you did not apply those to arm-soc, please apply the=
m,
> or repull the following two branches ASAP:

Done (repulled the branches). Stephen Rothwell has not surfaced on irc
yet, so hopefully this means it'll make it into today's linux-next.

>
> Re-pull fixes-non-critical containing one revert:
>
> Revert "ARM: OMAP2+: Fix multiple randconfig errors with SOC_OMAP and=
 SOC_OMAP_NOOP"
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes=
-non-critical
>
> Re-pull cleanup again containing one fix:
>
> ARM: OMAP2+: Fix L4_EMU_34XX_BASE error after iomap changes
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap clean=
up
>
> Note that the second one I just pushed, however the patch is known to
> work for the build errors after merging arm-soc with Russell's change=
s.

Looks like you pasted the wrong subject above -- the mail below
contains the patch that you added though so it looked OK to me (the
subject above was the previous top-of-branch before you added the last
one).

> Arnd & Olof, for future, how you want to handle urgent issues like th=
is?

Personally I missed the requests since they ended up in the chain of
replies and I didn't notice them, my mistake. A separate email
requesting pulls or patch application it to arm@kernel.org would
reduce the risk of that happening (Flagging the subject with [URGENT]
wouldn't hurt).


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
