From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [RFC 3/7] OMAP: Introduce voltage domain pointer and device
 specific set rate and get rate in device opp structures.
Date: Wed, 4 Aug 2010 09:31:03 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323E68C8F@dbde02.ent.ti.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com>
 <1278065909-32148-2-git-send-email-thara@ti.com>
 <1278065909-32148-3-git-send-email-thara@ti.com>
 <1278065909-32148-4-git-send-email-thara@ti.com> <4C56B5C5.2070504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33200 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab0HDEBI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 00:01:08 -0400
In-Reply-To: <4C56B5C5.2070504@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Basak, Partha" <p-basak2@ti.com>



>>-----Original Message-----
>>From: Cousson, Benoit
>>Sent: Monday, August 02, 2010 5:41 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com; paul@pwsan.com; Sripathy, Vishwanath;
>>Sawant, Anand; Basak, Partha
>>Subject: Re: [RFC 3/7] OMAP: Introduce voltage domain pointer and device specific set rate and get
>>rate in device opp structures.
>>
>>Hi Thara,
>>
>>On 7/2/2010 12:18 PM, Gopinath, Thara wrote:
>>> This patch extends the device opp structure to contain
>>> info about the voltage domain to which the device belongs to
>>> and to contain pointers to scale the operating rate of the
>>> device. This patch also adds an API in the opp layer that
>>> can be used by the voltage layer to get a list of all the
>>> scalable devices belonging to a particular voltage domain.
>>> This API is to be typically called only once by the voltage
>>> layer per voltage domain instance and the device list should
>>> be stored. This approach makes it easy during dvfs to scale
>>> all the devices associated with a voltage domain and then
>>> scale the voltage domain.
>>>
>>> Signed-off-by: Thara Gopinath<thara@ti.com>
>>> ---
>>>   arch/arm/plat-omap/include/plat/opp.h |   37 +++++++++++++++++++++++++-
>>>   arch/arm/plat-omap/opp.c              |   47 +++++++++++++++++++++++++-------
>>>   2 files changed, 72 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
>>> index 893731f..15e1e70 100644
>>> --- a/arch/arm/plat-omap/include/plat/opp.h
>>> +++ b/arch/arm/plat-omap/include/plat/opp.h
>>> @@ -16,6 +16,7 @@
>>>
>>>   #include<linux/err.h>
>>>   #include<linux/cpufreq.h>
>>> +#include<linux/clk.h>
>>>
>>>   #include<plat/common.h>
>>>
>>> @@ -38,21 +39,45 @@
>>>    */
>>>   struct omap_opp_def {
>>>   	char *hwmod_name;
>>> +	char *vdd_name;
>>
>>vdd should be an attribute of hwmod. For one hwmod in a soc we will
>>always have the same vdd.
>>That will avoid to duplicate information and to have to populate that in
>>each OPP entry (cf patch 6).
I also do not like the duplication of info in the opp tables. I was not sure
about introducing this in the hwmod layer. I could surely do this for the
vdd name and voltage domain pointer.
>>
>>>
>>>   	unsigned long freq;
>>>   	unsigned long u_volt;
>>>
>>> +	int (*set_rate)(struct device *dev, unsigned long rate);
>>> +	unsigned long (*get_rate) (struct device *dev);
>>
>>We might already discussed that, but why should we store that per OPP?
>>Cannot we store that per device?

Paul had concerns regarding this. These are not h/w or h/w interface related info
in any manner. One good point is that even though these pointers are duplicated in
the init opp tables, during init the device opp tables are built and only one copy
is maintained. But I agree this does not look too very good.

Regards
Thara
