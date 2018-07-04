From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH RESEND 1/2] ti: wkup_m3_ipc: Add rtc_only with ddr in self
 refresh mode support
Date: Wed, 4 Jul 2018 10:11:42 +0530
Message-ID: <e11a6f66-5210-2cfe-f4de-ddf5bd267617@ti.com>
References: <1529572954-22244-1-git-send-email-j-keerthy@ti.com>
 <f83093e3-b681-f33f-8d2e-42cabee03b7f@ti.com>
 <8d347d42-371f-4e75-d781-aa67d093e1a3@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8d347d42-371f-4e75-d781-aa67d093e1a3@oracle.com>
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
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org



On Wednesday 04 July 2018 10:07 AM, santosh.shilimkar@oracle.com wrote:
> On 7/3/18 9:23 PM, Keerthy wrote:
>>
>>
>> On Thursday 21 June 2018 02:52 PM, Keerthy wrote:
>>> Adds rtc_only support. This needs resume function to shutdown and
>>> reboot the m3.
>>
>> A gentle ping on this series.
>>
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---
>>>
>>> This is tested on am437x-gp-evm and target for 4.19
> 
> Am I suppose to pick up this series 

./scripts/get_maintainer.pl
wkm3/0001-ti-wkup_m3_ipc-Add-rtc_only-with-ddr-in-self-refresh.patch

Santosh Shilimkar <ssantosh@kernel.org> (maintainer:TI KEYSTONE
MULTICORE NAVIGATOR DRIVERS)
linux-kernel@vger.kernel.org (open list:TI KEYSTONE MULTICORE NAVIGATOR
DRIVERS)
linux-arm-kernel@lists.infradead.org (moderated list:TI KEYSTONE
MULTICORE NAVIGATOR DRIVERS)

./scripts/get_maintainer.pl
wkm3/0002-soc-ti-wkup_m3_ipc-Add-wkup_m3_request_wake_src.patch

Santosh Shilimkar <ssantosh@kernel.org> (maintainer:TI KEYSTONE
MULTICORE NAVIGATOR DRIVERS)
linux-kernel@vger.kernel.org (open list:TI KEYSTONE MULTICORE NAVIGATOR
DRIVERS)
linux-arm-kernel@lists.infradead.org (moderated list:TI KEYSTONE
MULTICORE NAVIGATOR DRIVERS)

For some reason both patches points you as the Maintainer :-P.

Regards,
Keerthy
