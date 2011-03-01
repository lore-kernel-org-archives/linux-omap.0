From: archit taneja <archit@ti.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Functions to request/release DSI VCs
Date: Tue, 1 Mar 2011 12:32:47 +0530
Message-ID: <4D6C9A17.3090200@ti.com>
References: <1298882849-7432-1-git-send-email-archit@ti.com>	 <1298882849-7432-2-git-send-email-archit@ti.com> <1298897516.9809.48.camel@deskari> <4D6C814C.5070307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43775 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755207Ab1CAG77 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 01:59:59 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p216xutH002826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 00:59:58 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p216xtNt021926
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 12:29:55 +0530 (IST)
In-Reply-To: <4D6C814C.5070307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tuesday 01 March 2011 10:47 AM, Taneja, Archit wrote:
> Hi,
>
> On Monday 28 February 2011 06:21 PM, Valkeinen, Tomi wrote:
>> On Mon, 2011-02-28 at 02:47 -0600, Taneja, Archit wrote:
>>> Introduce functions which request and release VC's. This will be used in panel
>>> drivers in their probes.
>>>
>>> omap_dsi_request_vc() takes in the pointer to the omap_dss_device, the VC_ID
>>> parameter which goes into the header of the DSI packets, and returns a Virtual
>>> channel number (or virtual channel register set) which it can use.
>>>
>>> omap_dsi_releae_vc() takes the omap_dss_device pointer and frees all VCs which
>>> were used by that device.
>>>
>>> Initialisation of VC parameters is done in dsi_init().
>>>
>>> Signed-off-by: Archit Taneja<archit@ti.com>
<snip>

>
>>>    }
>>>
>>> +int omap_dsi_request_vc(struct omap_dss_device *dssdev, int vc_id, int *channel)
>>> +{
>>> +	int p = dsi.num_vc_used;
>>> +
>>> +	if (p>= 4) {
>>> +		DSSERR("cannot get VC for display %s", dssdev->name);
>>> +		return -EINVAL;

Should we return -EINAVL when all VCs are used? Could we put -EBUSY or 
-ENOSPC instead?

>>> +	}
>>> +
>>> +	dsi.vc[p].dssdev = dssdev;
>>> +	dsi.vc[p].vc_id = vc_id;
>>> +	*channel = p;
>>> +
>>> +	dsi.num_vc_used += 1;
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL(omap_dsi_request_vc);
>>> +

<snip>

Archit
