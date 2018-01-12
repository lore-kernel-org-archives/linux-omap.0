From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH, v3] arm: omap2: timer: fix a kmemleak caused in
 omap_get_timer_dt
Date: Fri, 12 Jan 2018 14:36:04 -0600
Message-ID: <7dd12934-862c-c7ad-5f43-43e4c6b08199@ti.com>
References: <1515646483-24199-1-git-send-email-qi.hou@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1515646483-24199-1-git-send-email-qi.hou@windriver.com>
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
To: Qi Hou <qi.hou@windriver.com>, tony@atomide.com, linux@armlinux.org.uk
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi

On 01/10/2018 10:54 PM, Qi Hou wrote:
> When more than one GP timers are used as kernel system timers and the
> corresponding nodes in device-tree are marked with the same "disabled"
> property, then the "attr" field of the property will be initialized
> more than once as the property being added to sys file system via
> __of_add_property_sysfs().
> 
> In __of_add_property_sysfs(), the "name" field of pp->attr.attr is set
> directly to the return value of safe_name(), without taking care of
> whether it's already a valid pointer to a memory block. If it is, its
> old value will always be overwritten by the new one and the memory block
> allocated before will a "ghost", then a kmemleak happened.
> 
> That the same "disabled" property being added to different nodes of device
> tree would cause that kind of kmemleak overhead, at leat once.
> 
> To fix it, allocate the property dynamically, and delete static one.

Does it in sync with Keerthy's work [1]

[1] https://www.spinics.net/lists/linux-omap/msg141100.html
> 
> Signed-off-by: Qi Hou <qi.hou@windriver.com>
> ---
>   arch/arm/mach-omap2/timer.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)

-- 
regards,
-grygorii
