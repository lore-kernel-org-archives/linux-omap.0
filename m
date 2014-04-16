From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 05/14] arm: common: edma: Select event queue 1 as
	default when booted with DT
Date: Wed, 16 Apr 2014 15:59:28 +0300
Message-ID: <534E7EB0.9000601@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
	<1396357575-30585-6-git-send-email-peter.ujfalusi@ti.com>
	<5347A4FD.1030803@ti.com> <5347ACDE.7040407@ti.com>
	<5347AE49.5020109@ti.com> <5347B7F8.2000508@ti.com>
	<20140411094217.GA32284@intel.com> <5347D2CC.4030407@ti.com>
	<20140411113154.GB32284@intel.com> <5347DEDA.2060008@ti.com>
	<20140411124641.GC32284@intel.com> <534BCCD3.9060805@ti.com>
	<534BD0B5.5000004@ti.com> <534BD788.3050406@ti.com>
	<534BF181.6060503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <534BF181.6060503-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, joelf-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/14/2014 05:32 PM, Sekhar Nori wrote:
>> Yes, you can. But as soon as you have other devices using the same prior=
ity
>> (with eDMA3 at least) and asks for a 'long' transfer it can ruin the aud=
io.
>> During audio playback/capture you execute a long MMC read for example can
>> introduce a glitch.
>>
>>> Moreover, IMHO, encoding it in DT now will make it an ABI. Without a
>>> wide variety of example use cases, I think it is too early to commit to
>>> an ABI.
>>
>> True, but we need to start from somewhere?
> =

> Right, and based on our IRC discussion, we are not really fixing up the
> priority value space. That makes me much more comfortable with the idea.

The only thing we should agree on is the 0 means lowest priority. I think t=
his
will help in case when a new kernel is fed with an older dt blob where the
property does not exist.

> =

>>>> Not sure if we should set the range for this either. What I was thinki=
ng is to
>>>> add an optional new property to be set by the client nodes, using DMA:
>>>>
>>>> mcasp0: mcasp@48038000 {
>>>> 	compatible =3D "ti,am33xx-mcasp-audio";
>>>> 	...
>>>> 	dmas =3D	<&edma 8>,
>>>> 		<&edma 9>;
>>>> 	dma-names =3D "tx", "rx";
>>>> 	dma-priorities =3D <2>, <2>;
>>>> };
>>>>
> =

>>>> We could agree that lower number means lower priority, higher is - wel=
l -
>>>> higher priority.
> =

> Even this does not have to be uniform across, right? The numbers could
> be left to interpretation per-SoC.
> =

>>>> If the dma-priority is missing we should assume lowest priority (0).
>>>> The highest priority depends on the platform. For eDMA3 in AM335x it i=
s three
>>>> level. For designware controller you might have the range 0-8 as valid.
>>>>
>>>> The question is how to get this information into use?
>>>> We can take the priority number in the core when the dma channel is re=
quested
>>>> and add field to "struct dma_chan" in order to store it and the DMA dr=
ivers
>>>> could have access to it.
> =

> How about Vinod's idea of extending dma_slave_config? Priority is
> similar to rest of the runtime setup dmaengine_slave_config() is meant
> to do.

The dma_slave_config is prepared by the client drivers, so they would need =
to
be updated to handle the priority for the DMA. This would lead to duplicated
code - unless we have a small function in dmaengine core to fetch this
information, but still all dmaengine clients would need to call that.
IMHO it would be better to let the dmaengine core to take the priority for =
the
channel when it has been asked so client drivers does not need to know abou=
t it.

-- =

P=E9ter
