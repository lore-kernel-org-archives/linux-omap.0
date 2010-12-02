From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [GIT PULL] OMAP: mailbox and iommu changes: for-next for v2.6.38
Date: Thu, 2 Dec 2010 08:50:07 -0600
Message-ID: <AANLkTi=iRUD3_dcY47tebHGbxxAOcY61_2MtSVfO8zQB@mail.gmail.com>
References: <AANLkTind+DH5emar2L9EiV-pqpCvQHQGnFevh9Bncrpz@mail.gmail.com>
	<20101202123304.GB10461@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:46904 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757470Ab0LBOuO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 09:50:14 -0500
Received: by fxm14 with SMTP id 14so6793690fxm.9
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 06:50:07 -0800 (PST)
In-Reply-To: <20101202123304.GB10461@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Tony Lindgren <tony@atomide.com>, linux omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 2, 2010 at 6:33 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 02, 2010 at 06:07:23AM -0600, Kanigeri, Hari wrote:
>> Hi Tony,
>>
>> The following changes since commit e8a7e48bb248a1196484d3f8afa53bded=
2b24e71:
>> =A0 Linus Torvalds (1):
>> =A0 =A0 =A0 =A0 Linux 2.6.37-rc4
>>
>> are available in the git repository at:
>>
>> =A0 git://gitorious.org/iommu_mailbox/iommu_mailbox.git for_2.6.38
>>
>> Fernando Guzman Lugo (5):
>> =A0 =A0 =A0 OMAP: mailbox: change full flag per mailbox queue instea=
d of global
>> =A0 =A0 =A0 omap: iovmm - no gap checking for fixed address
>> =A0 =A0 =A0 omap: iovmm - add superpages support to fixed da address
>> =A0 =A0 =A0 omap: iovmm - replace __iounmap with omap_iounmap
>
> This change is wrong. =A0Nothing should be directly referencing omap_=
iounmap
> nor for that matter omap_ioremap. =A0Both are implementation details =
of the
> standard ioremap/iounmap APIs.
>
> Use the official APIs rather than the implementation details behind t=
hem.

if you see where the function is used, you will see that it is not
calling the function, it is use as a parameter in unmap_vm_area(), if
I used iounmap which is a macro there I will get a compilation error.
It was already discuss with Hiroshi. The function unmap_vm_area can be
re-implemented after with other patch to avoid receiving such that
parameter, but now it is important resolve the memory leak and the
kernel warning. Also the same was being done before, using __iounmap,
so using function directly behind iounmap was not introduce with my
patch. If you have a better solution please let me know and I will
change the patch.

Thanks,
=46ernando.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
