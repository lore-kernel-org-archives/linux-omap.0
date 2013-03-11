From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 19/20] OMAPDSS: DSI: fix DSI channel source initialization
Date: Mon, 11 Mar 2013 13:45:33 +0530
Message-ID: <513D92A5.5050509@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-20-git-send-email-tomi.valkeinen@ti.com> <513D754A.4000607@ti.com> <513D8198.7070702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45204 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab3CKIQR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 04:16:17 -0400
In-Reply-To: <513D8198.7070702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Monday 11 March 2013 12:32 PM, Tomi Valkeinen wrote:
> On 2013-03-11 08:10, Archit Taneja wrote:
>> Hi,
>>
>> On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
>>> During the initialization of the DSI protocol registers, we always set
>>> the sources of all DSI channels to L4. However, we don't update the
>>> value in the dsi_data, so we may end up with a different value in the
>>> register and in the dsi_data, leading to DSI problems.
>>>
>>> This patch fixes the issue by initializing also the channel source in
>>> the dsi_data.
>>
>> We set in omap_dsihw_probe:
>>
>> static int __init omap_dsihw_probe(struct platform_device *dsidev)
>> {
>>      ...
>>      ...
>>          /* DSI VCs initialization */
>>          for (i = 0; i < ARRAY_SIZE(dsi->vc); i++) {
>>                  dsi->vc[i].source = DSI_VC_SOURCE_L4;
>>                  dsi->vc[i].dssdev = NULL;
>>                  dsi->vc[i].vc_id = 0;
>>          }
>>      ...
>>      ...
>> }
>
> Hmm... I did have a bug related to this when prototyping CDF. Ah.
> Consider this:
>
> Panel powers up and uses DSI normally. A DSI VC is set to video mode.
> Then the panel power down. Then it powers up again, and enables DSI. At
> this time, dsi_vc_initial_config() is called again, setting the source
> in the registers to L4. But the source in dsi_data is still VP.

Oh ok.

>
> So perhaps the whole piece of code from omap_dsihw_probe should be moved
> to somewhere else (dsi_vc_initial_config() sounds like a good place), so
> that they are initialized each time the registers are initialized.

VC source is something which seems fine to do in 
dsi_vc_initial_config(). I'm not sure about the dssdev and vc_id fields 
though, we would need to call omap_dsi_request_vc() and 
omap_dsi_set_vc_id() again after a power off. Currently, we do it only 
once in taal_probe().

Archit

