From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 2/4] DSPBRIDGE: Heuristic fixes of strlen/malloc out by
 one and termination errors
Date: Fri, 3 Jul 2009 13:55:06 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A2C9D6FF@dlee06.ent.ti.com>
References: <1246544468-14546-1-git-send-email-ameya.palande@nokia.com>
 <1246544468-14546-2-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48276 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755842AbZGCSzL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jul 2009 14:55:11 -0400
In-Reply-To: <1246544468-14546-2-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>


Please see my comments bellow.

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Thursday, July 02, 2009 9:21 AM
> To: linux-omap@vger.kernel.org
> Cc: Guzman Lugo, Fernando; Kanigeri, Hari; ext-phil.2.carmody@nokia.com
> Subject: [PATCH 2/4] DSPBRIDGE: Heuristic fixes of strlen/malloc out by
> one and termination errors
> 
> From: Phil Carmody <ext-phil.2.carmody@nokia.com>
> 
> I say 'heuristic', as I can't prove they're wrong, they just look
> wrong, and for that reason should be given extra close scrutiny.
> These are basically just the old malloc-one-more-than-strlen and
> strncpy-doesn't-write-a-terminal-nil gotchas.
> 
> Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
> ---
>  drivers/dsp/bridge/pmgr/wcd.c  |    7 ++++---
>  drivers/dsp/bridge/rmgr/nldr.c |    3 ++-
>  drivers/dsp/bridge/rmgr/node.c |    5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> index 7732492..00b2770 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -902,7 +902,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>                         temp = (char *) argv[i];
>                         len = strlen_user((char *)temp);
>  			/* Kernel space pointer to argument */
> -			argv[i] = MEM_Alloc(len, MEM_NONPAGED);
> +			argv[i] = MEM_Alloc(len + 1, MEM_NONPAGED);
>  			if (argv[i] == NULL) {
>  				status = DSP_EMEMORY;
>  				break;
> @@ -910,7 +910,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>  			cp_fm_usr(argv[i], temp, status, len);
>  			if (DSP_FAILED(status))
>  				goto func_cont;
> -
> +			argv[i][len] = '\0';

It is ok, what do you think changing len = strlen_user((char *)temp); to len = strlen_user((char *)temp) + 1;? With that cp_fm_usr would copy the null character and it whould replace the change in MEM_Alloc and argv[i][len] = '\0'; 

>  		}
>  	}
>  	/* TODO: validate this */
> @@ -935,7 +935,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>                         temp = (char *)envp[i];
>                         len = strlen_user((char *)temp);
>  			/* Kernel space pointer to argument */
> -			envp[i] = MEM_Alloc(len, MEM_NONPAGED);
> +			envp[i] = MEM_Alloc(len + 1, MEM_NONPAGED);
>  			if (envp[i] == NULL) {
>  				status = DSP_EMEMORY;
>  				break;
> @@ -943,6 +943,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>  			cp_fm_usr(envp[i], temp, status, len);
>  			if (DSP_FAILED(status))
>  				goto func_cont;
> +			envp[i][len] = '\0';
>  		}
>  	}
>  	GT_5trace(WCD_debugMask, GT_ENTER,
> diff --git a/drivers/dsp/bridge/rmgr/nldr.c
> b/drivers/dsp/bridge/rmgr/nldr.c
> index 79f7505..a6a0528 100644
> --- a/drivers/dsp/bridge/rmgr/nldr.c
> +++ b/drivers/dsp/bridge/rmgr/nldr.c
> @@ -1128,7 +1128,8 @@ static DSP_STATUS AddOvlyNode(struct DSP_UUID
> *pUuid,
>  			if (pBuf == NULL) {
>  				status = DSP_EMEMORY;
>  			} else {
> -                               strncpy(pBuf, pNodeName, uLen);
> +				strncpy(pBuf, pNodeName, uLen);
> +				pBuf[uLen] = '\0';

pBuf is allocated using MEM_Calloc which allocates zero-initialized memory so that "pBuf[uLen] = '\0';" is not needed.

>  				hNldr->ovlyTable[hNldr->nNode].pNodeName = pBuf;
>  				hNldr->nNode++;
>  			}
> diff --git a/drivers/dsp/bridge/rmgr/node.c
> b/drivers/dsp/bridge/rmgr/node.c
> index 53a42bf..9f7e4d4 100644
> --- a/drivers/dsp/bridge/rmgr/node.c
> +++ b/drivers/dsp/bridge/rmgr/node.c
> @@ -3272,8 +3272,9 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER
> *hDcdMgr,
>  			if (hNode->pstrDevName == NULL) {
>  				status = DSP_EMEMORY;
>  			} else {
> -                               strncpy(hNode->pstrDevName,
> -					   pndbProps->acName, uLen);
> +				strncpy(hNode->pstrDevName,
> +					pndbProps->acName, uLen);
> +				hNode->pstrDevName[uLen] = '\0';

hNode->pstrDevName is allocated using MEM_Calloc which allocates zero-initialized memory so that "hNode->pstrDevName[uLen] = '\0';" is not needed.

>  			}
>  		}
>  	}
> --
> 1.6.2.4
> 

Regards,
Fernando
Guzman
Lugo.

