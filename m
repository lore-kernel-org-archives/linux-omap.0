From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v3 4/4] OMAP3/4: iommu: adapt to runtime pm
Date: Wed, 2 Nov 2011 10:22:04 -0500
Message-ID: <CAB-zwWgsL1aLxg62vy8EnQ_CrotQ4qVFpw-p0DxkweUPQ+poQw@mail.gmail.com>
References: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
	<1320185752-568-5-git-send-email-omar.ramirez@ti.com>
	<CAJ0PZbSpxtp1bvbdWxK-hsg=XUbfodgY-7D37rOn=s3yB-Upjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJ0PZbSpxtp1bvbdWxK-hsg=XUbfodgY-7D37rOn=s3yB-Upjw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Roedel, Joerg" <Joerg.Roedel@amd.com>, lkml <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, lm <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi MyungJoo,

On Wed, Nov 2, 2011 at 5:16 AM, MyungJoo Ham <myungjoo.ham@gmail.com> wrote:
> On Wed, Nov 2, 2011 at 7:15 AM, Omar Ramirez Luna <omar.ramirez@ti.com> w=
rote:
>> Use runtime PM functionality interfaced with hwmod enable/idle
>> functions, to replace direct clock operations, reset and sysconfig
>> handling.
>>
>> Tidspbridge uses a macro removed with this patch, for now the value
>> is hardcoded to avoid breaking compilation.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/iommu2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 17 --------
>> =A0arch/arm/mach-omap2/omap-iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A01 -
>> =A0arch/arm/plat-omap/include/plat/iommu.h =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 -
>> =A0arch/arm/plat-omap/include/plat/iommu2.h =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 -
>> =A0drivers/iommu/omap-iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 46 ++++++++-------------
>> =A0drivers/staging/tidspbridge/core/tiomap3430_pwr.c | =A0 =A02 +-
>> =A06 files changed, 19 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
>> index bbbf747..3c55be0 100644
>> --- a/drivers/iommu/omap-iommu.c
>> +++ b/drivers/iommu/omap-iommu.c
>> @@ -123,11 +123,11 @@ static int iommu_enable(struct omap_iommu *obj)
>> =A0 =A0 =A0 =A0if (!arch_iommu)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>>
>> - =A0 =A0 =A0 clk_enable(obj->clk);
>> + =A0 =A0 =A0 pm_runtime_enable(obj->dev);
>> + =A0 =A0 =A0 pm_runtime_get_sync(obj->dev);
>>
>> =A0 =A0 =A0 =A0err =3D arch_iommu->enable(obj);
>>
>> - =A0 =A0 =A0 clk_disable(obj->clk);
>> =A0 =A0 =A0 =A0return err;
>> =A0}
>>
>> @@ -136,11 +136,10 @@ static void iommu_disable(struct omap_iommu *obj)
>> =A0 =A0 =A0 =A0if (!obj)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>
>> - =A0 =A0 =A0 clk_enable(obj->clk);
>> -
>> =A0 =A0 =A0 =A0arch_iommu->disable(obj);
>>
>> - =A0 =A0 =A0 clk_disable(obj->clk);
>> + =A0 =A0 =A0 pm_runtime_put_sync(obj->dev);
>> + =A0 =A0 =A0 pm_runtime_disable(obj->dev);
>> =A0}
> I'm just curious here... Is there any reason to do
> pm_runtime_enable/disable at iommu_enable/iommu_disable which are
> called by iommu_attach/detach?
> I thought that normally, ideal locations of pm_runtime_enable/disable
> for such devices are in probe/remove() because it assures that the
> device is suspended after the probe.
> It seems that the device might be kept on after probe and before the
> first iommu_attach if it is default-on.

The default state of these MMUs is on reset and needs to be deasserted
to be used, but you're right, it makes more sense to move
pm_runtime_enable/disable calls to probe/remove. I'll wait a bit, do
this change and resubmit.

Thanks for the comment,

Omar
