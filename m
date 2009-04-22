From: pramod gurav <pramodforum@gmail.com>
Subject: Re: dma_alloc_coherent fragmentation
Date: Wed, 22 Apr 2009 13:53:51 +0530
Message-ID: <f502236f0904220123i6d278fdcj34abca9a7f6d8356@mail.gmail.com>
References: <DFEF307E035C8647B119E6A60DB62D4A01793E6773@dlee02.ent.ti.com>
	 <20090319.084248.183029086.Hiroshi.DOYU@nokia.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF643980@dlee02.ent.ti.com>
	 <f502236f0904220046s50ff816cse752798deb895759@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F5F2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:52420 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbZDVIXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 04:23:53 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1384266yxj.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 01:23:51 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F5F2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks for the quick reply.
Can you please point me to some links on DMA pools. I am just blank on this. :(
I will still search for this in net.
-- 
Best Regards
Pramod

On Wed, Apr 22, 2009 at 1:20 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> DMA pool is better solution for such usecases.
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of pramod gurav
>> Sent: Wednesday, April 22, 2009 1:17 PM
>> To: Menon, Nishanth
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: dma_alloc_coherent fragmentation
>>
>> Hi Nishant,
>> I am facing the same problem to allocate a chunk of 4MB on omap3evm
>> using dma_alloc_coherent. I used the test driver mentioned here
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg11074.html
>>
>> I applied the patch for
>> ioremap(24f11ec001920f1cfaeeed8e8b55725d900bbb56) suggested by
>> Russell, but stiill seeing the error saying
>>
>> coherent allocation too big (requested 0x400000 mask 0xffffffff)
>> alloc[0] - virt=0x00000000 phy=0xFFFFFFFF size=0x00400000
>> Allocation failed idx=0
>> insmod: cannot insert `dummy.ko': Cannot allocate memory (-1): Cannot
>> allocate memory
>>
>> I changed the GFP_KERNEL to GFP_TEMPORARY and also to (GFP_KERNEL |
>> __GFP_RECLAIMABLE), but failed to insmod the module.
>> I am working on linux-omap 2.6.28 kernel. Even I could not allocate
>> memory size greater than 1MB.
>> Has this been fixed? Are there any patches to fix this issue?
>>
>> On Thu, Mar 19, 2009 at 2:36 PM, Menon, Nishanth <nm@ti.com> wrote:
>
