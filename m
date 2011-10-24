From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract regulator_init_data
Date: Mon, 24 Oct 2011 11:32:19 +0530
Message-ID: <4EA4FF6B.2080906@ti.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com> <1318263578-7407-4-git-send-email-rnayak@ti.com> <20111018132032.GD30703@S2100-06.ap.freescale.net> <4E9EB61C.1040207@ti.com> <20111019144215.GA32007@S2100-06.ap.freescale.net> <4E9FAF42.5060200@ti.com> <20111020061408.GE32007@S2100-06.ap.freescale.net> <4EA00F7C.1080005@ti.com> <20111021082309.GA337@S2100-06.ap.freescale.net> <4EA13053.7080306@ti.com> <20111021115809.GB337@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111021115809.GB337@S2100-06.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 21 October 2011 05:28 PM, Shawn Guo wrote:
> On Fri, Oct 21, 2011 at 02:11:55PM +0530, Rajendra Nayak wrote:
> [...]
>>> +       /* find device_node and attach it */
>>> +       rdev->dev.of_node = of_find_node_by_name(NULL, regulator_desc->name);
>>
>> so would this do a complete dt search for every regulator?
>
> Yes, with the first param being NULL, tthe entire device tree will be
> searched.
>
>> we would also need the driver names and dt names to match for this to
>> work, right?
>>
> Driver name does not matter.  The key for this search to work is having
> regulator's name (regulator_desc->name) match device tree node's name,
> case ignored.

Mark, whats your take on this? I am somehow not quite sure if we should
have this limitation put in to match DT node names with whats in the
driver structs (regulator_desc).

>
>> The approach otherwise looks fine to me and should work for both cases
>> of one device per regulator and one device for all regulators.
>>
>
