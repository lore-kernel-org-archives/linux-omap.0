From: "Anna, Suman" <s-anna@ti.com>
Subject: Re: [PATCHv4 6/7] hwspinlock/omap: enable module before reading
 SYSSTATUS register
Date: Wed, 15 Jan 2014 17:46:50 -0600
Message-ID: <52D71DEA.6020602@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-7-git-send-email-s-anna@ti.com>
 <20140114131052.GA10818@saruman.home> <20140114140440.GA15785@saruman.home>
 <52D56C3A.7000704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52D56C3A.7000704@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Felipe,

 >
> On 01/14/2014 08:04 AM, Felipe Balbi wrote:
>> Hi again,
>>
>> On Tue, Jan 14, 2014 at 07:10:52AM -0600, Felipe Balbi wrote:
>>>> diff --git a/drivers/hwspinlock/omap_hwspinlock.c
>>>> b/drivers/hwspinlock/omap_hwspinlock.c
>>>> index 9f56fb2..194886e 100644
>>>> --- a/drivers/hwspinlock/omap_hwspinlock.c
>>>> +++ b/drivers/hwspinlock/omap_hwspinlock.c
>>>> @@ -101,10 +101,23 @@ static int omap_hwspinlock_probe(struct
>>>> platform_device *pdev)
>>>>       if (!io_base)
>>>>           return -ENOMEM;
>>>>
>>>> +    /*
>>>> +     * make sure the module is enabled and clocked before reading
>>>> +     * the module SYSSTATUS register
>>>> +     */
>>>> +    pm_runtime_enable(&pdev->dev);
>>>> +    pm_runtime_get_sync(&pdev->dev);
>>
>> another thing, you need to check return of pm_runtime_get_sync()
>
> OK, let me check this and your other comment, and the fix is probably a
> separate patch.
>

I realized the changes relevant to your comments were introduced in this 
patch, so just refreshed the patch with fixes instead of doing a 
separate patch. I didn't do a v5 just for these change, and will do so 
if there are more comments on the DT adaptation.

regards
Suman
