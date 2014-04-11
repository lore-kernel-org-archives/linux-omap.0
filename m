From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 03/14] dma: edma: Add support for DMA_PAUSE/RESUME
	operation
Date: Fri, 11 Apr 2014 15:51:43 -0500
Message-ID: <534855DF.2040309@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
	<1396357575-30585-4-git-send-email-peter.ujfalusi@ti.com>
	<20140411164327.GD32284@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20140411164327.GD32284-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/11/2014 11:43 AM, Vinod Koul wrote:
> On Tue, Apr 01, 2014 at 04:06:04PM +0300, Peter Ujfalusi wrote:
>> Pause/Resume can be used by the audio stack when the stream is paused/resumed
>> The edma platform code has support for this and the legacy audio stack used
>> this.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/dma/edma.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>> index 2742867fd1e6..7891378a03f0 100644
>> --- a/drivers/dma/edma.c
>> +++ b/drivers/dma/edma.c
>> @@ -240,6 +240,26 @@ static int edma_slave_config(struct edma_chan *echan,
>>  	return 0;
>>  }
>>  
>> +static int edma_dma_pause(struct edma_chan *echan)
>> +{
>> +	/* Pause/Resume only allowed with cyclic mode */
>> +	if (!echan->edesc->cyclic)
>> +		return -EINVAL;
> why this artificial restriction? The driver can do pause even for non cyclic
> cases too? Yes the usage is in cyclic context but why should we limit any future
> work on this?
> 

We struggled with this, and we certainly we don't want pauses in
non-cyclic EDMA... we tried doing a "pause" and it was a disaster as the
events keep coming in and those can't be paused, and EDMA hardware wont
queue them during the pause, it'll just generate an error interrupt storm.

Thanks,
-Joel
