From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC] dmaengine: omap-dma: Start DMA without delay
Date: Tue, 2 Apr 2013 10:14:10 +0200
Message-ID: <515A9352.5060702@ti.com>
References: <1364566323-24144-1-git-send-email-peter.ujfalusi@ti.com> <20130329173100.GV30923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130329173100.GV30923@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

Russell,

On 03/29/2013 06:31 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 29, 2013 at 03:12:03PM +0100, Peter Ujfalusi wrote:
>> Remove the use of a tasklet to start the DMA channel when issue_pend=
ing is
>> called.
>> The use of tasklet delays the DMA start which can cause issues at dr=
ivers,
>> for example the audio drivers expect that the DMA is started right a=
way.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi Russell,
>>
>> I know you are against removing the tasklet since you have planed to=
 move the
>> omap-dma to use runtime/dynamic DMA channel use.
>> I have looked at the amba-pl08x.c driver which is doing that exactly=
 (as you
>> pointed out that to me). AMBA did not use tasklet either and I'm sur=
e we can
>> change the omap-dma driver to do the same in a same way as we could =
have done it
>> with the tasklet use.
>=20
> It's rather sad that you're ignoring what I'm saying, and going by wh=
at
> another DMA engine driver - which is self contained - is doing, rathe=
r
> than listening to my arguments against that approach.

The reason I send this as RFC to start a discussion to find out how we =
should
handle this. I were to ignore what you were saying I would have just se=
nt a
PATCH instead.

I don't think that the tasklet is the solution for the runtime DMA chan=
nel
selection. We can do it in a same way as AMBA has been doing. In this w=
ay we
can handle all cases with the same code.
The pre-allocating of channels and starting the DMA right away is diffe=
rent issue.

What need to be done anyway is to convert the remaining drivers to use =
dmaengine:
drivers/usb/musb/tusb6010_omap.c
drivers/usb/gadget/omap_udc.c
drivers/mtd/onenand/omap2.c
drivers/media/platform/omap3isp/isphist.c
drivers/media/platform/soc_camera/omap1_camera.c
drivers/media/platform/omap/omap_vout_vrfb.c

When that is done we can remove the arch/arm/plat-omap/dma.c and migrat=
e the
code under dmaengine to restructure it and finally we can have runtime =
channel
allocation.

--=20
P=E9ter
