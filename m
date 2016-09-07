From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Wed, 7 Sep 2016 17:31:24 +0300
Message-ID: <1b82e33a-7db5-81ed-de4f-75847f840088@ti.com>
References: <20160831165959.3sldcjxaci3kdx6z@atomide.com>
 <eef88aa4-b829-1889-f083-eb0359c0dac6@ti.com>
 <20160831194107.wijnbmdns2jjvzkv@atomide.com>
 <5af44090-6902-2ade-be78-378843757a0a@ti.com>
 <20160901145006.xr3ux63cg6f5bh7p@atomide.com>
 <b3a254b2-948f-f04d-3289-fb8fb9f9ab23@ti.com>
 <20160902145604.nlixopwza76kfgbz@atomide.com>
 <c8f293f6-db2e-e518-7566-2cd92eb06ec0@ti.com>
 <20160902204049.uhp4oosu3oc4k5v6@atomide.com>
 <7d1c9a2f-60ae-2d83-f7dc-55fe476dbccb@ti.com>
 <20160906201649.fx4vhuqmnziwshoe@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160906201649.fx4vhuqmnziwshoe@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Machel <pavel@ucw.cz>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/06/2016 11:16 PM, Tony Lindgren wrote:
>> While the calculation is correct for the wake latency requirements, ther=
e is a
>> flip side:
>> FIFO threshold 128:
>> - wake threshold is ~13.06ms to ensure that we don't drain the FIFO
>> - DMA requests are coming at 1.45ms rate.
>>
>> While we could take a C state which would take ~13.06ms to leave, in rea=
lity
>> the system will be busy to respond to the DMA request coming in every 1.=
45ms.
>>
>> FIFO threshold is 1024:
>> - wake threshold is ~2.9ms to ensure that we don't drain the FIFO
>> - DMA requests are coming at 11.6ms rate.
>>
>> In this case we only going to allow C state from which we can leave under
>> 2.9ms, but between DMA burst we have 11.6ms. We could be in deeper state=
, but
>> we are going to be woken up by the DMA request and after the DMA request=
 we
>> have ~2.9ms before the FIFO is empty...
>>
>> So either we allow deeper C state (threshold 128) which we might not abl=
e to
>> take to the 'fast' DMA requests, or we only allow shallow C state (thres=
hold
>> 1024), and have more time between the DMA requests.
>>
>> Is this makes sense?
> =

> Makes sense. Do you have a formula or updated patch I can test here?
> Then we can add comments about the possible unaccounted latencies that
> can be worked out as needed.

Not yet, but I'll try to come up with something in the coming days.

btw: I have tried the idle off on beagbeboard-xm with audio, but even w/o t=
he
qos it is not triggering. w/o audio I hit off but if audio is running, not.

btw2: if you set the qos to 30ms and set the mcbsp2 threshold to 1024 (or
leave it as default) do you have audio glitches? I think if we hit C6 we
should not be able to wake up in time...

>>> The dma setup, complete, and idle latencies here can be probably
>>> be measured with hrtimer :) That still does not explain we don't
>>> miss anything in retention idle currently.
>>>
>>>> I don't know the PM code that well, but is there a way to set attribut=
e to a
>>>> device to tell how deep C state it can tolerate on the given board or =
SoC?
>>>
>>> I believe we can only set the pm_qos latency requirements and there
>>> is no direct limiting of C states. Then I think the idea of
>>> dev_pm_qos and set_latency_tolerance callback is that it allows the
>>> SoC specific code to select the allowed C states. So if we
>>> implemented set_latency_tolerance in the cpuidle driver, we could
>>> tinker directly with the C states for latencies.
>>
>> What we can agree on is that OFF need to be blocked when audio is in use=
. But
>> I'm not sure what is the correct way.
> =

> AFAIK pm_qos is the only Linux generic way to block certain C states.
> =

> Regards,
> =

> Tony
> =



-- =

P=E9ter
