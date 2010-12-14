From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [GIT PULL] OMAP: mailbox and iommu changes: for-next for v2.6.38
Date: Mon, 13 Dec 2010 19:37:32 -0600
Message-ID: <AANLkTi=5JA8phbyVG=rFZujRsEDCSF0znWQ0iPHLgOdj@mail.gmail.com>
References: <AANLkTind+DH5emar2L9EiV-pqpCvQHQGnFevh9Bncrpz@mail.gmail.com>
	<20101202123304.GB10461@n2100.arm.linux.org.uk>
	<AANLkTi=iRUD3_dcY47tebHGbxxAOcY61_2MtSVfO8zQB@mail.gmail.com>
	<20101202152053.GC10461@n2100.arm.linux.org.uk>
	<AANLkTi=01qGO6pX15n_w-W4RaaXsK3u697UQ9pD_DuvW@mail.gmail.com>
	<AANLkTim641hqqyCczMPN_rDvVH_dqV0voQLFhQsrQLY3@mail.gmail.com>
	<20101212112050.GA8777@n2100.arm.linux.org.uk>
	<AANLkTinBrEyxJyDid6s3jW5S3ZemNnJ7JHk6ziAV072n@mail.gmail.com>
	<AANLkTi=y5t3Q0MAh-m=cKn98wQDGLaW_Ppt2hB+Cqo2E@mail.gmail.com>
	<20101214000219.GA10528@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:38034 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758901Ab0LNBhf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 20:37:35 -0500
Received: by fxm11 with SMTP id 11so117033fxm.29
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 17:37:33 -0800 (PST)
In-Reply-To: <20101214000219.GA10528@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Tony Lindgren <tony@atomide.com>, linux omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, Dec 13, 2010 at 6:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 13, 2010 at 05:02:12PM -0600, Guzman Lugo, Fernando wrote=
:
>> On Mon, Dec 13, 2010 at 11:31 AM, Kanigeri, Hari <h-kanigeri2@ti.com=
> wrote:
>> > On Sun, Dec 12, 2010 at 5:20 AM, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> >> On Mon, Dec 06, 2010 at 09:16:23AM -0600, Kanigeri, Hari wrote:
>> >>> Ruseell,
>> >>>
>> >>> On Thu, Dec 2, 2010 at 9:43 AM, Guzman Lugo, Fernando
>> >>> <fernando.lugo@ti.com> wrote:
>> >>> > On Thu, Dec 2, 2010 at 9:20 AM, Russell King - ARM Linux
>> >>> > <linux@arm.linux.org.uk> wrote:
>> >>> >> On Thu, Dec 02, 2010 at 08:50:07AM -0600, Guzman Lugo, Fernan=
do wrote:
>> >>> >>> On Thu, Dec 2, 2010 at 6:33 AM, Russell King - ARM Linux
>> >>> >>> <linux@arm.linux.org.uk> wrote:
>> >>> >>> > On Thu, Dec 02, 2010 at 06:07:23AM -0600, Kanigeri, Hari w=
rote:
>> >>> >>> >> Hi Tony,
>> >>> >>> >>
>> >>> >>> >> The following changes since commit e8a7e48bb248a1196484d3=
f8afa53bded2b24e71:
>> >>> >>> >> =A0 Linus Torvalds (1):
>> >>> >>> >> =A0 =A0 =A0 =A0 Linux 2.6.37-rc4
>> >>> >>> >>
>> >>> >>> >> are available in the git repository at:
>> >>> >>> >>
>> >>> >>> >> =A0 git://gitorious.org/iommu_mailbox/iommu_mailbox.git f=
or_2.6.38
>> >>> >>> >>
>> >>> >>> >> Fernando Guzman Lugo (5):
>> >>> >>> >> =A0 =A0 =A0 OMAP: mailbox: change full flag per mailbox q=
ueue instead of global
>> >>> >>> >> =A0 =A0 =A0 omap: iovmm - no gap checking for fixed addre=
ss
>> >>> >>> >> =A0 =A0 =A0 omap: iovmm - add superpages support to fixed=
 da address
>> >>> >>> >> =A0 =A0 =A0 omap: iovmm - replace __iounmap with omap_iou=
nmap
>> >>> >>> >
>> >>> >>> > This change is wrong. =A0Nothing should be directly refere=
ncing omap_iounmap
>> >>> >>> > nor for that matter omap_ioremap. =A0Both are implementati=
on details of the
>> >>> >>> > standard ioremap/iounmap APIs.
>> >>> >>> >
>> >>> >>> > Use the official APIs rather than the implementation detai=
ls behind them.
>> >>> >>>
>> >>> >>> if you see where the function is used, you will see that it =
is not
>> >>> >>> calling the function, it is use as a parameter in unmap_vm_a=
rea(), if
>> >>> >>> I used iounmap which is a macro there I will get a compilati=
on error.
>> >>> >>
>> >>> >> Hmm, yes, because iounmap() is defined as a macro rather than=
 iounmap.
>> >>> >>
>> >>> >> The solution to this is to fix iounmap and __arch_iounmap mac=
ros so
>> >>> >> they aren't macros which take arguments. =A0That will then al=
low them
>> >>> >> to be used in the way you desire.
>> >>> >
>> >>> > yes, that way it can be used in the function parameter. what i=
s the
>> >>> > right thing to do?
>> >>> > 1) You send your patch and then I send the new version of the =
patches.
>> >>> > 2) I make a new series of the patches with the change to iounm=
ap and I
>> >>> > include your patch in the series.
>> >>> >
>> >>>
>> >>> Can you please suggest the approach we take here ? So, either yo=
u send
>> >>> your suggested change as a patch and Fernando's patch will be ba=
sed on
>> >>> it, or he can take a TODO action item to patch again if you plan=
 to
>> >>> send this change later.
>> >>
>> >> Right, the patches are in my git tree, under the 'io' branch:
>> >>
>> >> =A0http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux=
-2.6-arm.git io
>>
>>
>> I tried to clone it but after sometime it fails, I tried to used
>> git:// but it did not work and know behind a http proxy it is gettin=
g
>> "The requested URL returned error: 500" do someone know if I need
>> something special to clone it?
>
> Sigh.
>
> Someone has helpfully upgraded apache on the machine at about 8pm, bu=
t
> failed to check that it was running afterwards (it's now midnight.)
>
> I've just restarted it, so it should work now.

Thanks it is working now :).

Regards,
=46ernando.

>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
