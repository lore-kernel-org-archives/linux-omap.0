From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 09/18] ARM: OMAP4+: PM: Restore CPU power state to
 ON with clockdomain force wakeup method
Date: Fri, 5 Apr 2013 17:28:22 +0530
Message-ID: <515EBC5E.6090705@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-10-git-send-email-santosh.shilimkar@ti.com>
 <87mwtftjvy.fsf@linaro.org> <515D8215.10705@ti.com>
 <87li8ynqf5.fsf@linaro.org> <515E9435.6050007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <515E9435.6050007@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>
Cc: nm@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 05 April 2013 02:37 PM, Santosh Shilimkar wrote:
> On Thursday 04 April 2013 11:12 PM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>>> On Thursday 04 April 2013 02:24 AM, Kevin Hilman wrote:
>>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>>
>>>>> While waking up CPU from off state using clock domain force wakeup, restore
>>>>> the CPU power state to ON state before putting CPU clock domain under
>>>>> hardware control. Otherwise CPU wakeup might fail. The change is recommended
>>>>> for all OMAP4+ devices though the PRCM weakness was observed on OMAP5
>>>>> devices first.
>>>>
>>>> Sounds reasonable, but can you describe the "weakness" a little more?
>>>>
>>>> IOW, what exactly happens if this is not done?  It sounds like the CPU
>>>> might immediately go back to retention, but how does that happen unless
>>>> it does a WFI?
>>>>
>>> Its more of lock-up inside the hardware state machine and results
>>> are UN-predictable. We have seen hard-locks most of the time where system
>>> is just frozen. The hardware gets into wrong state machine if the power
>>> domain state isn't restored. I will add this information to changelog.
>>>
>>>> Also, this sounds like a fix to me, and should probably be broken out
>>>> accordingly.
>>>>
>>> Yeah. You mean a separate patch from the series, right ? This patch
>>> actually can be independently added.
>>>
>>> In case you decide to apply it for the fixes branch, updated patch
>>> at end of the email.
>>
>> Curious which branch you applied it to?  It didn't apply cleanly to
>> v3.9-rc5 (but did with fuzz).
>>
> Mostly applied on top of the Tony's pull request branches.
> 
>> So I've now added it to my for_3.10/fixes/pm branch.
>>
> Thanks. I will pull that in to re-base other patches.
> 
While pulling your 'for_3.10/fixes/pm' branch on top
of Tony's pull request[1] sent to arm-soc already.
In my tree, I had pulled Tony's couple of pull requests.

Regards,
Santosh

[1] http://www.spinics.net/lists/arm-kernel/msg235788.html
