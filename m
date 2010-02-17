From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/2] dspbridge: proc: fix a double-free on 2 error paths
Date: Tue, 16 Feb 2010 18:24:08 -0600
Message-ID: <4B7B3728.60105@ti.com>
References: <ad3238a4d6769760f2bdbd19b4cde68cd3c79acf.1265991379.git.ext-phil.2.carmody@nokia.com>  <a6ac4fad65b6e1498010962a06429be40aef5e70.1265991379.git.ext-phil.2.carmody@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45865 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933729Ab0BQAYN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 19:24:13 -0500
In-Reply-To: <a6ac4fad65b6e1498010962a06429be40aef5e70.1265991379.git.ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2/12/2010 10:26 AM, Phil Carmody wrote:
> From: Phil Carmody<ext-phil.2.carmody@nokia.com>
>
> We free in the tail cleanup, so don't free before jumping there.
>
> Signed-off-by: Phil Carmody<ext-phil.2.carmody@nokia.com>
> ---

[...]
>   	}
> +
> +	/* paranoid - must be able to kfree this on remaining error paths */
> +	pProcObject->g_pszLastCoff = NULL;
> +

do we need this? afaik it should be NULL at this point, because of 
kmalloc + memset (which btw should be replaced by kzalloc).

i.e:
MEM_AllocObject(pProcObject, struct PROC_OBJECT, PROC_SIGNATURE);
-> MEM_Calloc(sizeof(Obj), MEM_NONPAGED);
->	pMem = kmalloc(...)
	if (pMem)
		memset(pMem, 0, cBytes);

>   	/* Get the default executable for this board... */
>   	DEV_GetDevType(hDevObject, (u32 *)&devType);
>   	pProcObject->uProcessor = devType;
[...]

Regards,

Omar
