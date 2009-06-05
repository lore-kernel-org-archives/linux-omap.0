From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: FW: [PATCH] DSPBRIDGE: Buffer size warning fixes
Date: Fri, 05 Jun 2009 15:35:51 +0300
Message-ID: <4A291127.3000508@nokia.com>
References: <496565EC904933469F292DDA3F1663E602931073CA@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43685 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbZFEMfk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 08:35:40 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602931073CA@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Hi Fernando,

Thanks for your comments!
Sorry for my delayed reply.
I have modified the patch and will send it as reply to the original posting.

Cheers,
Ameya.

ext Guzman Lugo, Fernando wrote:
> Looping in linux-omap.
> 
> -----Original Message-----
> From: Guzman Lugo, Fernando 
> Sent: Thursday, May 21, 2009 12:14 PM
> To: 'Ameya Palande'
> Cc: Kanigeri, Hari
> Subject: RE: [PATCH] DSPBRIDGE: Buffer size warning fixes
> 
> 
> Hi Ameya,
> 
> 	What is the problem that this patch resolves, I think you want to left the last byte of the string for the end of string character '\0', so avoid when we strncpy generates a not null-terminated string when the src string has a length >= COD_MAXPATHLENGTH. However the patch doesn’t fix this problem unless when we declared an array it is zero-initialized but I don’t think so.
> 
> Example without this patch
> 
>                               COD_MAXPATHLENGTH limit
>                                     ↓
> Src string      .....abcdefghijklmnop qst...
> Dst String      .....abcdefghijklmnop  <- not null-terminated esting 
> 
> Example with this patch
>                               COD_MAXPATHLENGTH limit
>                                     ↓
> Src string      .....abcdefghijklmnop qst...
> Dst String      .....abcdefghijklmno   <- Also not null-terminated string
>                                    ↑
>                               We copy COD_MAXPATHLENGTH - 1 
>                               The last character of the array
>                               wouldn’t be ‘\0’
>                               It would be garbage
> 
> Maybe to resolve that problem we could do:
> } else {
> 
>             /* hang onto the library for subsequent sym table usage */
>             hMgr->baseLib = lib;
>             strncpy(hMgr->szZLFile, pszCoffPath, COD_MAXPATHLENGTH);
>             if (strlen(pszCoffPath) >= COD_MAXPATHLENGTH)
>                   hMgr->szZLFile[COD_MAXPATHLENGTH -1] = ‘\0’;
> 
>       }
> 
> Please let me know what you think or if this patch resolve something else.
> 
> Regards,
> Fernando.
> 
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ameya Palande
> Sent: Tuesday, May 19, 2009 5:49 AM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH] DSPBRIDGE: Buffer size warning fixes
> 
> From: Ameya Palande <ameya.palande@nokia.com>
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  drivers/dsp/bridge/pmgr/cod.c        |    2 +-
>  drivers/dsp/bridge/rmgr/drv.c        |    2 +-
>  drivers/dsp/bridge/services/regsup.c |    4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
> index 6363f1e..5094201 100644
> --- a/drivers/dsp/bridge/pmgr/cod.c
> +++ b/drivers/dsp/bridge/pmgr/cod.c
> @@ -628,7 +628,7 @@ DSP_STATUS COD_OpenBase(struct COD_MANAGER *hMgr, IN char *pszCoffPath,
>  	} else {
>  		/* hang onto the library for subsequent sym table usage */
>  		hMgr->baseLib = lib;
> -               strncpy(hMgr->szZLFile, pszCoffPath, COD_MAXPATHLENGTH);
> +		strncpy(hMgr->szZLFile, pszCoffPath, COD_MAXPATHLENGTH - 1);
>  	}
>  
>  	return status;
> diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
> index 256ce12..60ca054 100644
> --- a/drivers/dsp/bridge/rmgr/drv.c
> +++ b/drivers/dsp/bridge/rmgr/drv.c
> @@ -1510,7 +1510,7 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)
>  		if (pszdevNode) {
>  			LST_InitElem(&pszdevNode->link);
>                         strncpy((char *) pszdevNode->szString,
> -				 (char *)dwContext, MAXREGPATHLENGTH);
> +				 (char *)dwContext, MAXREGPATHLENGTH - 1);
>  			/* Update the Driver Object List */
>  			*pDevNodeString = (u32)pszdevNode->szString;
>  			LST_PutTail(pDRVObject->devNodeString,
> diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
> index 5251b68..b0c6e00 100644
> --- a/drivers/dsp/bridge/services/regsup.c
> +++ b/drivers/dsp/bridge/services/regsup.c
> @@ -238,8 +238,8 @@ DSP_STATUS regsupSetValue(char *valName, void *pBuf, u32 dataSize)
>  		/*  No match, need to make a new entry  */
>  		/*  First check to see if we can make any more entries.  */
>  		if (pRegKey->numValueEntries < BRIDGE_MAX_NUM_REG_ENTRIES) {
> -                       strncpy(pRegKey->values[pRegKey->numValueEntries].name,
> -                               valName, BRIDGE_MAX_NAME_SIZE);
> +			strncpy(pRegKey->values[pRegKey->numValueEntries].name,
> +					valName, BRIDGE_MAX_NAME_SIZE - 1);
>  			pRegKey->values[pRegKey->numValueEntries].pData =
>  					MEM_Alloc(dataSize, MEM_NONPAGED);
>  			if (pRegKey->values[pRegKey->numValueEntries].pData !=

