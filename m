From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] dmaengine: edma: Implement device_synchronize callback
Date: Thu, 11 Feb 2016 13:13:28 +0100
Message-ID: <56BC7AE8.2070009@metafoo.de>
References: <1455181722-32099-1-git-send-email-peter.ujfalusi@ti.com>
 <56BC5759.80000@metafoo.de> <56BC6C94.1060409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56BC6C94.1060409@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 02/11/2016 12:12 PM, Peter Ujfalusi wrote:
> On 02/11/2016 11:41 AM, Lars-Peter Clausen wrote:
>> On 02/11/2016 10:08 AM, Peter Ujfalusi wrote:
>>> We need the callback to support the dmaengine_terminate_sync().
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>
>> Looks good, but I noticed a slight race condition in
>> edma_completion_handler(). You need to fetch echan->desc while holding the
>> vchan.lock. Otherwise this can race against terminate_all() and the callback
>> might get scheduled even though terminate_all() completed and then there is
>> a race where the synchronize() operation could be called before the callback
>> gets scheduled, which means it doesn't do its intended job. Highly unlikely
>> to happen, but theoretically possible.
> 
> Right, actually I had (have) another series fixing the very same race in a
> different way - patching the terminate_all (series attached).
> We have seen race with RT kernel on uniprocessor setup.
> 
> The tasklet_kill after the terminate_all will execute the scheduled task
> unconditionally, so the vchan_complete() will run after we have terminated the
> channel, which might be not what we want.
> I have also seen a race condition as explained in the first patch. The only
> way I was able to fix that by using the attached patches. Unfortunately I can
> not test RT with mainline yet, so I'm not 100% sure if by using the
> dmaengine_terminate_sync() in drivers will fix the issue.
> 

Yes, dmaengine_terminate_sync() is supposed to fix the same issue. One of
the problems when implementing this was that e.g. for audio it might happen
that we terminate the transfer from within the tasklet callback itself. In
that case doing tasklet_disable() will deadlock since it will wait until the
tasklet has finished from within the tasklet.

This is why the synchronize API has two primitives. Terminate and
synchronize, so you can split them if necessary.

The only thing you need to make sure is that the implementation of
synchronize() is correct. In the EDMA case echan->desc is read without
holding a lock which still keeps the race condition open.

- Lars
