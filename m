From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] dma: edma: fix incorrect SG list handling
Date: Tue, 18 Mar 2014 13:46:04 -0500
Message-ID: <5328946C.3010508@ti.com>
References: <1395057448-22904-1-git-send-email-nsekhar@ti.com>
	<alpine.DEB.2.02.1403170854570.9730@jringle-ubuntu>
	<5326F2BF.6040702@ti.com>
	<alpine.DEB.2.02.1403170913110.9730@jringle-ubuntu>
	<20140318152840.GD1976@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20140318152840.GD1976-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jon Ringle <jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org>
Cc: Linux DaVinci Mailing List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Ringle,  Jonathan" <Jonathan.Ringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, DMA Engine Mailing List <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 03/18/2014 10:28 AM, Vinod Koul wrote:
> On Mon, Mar 17, 2014 at 09:14:14AM -0400, Jon Ringle wrote:
>> On Mon, 17 Mar 2014, Sekhar Nori wrote:
>>
>>> Hi Jon,
>>>
>>> On Monday 17 March 2014 06:28 PM, Jon Ringle wrote:
>>>>
>>>> On Mon, 17 Mar 2014, Sekhar Nori wrote:
>>>>
>>>>> The code to handle any length SG lists calls edma_resume()
>>>>> even before edma_start() is called. This is incorrect
>>>>> because edma_resume() enables edma events on the channel
>>>>> after which CPU (in edma_start) cannot clear posted
>>>>> events by writing to ECR (per the EDMA user's guide).
>>>>>
>>>>> Because of this EDMA transfers fail to start if due
>>>>> to some reason there is a pending EDMA event registered
>>>>> even before EDMA transfers are started. This can happen if
>>>>> an EDMA event is a byproduct of device initialization.
>>>>>
>>>>> Fix this by calling edma_resume() only if it is not the
>>>>> first batch of MAX_NR_SG elements.
>>>>>
>>>>> Without this patch, MMC/SD fails to function on DA850 EVM
>>>>> with DMA. The behaviour is triggered by specific IP and
>>>>> this can explain why the issue was not reported before
>>>>> (example with MMC/SD on AM335x).
>>>>>
>>>>> Tested on DA850 EVM and AM335x EVM-SK using MMC/SD card.
>>>>>
>>>>> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.12.x+
>>>>> Cc: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
>>>>> Reported-by: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>
>>>>> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>>>>> ---
>>>>> Jon, can you please confirm this fixes the issue you
>>>>> reported?
>>>>
>>>> The patch does not apply on linux-3.12 due to changes to the 3 context 
>>>> lines at the start of the hunk.
>>>>
>>>> But, I manually fixed up the code and it does fix the issue  on our AM1808 
>>>> board.
>>>
>>> Thanks for the testing. The patch is meant for latest mainline but based
>>> on what you said, a manual backport to v3.12-stable will be required.
>>>
>>> Can you please reply with a formal Tested-by: ?
>>
>> Tested-by: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>
> where is this patch, somehow am not able to find in my inbox or archives...
> 

I found it archived here:
http://comments.gmane.org/gmane.linux.davinci/28569

Patch doesn't breaking anything for > MAX_NR_SG list size on AM335x, so
it looks good.

Acked-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>

Regards,
-Joel
