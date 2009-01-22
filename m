From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [OMAPZOOM][PATCH]DSPBRIDGE: Change GFP_ATOMIC to GFP_KERNEL
Date: Thu, 22 Jan 2009 15:31:29 +0200 (EET)
Message-ID: <20090122.153129.159079052.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E60284C6C596@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30522 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381AbZAVNdL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 08:33:11 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E60284C6C596@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com, h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, vikram.pandita@ti.com

Hi Fernando,

Actually it's not ok at least with the following part:

drivers/dsp/bridge/wmd/msg_sm.c:
...
188                  (void)SYNC_EnterCS(hMsgMgr->hSyncCS);
			^^^^^^^^^^^^^^^^^^
189                  /* Initialize message frames and put in appropriate queues */
190                  for (i = 0; i < uMaxMsgs && DSP_SUCCEEDED(status); i++) {
191                          status = AddNewMsg(hMsgMgr->msgFreeList);
192                          if (DSP_SUCCEEDED(status)) {
193                                  uNumAllocated++;

It causes:

 BUG: sleeping function called from invalid context at mm/slab.c:3044

We need to extend "MEM_POOLATTRS" as Hari suggested originally.

   Hiroshi DOYU

From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [OMAPZOOM][PATCH]DSPBRIDGE: Change GFP_ATOMIC to GFP_KERNEL
Date: Wed, 21 Jan 2009 18:46:01 -0600

> 
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Wed, 21 Jan 2009 17:39:38 -0600
> Subject: [PATCH] BRIDGE: Change GFP_ATOMIC to GFP_KERNEL
> 
> This patch replace the memory allocations which use
> GFP_ATOMIC with GFP_KERNEL since the calls for memory
> allocation in dspbridge are not in interrupt context.
> 
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> ---
>  drivers/dsp/bridge/services/mem.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
> index 9256744..95efe92
> --- a/drivers/dsp/bridge/services/mem.c
> +++ b/drivers/dsp/bridge/services/mem.c
> @@ -281,10 +281,10 @@ void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
>  		/* If non-paged memory required, see note at top of file. */
>  		case MEM_PAGED:
>  #ifndef MEM_CHECK
> -			pMem = kmalloc(cBytes, GFP_ATOMIC);
> +			pMem = kmalloc(cBytes, GFP_KERNEL);
>  #else
>  			pMem = kmalloc(cBytes + sizeof(struct memInfo),
> -			       GFP_ATOMIC);
> +			       GFP_KERNEL);
>  			if (pMem) {
>  				pMem->size = cBytes;
>  				pMem->caller = __builtin_return_address(0);
> @@ -303,11 +303,11 @@ void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
>  		case MEM_LARGEVIRTMEM:
>  #ifndef MEM_CHECK
>  			/* FIXME - Replace with 'vmalloc' after BP fix */
> -			pMem = __vmalloc(cBytes, GFP_ATOMIC, PAGE_KERNEL);
> +			pMem = __vmalloc(cBytes, GFP_KERNEL, PAGE_KERNEL);
>  #else
>  			/* FIXME - Replace with 'vmalloc' after BP fix */
>  			pMem = __vmalloc((cBytes + sizeof(struct memInfo)),
> -				GFP_ATOMIC, PAGE_KERNEL);
> +				GFP_KERNEL, PAGE_KERNEL);
>  			if (pMem) {
>  				pMem->size = cBytes;
>  				pMem->caller = __builtin_return_address(0);
> @@ -357,7 +357,7 @@ void *MEM_AllocPhysMem(u32 cBytes, u32 ulAlign, OUT u32 *pPhysicalAddress)
>  						    (u32 *)&paMem);
>  		} else
>  			pVaMem = dma_alloc_coherent(NULL, cBytes, &paMem,
> -						   GFP_ATOMIC);
> +						   GFP_KERNEL);
>  		if (pVaMem == NULL) {
>  			*pPhysicalAddress = 0;
>  			GT_1trace(MEM_debugMask, GT_6CLASS,
> @@ -389,13 +389,13 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
>  		/* If non-paged memory required, see note at top of file. */
>  		case MEM_PAGED:
>  #ifndef MEM_CHECK
> -			pMem = kmalloc(cBytes, GFP_ATOMIC);
> +			pMem = kmalloc(cBytes, GFP_KERNEL);
>  			if (pMem)
>  				memset(pMem, 0, cBytes);
>  
>  #else
>  			pMem = kmalloc(cBytes + sizeof(struct memInfo),
> -				      GFP_ATOMIC);
> +				      GFP_KERNEL);
>  			if (pMem) {
>  				memset((void *)((u32)pMem +
>  					sizeof(struct memInfo)), 0, cBytes);
> @@ -414,14 +414,14 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
>  		case MEM_LARGEVIRTMEM:
>  #ifndef MEM_CHECK
>  			/* FIXME - Replace with 'vmalloc' after BP fix */
> -			pMem = __vmalloc(cBytes, GFP_ATOMIC, PAGE_KERNEL);
> +			pMem = __vmalloc(cBytes, GFP_KERNEL, PAGE_KERNEL);
>  			if (pMem)
>  				memset(pMem, 0, cBytes);
>  
>  #else
>  			/* FIXME - Replace with 'vmalloc' after BP fix */
>  			pMem = __vmalloc(cBytes + sizeof(struct memInfo),
> -				GFP_ATOMIC, PAGE_KERNEL);
> +				GFP_KERNEL, PAGE_KERNEL);
>  			if (pMem) {
>  				memset((void *)((u32)pMem +
>  					sizeof(struct memInfo)), 0, cBytes);
> -- 
> 1.5.6.4
