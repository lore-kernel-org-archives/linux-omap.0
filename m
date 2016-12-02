From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Fri, 2 Dec 2016 10:26:06 +0200
Message-ID: <99749615-11be-0e24-0b46-f43112e08574@ti.com>
References: <1480555145-8300-1-git-send-email-matt@ranostay.consulting>
 <e8e9a552-14d9-15eb-bf9a-48fdc79965e2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <e8e9a552-14d9-15eb-bf9a-48fdc79965e2@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Ranostay <matt@ranostay.consulting>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org



On 12/02/2016 10:23 AM, Peter Ujfalusi wrote:
>> @@ -637,12 +638,21 @@ void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
>>   * Here we start the McBSP, by enabling transmitter, receiver or both.
>>   * If no transmitter or receiver is active prior calling, then sample-r=
ate
>>   * generator and frame sync are started.
>> + *
>> + * Also setting of the QoS latency for the FIFO which varies upon the b=
uffer
>> + * size. Approximately 2.3 milliseconds per FIFO location.
>>   */
>>  void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int tx, int rx)
>>  {
>>  	int enable_srg =3D 0;
>> +	int latency =3D mcbsp->pdata->buffer_size * 23;
> =

> I think this is not correct.
> The McBSP FIFO time depends on the sample rate and on the number of
> channels the audio is using. With 8KHz mono you have 12 times more time
> per FIFO element compared to 48KHz stereo.
> =

> As it has been discussed with Tony we should calculate the QoS latency
> in hw_params:
> =

> latency_ms =3D ((FIFOsize - FIFOthreshold) / channels) * 1000/sampling-ra=
te
> =

> On OMAP3.McBSP2 for example (44.1KHz, stereo):
> FIFO threshold 128
>  - DMA request will be triggered when 128 slots are free in the FIFO
>  - at that point we have still 1152 words in the FIFO.
>  - if the C wakeup latency is longer then what it takes to play out the
> samples from the FIFO (13.06ms), we will drain the FIFO and got underflow.
>  - in this case the QOS should be set as 13.06ms
> =

> FIFO threshold 1024
>  - DMA request will be triggered when 1024 slots are free in the FIFO
>  - at that point we have still 256 words in the FIFO.
>  - if the C wakeup latency is longer then what it takes to play out the
> samples from the FIFO (2.9ms), we will drain the FIFO and got underflow.
>  - in this case the QOS should be 2.9ms
> =

> On other McBSPs with 128 word FIFO the required latency is shorter to ens=
ure
> we don't drain the FIFO.

and we still have the issue of full duplex audio when the FIFO threshold
is different for playback and capture...

-- =

P=E9ter
