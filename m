From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/3] ARM/dma: edma: Serve cyclic clients via high priority
	queue
Date: Mon, 28 Jul 2014 12:02:17 +0530
Message-ID: <53D5EE71.3040707@ti.com>
References: <1404816398-12338-1-git-send-email-peter.ujfalusi@ti.com>
	<53D5E9CF.10706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <53D5E9CF.10706-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, joelf-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 28 July 2014 11:42 AM, Peter Ujfalusi wrote:
> On 07/08/2014 01:46 PM, Peter Ujfalusi wrote:
>> Hi,
>>
>> It is preferred that audio is served with the highest priority queue in order to
>> avoid delays in data transfer between memory and audio IP.
>>
>> The following series will add an API to arch code to assign a channel to a given
>> queue.
>> The default queue is changed from 0 (highest priority) to lowest priority.

This should not really change any performance behavior as everything at
highest priority is same as everything at lowest priority.

>> In the dmaengine driver we move the cyclic channel to queue0 (highest priority)
>> and move it back to default queue when the channel is terminated.
> 
> ping?

For 1/3 and 2/3:

Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

Vinod, can you take the series together with your tree (if you are happy
with the series, that is)? I don't have anything else queued for this
merge window.

Thanks,
Sekhar
