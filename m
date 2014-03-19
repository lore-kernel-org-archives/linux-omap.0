From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: pandaboard boot crash with linux-next
Date: Wed, 19 Mar 2014 16:35:25 +0200
Message-ID: <20F3DEC5-1EE7-4874-8861-616B2662BF88@antoniou-consulting.com>
References: <53270218.9050109@ti.com> <5329A8E9.1010000@ti.com> <AA9ED470-ADDB-4855-A016-5E36F983CF7D@antoniou-consulting.com> <5329AACB.7080208@ti.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:38354 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965106AbaCSOf2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Mar 2014 10:35:28 -0400
In-Reply-To: <5329AACB.7080208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>

Hi Tomi,

On Mar 19, 2014, at 4:33 PM, Tomi Valkeinen wrote:

> On 19/03/14 16:29, Pantelis Antoniou wrote:
>> Hi Tomi,
>> 
>> On Mar 19, 2014, at 4:25 PM, Tomi Valkeinen wrote:
>> 
>>> On 17/03/14 16:09, Tomi Valkeinen wrote:
>>>> Hi,
>>>> 
>>>> I noticed that my omap4 panda does not boot with today's linux-next
>>>> (8808b950581f71e3ee4cf8e6cae479f4c7106405). I didn't have much time to study
>>>> it, but I didn't find any posts about the issue with a quick look. Below is
>>>> the crash.
>>> 
>>> I bisected this to the commit:
>>> 
>>> commit ad2c12e9bc250b3387bcb4ab9ab114f43ff6122f
>>> Author: Pantelis Antoniou <panto@antoniou-consulting.com>
>>> Date:   Fri Dec 13 20:08:59 2013 +0200
>>> 
>>>   of: device_node kobject lifecycle fixes
>>> 
>>>   After the move to having device nodes be proper kobjects the lifecycle
>>>   of the node needs to be controlled better.
>>> 
>>>   At first convert of_add_node() in the unflattened functions to
>>>   of_init_node() which initializes the kobject so that of_node_get/put
>>>   work correctly even before of_init is called.
>>> 
>>>   Afterwards introduce of_node_is_initialized & of_node_is_attached that
>>>   query the underlying kobject about the state (attached means kobj
>>>   is visible in sysfs)
>>> 
>>>   Using that make sure the lifecycle of the tree is correct at all
>>>   times.
>>> 
>>>   Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
>>>   [grant.likely: moved of_node_init() calls, fixed up locking, and
>>>                  dropped __of_populate() hunks]
>>>   Signed-off-by: Grant Likely <grant.likely@linaro.org>
>>> 
>> 
>> Can you try this? It should fix it (plus it should be in -next soon)
> 
> Thanks, that fixes the issue (tested on omap4 panda).
> 
> Tomi
> 

Yeah I know; my beaglebone hangs as well without it :)

> 

Regards

-- Pantelis

