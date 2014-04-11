From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 10/14] dma: edma: Simplify direction configuration
	in edma_config_pset()
Date: Fri, 11 Apr 2014 09:39:10 +0300
Message-ID: <53478E0E.8040709@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
	<1396357575-30585-11-git-send-email-peter.ujfalusi@ti.com>
	<53471DC5.4090001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <53471DC5.4090001-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/11/2014 01:40 AM, Joel Fernandes wrote:
> On 04/01/2014 08:06 AM, Peter Ujfalusi wrote:
>> We only support DEV_TO_MEM or MEM_TO_DEV directions with edma driver and=
 the
>> check for the direction has been already done in the function calling
>> edma_config_pset().
>> The error reporting is redundant and also the "else if ()" can be remove=
d.
>>
> =

> NAK. Please don't do this. I have been working on MEM_TO_MEM support as
> well so leave it as it is for future.

Sure. It is still valid to say that the error else {} will never going to
happen since you have the same check in the calling function and they alrea=
dy
filtered the non implemented direction.

I'll leave this out from v3.

-- =

P=E9ter

> =

> Thanks,
> -Joel
> =

>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/dma/edma.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>> index 855766672aa9..d954099650ae 100644
>> --- a/drivers/dma/edma.c
>> +++ b/drivers/dma/edma.c
>> @@ -372,14 +372,12 @@ static int edma_config_pset(struct dma_chan *chan,=
 struct edmacc_param *pset,
>>  		src_cidx =3D cidx;
>>  		dst_bidx =3D 0;
>>  		dst_cidx =3D 0;
>> -	} else if (direction =3D=3D DMA_DEV_TO_MEM)  {
>> +	} else {
>> +		/* DMA_DEV_TO_MEM */
>>  		src_bidx =3D 0;
>>  		src_cidx =3D 0;
>>  		dst_bidx =3D acnt;
>>  		dst_cidx =3D cidx;
>> -	} else {
>> -		dev_err(dev, "%s: direction not implemented yet\n", __func__);
>> -		return -EINVAL;
>>  	}
>>  =

>>  	pset->opt =3D EDMA_TCC(EDMA_CHAN_SLOT(echan->ch_num));
>>
> =
