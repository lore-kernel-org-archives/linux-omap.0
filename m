From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v3 4/4] OMAP3/4: iommu: adapt to runtime pm
Date: Mon, 7 Nov 2011 12:21:41 -0600
Message-ID: <CAB-zwWhkdv430aD8Osgi7Kyi6ScvhkwZ7BSW1cs3Nyzxc10VYg@mail.gmail.com>
References: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
	<1320185752-568-5-git-send-email-omar.ramirez@ti.com>
	<87obwr1n9i.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <87obwr1n9i.fsf@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, lm <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Nov 4, 2011 at 6:27 PM, Kevin Hilman <khilman@ti.com> wrote:
>> @@ -821,9 +820,7 @@ static irqreturn_t iommu_fault_handler(int irq, =
void *data)
>> =A0 =A0 =A0 if (!obj->refcount)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>>
>> - =A0 =A0 clk_enable(obj->clk);
>> =A0 =A0 =A0 errs =3D iommu_report_fault(obj, &da);
>> - =A0 =A0 clk_disable(obj->clk);
>> =A0 =A0 =A0 if (errs =3D=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>
> I'm not terribly familiar with this IOMMU code, but this one looks
> suspiciou because you're removing the clock calls but not replacing t=
hem
> with runtime PM get/put calls.
>
> I just want to make sure that's intentional. =A0If so, you might want=
 to
> add a comment about that to the changelog.

Yes it is intentional, reason is that in order to get an interrupt,
the device should be powered on in advance, right now it is working
because the modules share a common clock so the users of the
omap-iommu indirectly give power to it. However I made another change
to do pm_runtime_get/put on attach/detach so it doesn't rely on others
to keep the clocks on.

I'll add the comment.

Thanks,

Omar
