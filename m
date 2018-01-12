From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH, v3] arm: omap2: timer: fix a kmemleak caused in
 omap_get_timer_dt
Date: Fri, 12 Jan 2018 15:17:32 -0600
Message-ID: <1da42501-5a34-0e4d-68bd-1712b63174f8@ti.com>
References: <1515646483-24199-1-git-send-email-qi.hou@windriver.com>
 <7dd12934-862c-c7ad-5f43-43e4c6b08199@ti.com>
 <20180112210844.GF4821@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180112210844.GF4821@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, Qi Hou <qi.hou@windriver.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 01/12/2018 03:08 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [180112 20:36]:
>> Hi
>>
>> On 01/10/2018 10:54 PM, Qi Hou wrote:
>>> When more than one GP timers are used as kernel system timers and the
>>> corresponding nodes in device-tree are marked with the same "disabled"
>>> property, then the "attr" field of the property will be initialized
>>> more than once as the property being added to sys file system via
>>> __of_add_property_sysfs().
>>>
>>> In __of_add_property_sysfs(), the "name" field of pp->attr.attr is set
>>> directly to the return value of safe_name(), without taking care of
>>> whether it's already a valid pointer to a memory block. If it is, its
>>> old value will always be overwritten by the new one and the memory block
>>> allocated before will a "ghost", then a kmemleak happened.
>>>
>>> That the same "disabled" property being added to different nodes of device
>>> tree would cause that kind of kmemleak overhead, at leat once.
>>>
>>> To fix it, allocate the property dynamically, and delete static one.
>>
>> Does it in sync with Keerthy's work [1]
> 
> First fixes, then new stuff! Keerthy's work will have to
> wait for v4.17, we want that series sitting in Linux next
> for several weeks.
> 
Np. just want to be sure every party is aware about each other's work

-- 
regards,
-grygorii
