From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [GIT PULL] OMAP: mailbox and iommu changes: for-next for v2.6.38
Date: Mon, 13 Dec 2010 11:31:35 -0600
Message-ID: <AANLkTinBrEyxJyDid6s3jW5S3ZemNnJ7JHk6ziAV072n@mail.gmail.com>
References: <AANLkTind+DH5emar2L9EiV-pqpCvQHQGnFevh9Bncrpz@mail.gmail.com>
	<20101202123304.GB10461@n2100.arm.linux.org.uk>
	<AANLkTi=iRUD3_dcY47tebHGbxxAOcY61_2MtSVfO8zQB@mail.gmail.com>
	<20101202152053.GC10461@n2100.arm.linux.org.uk>
	<AANLkTi=01qGO6pX15n_w-W4RaaXsK3u697UQ9pD_DuvW@mail.gmail.com>
	<AANLkTim641hqqyCczMPN_rDvVH_dqV0voQLFhQsrQLY3@mail.gmail.com>
	<20101212112050.GA8777@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40709 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758495Ab0LMRbj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 12:31:39 -0500
Received: by mail-pw0-f41.google.com with SMTP id 8so890896pwj.0
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 09:31:35 -0800 (PST)
In-Reply-To: <20101212112050.GA8777@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Sun, Dec 12, 2010 at 5:20 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 06, 2010 at 09:16:23AM -0600, Kanigeri, Hari wrote:
>> Ruseell,
>>
>> On Thu, Dec 2, 2010 at 9:43 AM, Guzman Lugo, Fernando
>> <fernando.lugo@ti.com> wrote:
>> > On Thu, Dec 2, 2010 at 9:20 AM, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> >> On Thu, Dec 02, 2010 at 08:50:07AM -0600, Guzman Lugo, Fernando w=
rote:
>> >>> On Thu, Dec 2, 2010 at 6:33 AM, Russell King - ARM Linux
>> >>> <linux@arm.linux.org.uk> wrote:
>> >>> > On Thu, Dec 02, 2010 at 06:07:23AM -0600, Kanigeri, Hari wrote=
:
>> >>> >> Hi Tony,
>> >>> >>
>> >>> >> The following changes since commit e8a7e48bb248a1196484d3f8af=
a53bded2b24e71:
>> >>> >> =A0 Linus Torvalds (1):
>> >>> >> =A0 =A0 =A0 =A0 Linux 2.6.37-rc4
>> >>> >>
>> >>> >> are available in the git repository at:
>> >>> >>
>> >>> >> =A0 git://gitorious.org/iommu_mailbox/iommu_mailbox.git for_2=
=2E6.38
>> >>> >>
>> >>> >> Fernando Guzman Lugo (5):
>> >>> >> =A0 =A0 =A0 OMAP: mailbox: change full flag per mailbox queue=
 instead of global
>> >>> >> =A0 =A0 =A0 omap: iovmm - no gap checking for fixed address
>> >>> >> =A0 =A0 =A0 omap: iovmm - add superpages support to fixed da =
address
>> >>> >> =A0 =A0 =A0 omap: iovmm - replace __iounmap with omap_iounmap
>> >>> >
>> >>> > This change is wrong. =A0Nothing should be directly referencin=
g omap_iounmap
>> >>> > nor for that matter omap_ioremap. =A0Both are implementation d=
etails of the
>> >>> > standard ioremap/iounmap APIs.
>> >>> >
>> >>> > Use the official APIs rather than the implementation details b=
ehind them.
>> >>>
>> >>> if you see where the function is used, you will see that it is n=
ot
>> >>> calling the function, it is use as a parameter in unmap_vm_area(=
), if
>> >>> I used iounmap which is a macro there I will get a compilation e=
rror.
>> >>
>> >> Hmm, yes, because iounmap() is defined as a macro rather than iou=
nmap.
>> >>
>> >> The solution to this is to fix iounmap and __arch_iounmap macros =
so
>> >> they aren't macros which take arguments. =A0That will then allow =
them
>> >> to be used in the way you desire.
>> >
>> > yes, that way it can be used in the function parameter. what is th=
e
>> > right thing to do?
>> > 1) You send your patch and then I send the new version of the patc=
hes.
>> > 2) I make a new series of the patches with the change to iounmap a=
nd I
>> > include your patch in the series.
>> >
>>
>> Can you please suggest the approach we take here ? So, either you se=
nd
>> your suggested change as a patch and Fernando's patch will be based =
on
>> it, or he can take a TODO action item to patch again if you plan to
>> send this change later.
>
> Right, the patches are in my git tree, under the 'io' branch:
>
> =A0http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6=
-arm.git io
>
> which you can use to base stuff off of. =A0Make sure your tree has co=
mmits
> up to 2.6.37-rc5 before pulling to avoid grabbing MB's of pack files.
>


Thanks, Russell.

=46ernando, can you please rebase your patches based on Russell's patch=
=2E
I will take care of queuing up the patches for git pull request.


Thank you,
Best regards,
Hari Kanigeri
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
