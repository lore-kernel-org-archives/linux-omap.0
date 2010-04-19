From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/5v2] DSPBRIDGE: Remove checkpatch warnings: 80 char
 lines
Date: Mon, 19 Apr 2010 17:46:09 -0500
Message-ID: <4BCCDD31.7010101@ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90EC26C7E43@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47890 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731Ab0DSWqQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Apr 2010 18:46:16 -0400
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90EC26C7E43@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Uribe de Leon, Armando" <x0095078@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

On 4/19/2010 5:26 PM, Uribe de Leon, Armando wrote:
[...]
> --- a/drivers/dsp/bridge/rmgr/node.c
> +++ b/drivers/dsp/bridge/rmgr/node.c
> @@ -2450,45 +2450,34 @@ dsp_status node_terminate(struct node_object *hnode, OUT dsp_status *pstatus)
>   		status = (*intf_fxns->pfn_msg_put) (hnode->msg_queue_obj,&msg,
>   						    hnode->utimeout);
>   		/* FIXME */

If you don't mind I'll remove my ambiguous FIXME comment if this patch 
is pushed... this was placed to fix the indentation.

- omar
