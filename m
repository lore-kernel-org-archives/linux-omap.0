From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 13/18] dma: edma: Print the direction value
 as well when it is not supported
Date: Thu, 13 Mar 2014 15:40:05 +0200
Message-ID: <5321B535.5040802@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
 <1394702320-21743-14-git-send-email-peter.ujfalusi@ti.com>
 <1394715793.28803.240.camel@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1394715793.28803.240.camel@smile.fi.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Liam Girdwood <lgirdwood@gmail.com>, "joelf@ti.com" <joelf@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jyri Sarha <jsarha@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, "mporter@linaro.org" <mporter@linaro.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 03/13/2014 03:03 PM, Shevchenko, Andriy wrote:
> On Thu, 2014-03-13 at 11:18 +0200, Peter Ujfalusi wrote:
>> In case of not supported direction it is better to print the direction a=
lso.
>> It is unlikely, but in such an event it helps with the debugging.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/edma.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>> index 47abaac7eb18..69dd4e3de67e 100644
>> --- a/drivers/dma/edma.c
>> +++ b/drivers/dma/edma.c
>> @@ -426,7 +426,7 @@ static struct dma_async_tx_descriptor *edma_prep_sla=
ve_sg(
>>  		dev_width =3D echan->cfg.dst_addr_width;
>>  		burst =3D echan->cfg.dst_maxburst;
>>  	} else {
>> -		dev_err(dev, "%s: bad direction?\n", __func__);
>> +		dev_err(dev, "%s: bad direction: %d\n", __func__, direction);
> =

> Is it possible to have direction less than zero? Maybe %u?

It is 'enum dma_transfer_direction direction'. %d should be fine.

> =

>>  		return NULL;
>>  	}
>>  =

>> @@ -519,7 +519,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma=
_cyclic(
>>  		dev_width =3D echan->cfg.dst_addr_width;
>>  		burst =3D echan->cfg.dst_maxburst;
>>  	} else {
>> -		dev_err(dev, "%s: bad direction?\n", __func__);
>> +		dev_err(dev, "%s: bad direction: %d\n", __func__, direction);
> =

> Ditto.
> =

>>  		return NULL;
>>  	}
>>  =

> =

> =



-- =

P=E9ter
