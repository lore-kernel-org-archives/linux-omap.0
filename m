From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/PATCH 9/9] OMAP2+: cpuidle only influences the MPU state
Date: Mon, 27 Jun 2011 07:11:44 -0700
Message-ID: <4E088FA0.6070807@ti.com>
References: <1308926286-30445-1-git-send-email-j-pihet@ti.com>	<1308926286-30445-10-git-send-email-j-pihet@ti.com>	<4E05E153.9030006@ti.com> <BANLkTin0TKXLB_UtySAnf4JM1q1oPgP+iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:52396 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751784Ab1F0OLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 10:11:48 -0400
Received: by mail-pz0-f47.google.com with SMTP id 36so3395857pzk.6
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 07:11:47 -0700 (PDT)
In-Reply-To: <BANLkTin0TKXLB_UtySAnf4JM1q1oPgP+iQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On 6/26/2011 11:53 PM, Jean Pihet wrote:
> Hi Santosh,
>
> On Sat, Jun 25, 2011 at 3:23 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> On 6/24/2011 7:38 AM, jean.pihet@newoldbits.com wrote:
>>>
>>> From: Jean Pihet<j-pihet@ti.com>
>>>
>>> Since cpuidle is a CPU centric framework it decides the MPU
>>> next power state based on the MPU exit_latency and target_residency
>>> figures.
>>>
>>> The rest of the power domains get their next power state programmed
>>> from the PM_QOS_DEV_WAKEUP_LATENCY class of the PM QoS framework,
>>> via the device wake-up latency constraints.
>>>
>>> Note: the exit_latency and target_residency figures of the MPU
>>> include the MPU itself and the peripherals needed for the MPU to
>>> execute instructions (e.g. main memory, caches, IRQ controller,
>>> MMU etc). Some of those peripherals can belong to other power domains
>>> than the MPU subsystem and so the corresponding latencies must be
>>> included in this figure.
>>>
>> With above comment, I was expecting that the latency numbers
>> in the table will change.
> Not necessarily. I just wanted to have it clearly stated in the commit
> description.
> In any case I will review the figures and update them if needed.
> ...
>
>>>   static struct cpuidle_params cpuidle_params_table[] = {
>>> -       /* C1 */
>>> +       /* C1 . MPU WFI + Core active */
>>>         {2 + 2, 5, 1},
>>> -       /* C2 */
>>> +       /* C2 . MPU WFI + Core inactive */
>>>         {10 + 10, 30, 1},
>>> -       /* C3 */
>>> +       /* C3 . MPU CSWR + Core inactive */
>>>         {50 + 50, 300, 1},
>>> -       /* C4 */
>>> +       /* C4 . MPU OFF + Core inactive */
>>>         {1500 + 1800, 4000, 1},
>>> -       /* C5 */
>>> +       /* C5 . MPU RET + Core RET */
>>>         {2500 + 7500, 12000, 1},
>>> -       /* C6 */
>>> +       /* C6 . MPU OFF + Core RET */
>>>         {3000 + 8500, 15000, 1},
>>> -       /* C7 */
>>> +       /* C7 . MPU OFF + Core OFF */
>>>         {10000 + 30000, 300000, 1},
>>
>> Latency numbers still seems to include CORE PD latency as
>> well. Am I missing something Jean?
> The figures are looking OK.
>
Hmmm...
Well they represent mostly MPU + CORE PD sleep + wakeup latencies
I suppose so not sure what you mean by OK here.

Regards
Santosh
