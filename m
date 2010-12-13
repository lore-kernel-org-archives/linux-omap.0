From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [GIT PULL] OMAP: mailbox and iommu changes: for-next for v2.6.38
Date: Mon, 13 Dec 2010 17:02:12 -0600
Message-ID: <AANLkTi=y5t3Q0MAh-m=cKn98wQDGLaW_Ppt2hB+Cqo2E@mail.gmail.com>
References: <AANLkTind+DH5emar2L9EiV-pqpCvQHQGnFevh9Bncrpz@mail.gmail.com>
	<20101202123304.GB10461@n2100.arm.linux.org.uk>
	<AANLkTi=iRUD3_dcY47tebHGbxxAOcY61_2MtSVfO8zQB@mail.gmail.com>
	<20101202152053.GC10461@n2100.arm.linux.org.uk>
	<AANLkTi=01qGO6pX15n_w-W4RaaXsK3u697UQ9pD_DuvW@mail.gmail.com>
	<AANLkTim641hqqyCczMPN_rDvVH_dqV0voQLFhQsrQLY3@mail.gmail.com>
	<20101212112050.GA8777@n2100.arm.linux.org.uk>
	<AANLkTinBrEyxJyDid6s3jW5S3ZemNnJ7JHk6ziAV072n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:32916 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753993Ab0LMXCP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 18:02:15 -0500
Received: by mail-fx0-f49.google.com with SMTP id 19so12375fxm.22
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 15:02:13 -0800 (PST)
In-Reply-To: <AANLkTinBrEyxJyDid6s3jW5S3ZemNnJ7JHk6ziAV072n@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, Dec 13, 2010 at 11:31 AM, Kanigeri, Hari <h-kanigeri2@ti.com> w=
rote:
> On Sun, Dec 12, 2010 at 5:20 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Dec 06, 2010 at 09:16:23AM -0600, Kanigeri, Hari wrote:
>>> Ruseell,
>>>
>>> On Thu, Dec 2, 2010 at 9:43 AM, Guzman Lugo, Fernando
>>> <fernando.lugo@ti.com> wrote:
>>> > On Thu, Dec 2, 2010 at 9:20 AM, Russell King - ARM Linux
>>> > <linux@arm.linux.org.uk> wrote:
>>> >> On Thu, Dec 02, 2010 at 08:50:07AM -0600, Guzman Lugo, Fernando =
wrote:
>>> >>> On Thu, Dec 2, 2010 at 6:33 AM, Russell King - ARM Linux
>>> >>> <linux@arm.linux.org.uk> wrote:
>>> >>> > On Thu, Dec 02, 2010 at 06:07:23AM -0600, Kanigeri, Hari wrot=
e:
>>> >>> >> Hi Tony,
>>> >>> >>
>>> >>> >> The following changes since commit e8a7e48bb248a1196484d3f8a=
fa53bded2b24e71:
>>> >>> >> =A0 Linus Torvalds (1):
>>> >>> >> =A0 =A0 =A0 =A0 Linux 2.6.37-rc4
>>> >>> >>
>>> >>> >> are available in the git repository at:
>>> >>> >>
>>> >>> >> =A0 git://gitorious.org/iommu_mailbox/iommu_mailbox.git for_=
2.6.38
>>> >>> >>
>>> >>> >> Fernando Guzman Lugo (5):
>>> >>> >> =A0 =A0 =A0 OMAP: mailbox: change full flag per mailbox queu=
e instead of global
>>> >>> >> =A0 =A0 =A0 omap: iovmm - no gap checking for fixed address
>>> >>> >> =A0 =A0 =A0 omap: iovmm - add superpages support to fixed da=
 address
>>> >>> >> =A0 =A0 =A0 omap: iovmm - replace __iounmap with omap_iounma=
p
>>> >>> >
>>> >>> > This change is wrong. =A0Nothing should be directly referenci=
ng omap_iounmap
>>> >>> > nor for that matter omap_ioremap. =A0Both are implementation =
details of the
>>> >>> > standard ioremap/iounmap APIs.
>>> >>> >
>>> >>> > Use the official APIs rather than the implementation details =
behind them.
>>> >>>
>>> >>> if you see where the function is used, you will see that it is =
not
>>> >>> calling the function, it is use as a parameter in unmap_vm_area=
(), if
>>> >>> I used iounmap which is a macro there I will get a compilation =
error.
>>> >>
>>> >> Hmm, yes, because iounmap() is defined as a macro rather than io=
unmap.
>>> >>
>>> >> The solution to this is to fix iounmap and __arch_iounmap macros=
 so
>>> >> they aren't macros which take arguments. =A0That will then allow=
 them
>>> >> to be used in the way you desire.
>>> >
>>> > yes, that way it can be used in the function parameter. what is t=
he
>>> > right thing to do?
>>> > 1) You send your patch and then I send the new version of the pat=
ches.
>>> > 2) I make a new series of the patches with the change to iounmap =
and I
>>> > include your patch in the series.
>>> >
>>>
>>> Can you please suggest the approach we take here ? So, either you s=
end
>>> your suggested change as a patch and Fernando's patch will be based=
 on
>>> it, or he can take a TODO action item to patch again if you plan to
>>> send this change later.
>>
>> Right, the patches are in my git tree, under the 'io' branch:
>>
>> =A0http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.=
6-arm.git io


I tried to clone it but after sometime it fails, I tried to used
git:// but it did not work and know behind a http proxy it is getting
"The requested URL returned error: 500" do someone know if I need
something special to clone it?

Regards,
=46ernando.

>>
>> which you can use to base stuff off of. =A0Make sure your tree has c=
ommits
>> up to 2.6.37-rc5 before pulling to avoid grabbing MB's of pack files=
=2E
>>
>
>
> Thanks, Russell.
>
> Fernando, can you please rebase your patches based on Russell's patch=
=2E
> I will take care of queuing up the patches for git pull request.
>
>
> Thank you,
> Best regards,
> Hari Kanigeri
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
