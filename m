From: Archit Taneja <archit@ti.com>
Subject: Re: [RFC v2 2/5] OMAPDSS: DT: Get source endpoint by matching reg-id
Date: Tue, 27 May 2014 16:21:47 +0530
Message-ID: <53846E43.7000808@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com> <1401096492-1405-1-git-send-email-archit@ti.com> <1401096492-1405-2-git-send-email-archit@ti.com> <53844E14.9090504@ti.com> <53845F99.60603@ti.com> <538467E0.2000305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48442 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbaE0KxD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 May 2014 06:53:03 -0400
Received: from dbdlxv05.itg.ti.com ([172.24.171.60])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id s4RAr1X7013832
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 05:53:02 -0500
Received: from DBDE72.ent.ti.com (dbdmailx.itg.ti.com [172.24.171.97])
	by dbdlxv05.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4RAqxEg032198
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 16:23:00 +0530
In-Reply-To: <538467E0.2000305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 27 May 2014 03:54 PM, Tomi Valkeinen wrote:
> On 27/05/14 12:49, Archit Taneja wrote:
>> On Tuesday 27 May 2014 02:04 PM, Tomi Valkeinen wrote:
>
>>> Hmm, maybe the above function, and the helper functions, should be
>>> changed a bit more, so that this function would do:
>>>
>>> ep = omapdss_of_get_first_endpoint(node);
>>> src_port = omapdss_of_get_remote_port(ep);
>>> src = omap_dss_find_output_by_port_node(src_port);
>>
>> src_port will be just on level up(the parent node), the source node will
>> be still a couple of hops up.
>>
>> Getting the source node would require us to do some DT related hopping
>> in omap_dss_find_output_by_port_node(). And it'll also require parsing
>> of the dss output_list in output.c. I'm worried it'll be a bit messy,
>> and we might end up adding some DT parsing in output.c
>
> But now the function above is messy =).
>
> Well, I haven't thought what the code would actually be. I just thought
> the functions I wrote would be logical in this context. As the output
> omap_dss_device more or less is a "port", it would feel logical to ask
> for the omap_dss_device by giving the port node.
>
> But you're right, the function in output.c would need to do a bit more
> than now. Then again, we could add helper functions to dss-of.c, so that
> output.c wouldn't need to do them manually.
>
> I guess the helper funcs in this case would be:
>
> struct device_node *dss_of_port_get_parent_device(struct device_node *port);
>
> int dss_of_port_get_port_number(struct device_node *port);

These look fine. I'll update the patch.

Archit

