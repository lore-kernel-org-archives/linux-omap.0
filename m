From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/7] dmaengine: omap-dma: Complete the cookie first on
 transfer completion
Date: Fri, 22 Jul 2016 14:00:33 +0300
Message-ID: <a4b6fc99-13a9-b78f-b395-8b3e5eb30642@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160714124242.7579-3-peter.ujfalusi@ti.com>
 <20160718103409.GH5783@n2100.arm.linux.org.uk>
 <923b54d6-c7fc-66c2-1c20-d8d74ebed912@ti.com> <877fcg25c4.fsf@belgarion.home>
 <f18ced07-39e4-c336-b788-254c2c130f82@ti.com>
 <20160721094704.GL5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160721094704.GL5783@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, vinod.koul@intel.com, linux-kernel@vger.kernel.org, tony@atomide.com, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/21/16 12:47, Russell King - ARM Linux wrote:
> On Thu, Jul 21, 2016 at 12:33:12PM +0300, Peter Ujfalusi wrote:
>> On 07/20/16 09:26, Robert Jarzmik wrote:
>>> Speaking of which, from a purely design point of view, as long as y=
ou think
>>> beforehand what is your sequence, ie. what is the sequence of your =
link
>>> chaining, completion handling, etc ..., both marking before or afte=
r next tx
>>> start should be fine IMHO.
>>
>> Yes, it might be a bit better from performance point of view if we f=
irst start
>> the pending descriptor (if there is one) then do the vchan_cookie_co=
mplete().
>> On the other hand if we care more about latency and accuracy we shou=
ld
>> complete the transfer first then look for pending descriptors. But s=
ince
>> virt_dma is using a tasklet for the real completion, the latency is =
always
>> going to be when the tasklet is given the chance to execute.
>=20
> I think this shows a slight misunderstanding of the DMA engine API.  =
The
> DMA completion is defined by the API to always happen in tasklet cont=
ext,
> which is why the virt-dma stuff does it that way - and all other DMA
> engine drivers.  It's one of the fundamentals of the API.
>=20
> As it happens in tasklet context, tasklets can be scheduled to run wi=
th
> variable latency, so any use of the DMA engine API which has a predic=
table
> latency around the completion handling is going to be unreliable.
>=20
> Remember also that with circular buffers, there's no guarantee of get=
ting
> period-based completion callbacks - several periods can complete and =
you
> are only guaranteed to get one completion callback.
>=20
> So, the idea that completion callbacks can have anything to do with l=
ow
> latency or accuracy is totally incorrect.

Thanks for refreshing my memory, you are absolutely right.

--=20
P=E9ter
