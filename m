From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 10/14] dma: edma: Simplify direction configuration
	in edma_config_pset()
Date: Fri, 11 Apr 2014 14:57:48 -0500
Message-ID: <5348493C.8040408@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
	<1396357575-30585-11-git-send-email-peter.ujfalusi@ti.com>
	<53471DC5.4090001@ti.com> <53478E0E.8040709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <53478E0E.8040709-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/11/2014 01:39 AM, Peter Ujfalusi wrote:
> On 04/11/2014 01:40 AM, Joel Fernandes wrote:
>> On 04/01/2014 08:06 AM, Peter Ujfalusi wrote:
>>> We only support DEV_TO_MEM or MEM_TO_DEV directions with edma driver and the
>>> check for the direction has been already done in the function calling
>>> edma_config_pset().
>>> The error reporting is redundant and also the "else if ()" can be removed.
>>>
>>
>> NAK. Please don't do this. I have been working on MEM_TO_MEM support as
>> well so leave it as it is for future.
> 
> Sure. It is still valid to say that the error else {} will never going to
> happen since you have the same check in the calling function and they already
> filtered the non implemented direction.
> 

That's true. Though the patch removes the else if which would mean more
work later ;)

> I'll leave this out from v3.

Thanks.

Regards,
-Joel
