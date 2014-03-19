From: Grant Likely <grant.likely@linaro.org>
Subject: Re: pandaboard boot crash with linux-next
Date: Wed, 19 Mar 2014 15:06:19 +0000
Message-ID: <CACxGe6s0pEzE2zBb_c2bcU+2C6hm3S9aJ9UCeLGFfp1RDvDAEA@mail.gmail.com>
References: <53270218.9050109@ti.com> <5329A8E9.1010000@ti.com>
 <AA9ED470-ADDB-4855-A016-5E36F983CF7D@antoniou-consulting.com>
 <5329AACB.7080208@ti.com> <20F3DEC5-1EE7-4874-8861-616B2662BF88@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20F3DEC5-1EE7-4874-8861-616B2662BF88@antoniou-consulting.com>
Sender: linux-next-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, linux-next <linux-next@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

[cc'ing linux-next ml]

On Wed, Mar 19, 2014 at 2:35 PM, Pantelis Antoniou
<panto@antoniou-consulting.com> wrote:
> Hi Tomi,
>
> On Mar 19, 2014, at 4:33 PM, Tomi Valkeinen wrote:
>
>> On 19/03/14 16:29, Pantelis Antoniou wrote:
>>> Hi Tomi,
>>>
>>> On Mar 19, 2014, at 4:25 PM, Tomi Valkeinen wrote:
>>>
>>>> On 17/03/14 16:09, Tomi Valkeinen wrote:
>>>>> Hi,
>>>>>
>>>>> I noticed that my omap4 panda does not boot with today's linux-next
>>>>> (8808b950581f71e3ee4cf8e6cae479f4c7106405). I didn't have much time to study
>>>>> it, but I didn't find any posts about the issue with a quick look. Below is
>>>>> the crash.
>>>>
>>>> I bisected this to the commit:
>>>>
>>>> commit ad2c12e9bc250b3387bcb4ab9ab114f43ff6122f
>>>> Author: Pantelis Antoniou <panto@antoniou-consulting.com>
>>>> Date:   Fri Dec 13 20:08:59 2013 +0200
>>>>
>>>>   of: device_node kobject lifecycle fixes
>>>>
>>>>   After the move to having device nodes be proper kobjects the lifecycle
>>>>   of the node needs to be controlled better.
>>>>
>>>>   At first convert of_add_node() in the unflattened functions to
>>>>   of_init_node() which initializes the kobject so that of_node_get/put
>>>>   work correctly even before of_init is called.
>>>>
>>>>   Afterwards introduce of_node_is_initialized & of_node_is_attached that
>>>>   query the underlying kobject about the state (attached means kobj
>>>>   is visible in sysfs)
>>>>
>>>>   Using that make sure the lifecycle of the tree is correct at all
>>>>   times.
>>>>
>>>>   Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
>>>>   [grant.likely: moved of_node_init() calls, fixed up locking, and
>>>>                  dropped __of_populate() hunks]
>>>>   Signed-off-by: Grant Likely <grant.likely@linaro.org>
>>>>
>>>
>>> Can you try this? It should fix it (plus it should be in -next soon)
>>
>> Thanks, that fixes the issue (tested on omap4 panda).
>>
>> Tomi
>>
>
> Yeah I know; my beaglebone hangs as well without it :)

Hi Tomi,

Pantelis sent the fix to me yesterday, but I hadn't tested and pushed
it out until now. Tomorrow's linux-next it should be okay.

g.
