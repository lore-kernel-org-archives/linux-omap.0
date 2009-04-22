From: pramod gurav <pramodforum@gmail.com>
Subject: Re: dma_alloc_coherent fragmentation
Date: Wed, 22 Apr 2009 13:16:34 +0530
Message-ID: <f502236f0904220046s50ff816cse752798deb895759@mail.gmail.com>
References: <DFEF307E035C8647B119E6A60DB62D4A01793E6773@dlee02.ent.ti.com>
	 <20090319.084248.183029086.Hiroshi.DOYU@nokia.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF643980@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:16653 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbZDVHqf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 03:46:35 -0400
Received: by an-out-0708.google.com with SMTP id d40so1493315and.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 00:46:34 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF643980@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Nishant,
I am facing the same problem to allocate a chunk of 4MB on omap3evm
using dma_alloc_coherent. I used the test driver mentioned here
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg11074.html

I applied the patch for
ioremap(24f11ec001920f1cfaeeed8e8b55725d900bbb56) suggested by
Russell, but stiill seeing the error saying

coherent allocation too big (requested 0x400000 mask 0xffffffff)
alloc[0] - virt=3D0x00000000 phy=3D0xFFFFFFFF size=3D0x00400000
Allocation failed idx=3D0
insmod: cannot insert `dummy.ko': Cannot allocate memory (-1): Cannot
allocate memory

I changed the GFP_KERNEL to GFP_TEMPORARY and also to (GFP_KERNEL |
__GFP_RECLAIMABLE), but failed to insmod the module.
I am working on linux-omap 2.6.28 kernel. Even I could not allocate
memory size greater than 1MB.
Has this been fixed? Are there any patches to fix this issue?

On Thu, Mar 19, 2009 at 2:36 PM, Menon, Nishanth <nm@ti.com> wrote:
> Hi Hiroshi,
>> -----Original Message-----
>> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
>> Sent: Thursday, March 19, 2009 8:43 AM
>
>>
>>
>> What would happen with __GFP_RECLAIMABLE for dma_alloc_coherent()?
> As per [1], GFP_TEMPORARY might be the right approach.. but yes,
> Changing dummy to do:
> dma_alloc_coherent(NULL, b[i].size, &b[i].phy, GFP_TEMPORARY);
>
> Seems to resolve the issue with the dummy driver.
>
> The question however still remains: For a driver to allocate a memory=
 which is not temporary in nature we'd recommend GFP_KERNEL. But as par=
t of the exit sequence the driver will deallocate that memory and as pa=
rt of init sequence, reallocate. Given that the memory is not reclaimed=
 immediately, it looks like the only way to ensure that would be to do =
GFP_KERNEL | __GFP_RECLAIMABLE (which essentially is the definition of =
GFP_TEMPORARY).
>
> Regards,
> Nishanth Menon
> Ref:
> [1] http://lkml.indiana.edu/hypermail/linux/kernel/0705.2/0638.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Best Regards
Pramod
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
