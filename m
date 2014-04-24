From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 05/14] arm: common: edma: Select event queue 1 as
	default when booted with DT
Date: Thu, 24 Apr 2014 12:07:09 +0300
Message-ID: <5358D43D.20600@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
	<1396357575-30585-6-git-send-email-peter.ujfalusi@ti.com>
	<5347A4FD.1030803@ti.com> <5347ACDE.7040407@ti.com>
	<5347AE49.5020109@ti.com> <5347B7F8.2000508@ti.com>
	<20140411094217.GA32284@intel.com> <5347D2CC.4030407@ti.com>
	<20140411113154.GB32284@intel.com> <5347DEDA.2060008@ti.com>
	<20140411124641.GC32284@intel.com> <534BCCD3.9060805@ti.com>
	<534BD0B5.5000004@ti.com> <534BD788.3050406@ti.com>
	<534BF181.6060503@ti.com> <534E7EB0.9000601@ti.com>
	<534EAA49.7030702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <534EAA49.7030702-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: joelf-l0cyMroinI0@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/16/2014 07:05 PM, Joel Fernandes wrote:
> On 04/16/2014 07:59 AM, Peter Ujfalusi wrote:
> [..]
>>>>>> If the dma-priority is missing we should assume lowest priority (0).
>>>>>> The highest priority depends on the platform. For eDMA3 in AM335x it=
 is three
>>>>>> level. For designware controller you might have the range 0-8 as val=
id.
>>>>>>
>>>>>> The question is how to get this information into use?
>>>>>> We can take the priority number in the core when the dma channel is =
requested
>>>>>> and add field to "struct dma_chan" in order to store it and the DMA =
drivers
>>>>>> could have access to it.
>>>
>>> How about Vinod's idea of extending dma_slave_config? Priority is
>>> similar to rest of the runtime setup dmaengine_slave_config() is meant
>>> to do.
>>
>> The dma_slave_config is prepared by the client drivers, so they would ne=
ed to
>> be updated to handle the priority for the DMA. This would lead to duplic=
ated
>> code - unless we have a small function in dmaengine core to fetch this
>> information, but still all dmaengine clients would need to call that.
>> IMHO it would be better to let the dmaengine core to take the priority f=
or the
>> channel when it has been asked so client drivers does not need to know a=
bout it.
>>
> =

> I still feel it is much cleaner to keep this out of DT and have audio
> driver configure the channel manually for higher priority. Because,
> AFAIK audio is the only device that uses slave DMA and needs higher
> priority. I'd imagine everyone else who needs high priority, have their
> own dedicated DMAC, so from that sense I don't see the priority
> mechanism being used a lot anywhere else but audio, so atleast we can
> rule out things like code duplication in other drivers. Priority can be
> set to a default of low for those drivers that don't configure the
> channel for priority. I'm also OK with EDMA driver configuring channel
> for higher priority manually for the Cyclic case like you did initially.

So how should we go about this?
I'm fine to select higher priority in the eDMA driver for now when a cyclic
channel is configured and later when we have (if we ever have) generic way =
to
handle DMA channel/transaction priority we can switch eDMA as well to use i=
t.

-- =

P=E9ter
