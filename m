From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 03/11] arm: omap: device: create a device
 for system control module
Date: Fri, 15 Jun 2012 12:22:26 +0300
Message-ID: <CAGF5oy-_6FnZN-0h4JwNhOcABadEq9ZsL7U4gpYndvjsBAZnrw@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-4-git-send-email-eduardo.valentin@ti.com>
	<4FBF7B74.4020302@ti.com> <20120529094400.GA3505@besouro>
	<4FD9EC1B.6010506@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FD9EC1B.6010506@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: balbi@ti.com, kishon@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello Konstantin,

Sorry for the delayed reply.

On Thu, Jun 14, 2012 at 4:50 PM, Konstantin Baydarov
<kbaidarov@dev.rtsoft.ru> wrote:
> =A0Hi.
>
> On 05/29/2012 01:44 PM, Eduardo Valentin wrote:
>> On Fri, May 25, 2012 at 02:30:44PM +0200, Cousson Benoit wrote:
>>> On 5/25/2012 10:25 AM, Eduardo Valentin wrote:
>>>> From: Kishon Vijay Abraham I<kishon@ti.com>
>>>>
>>>> Extracts the device data from hwmod database and create a platform dev=
ice
>>>> using omap device build.
>>>>
>>>> The device build is done during postcore_initcall.
>>> Do you still need that since you are supporting only DT?
>>> The device will be built automatically in the DT case.
>> In fact this is not needed for DT only probing. Dropping this one.
> Yes, platform device(struct platform_device) will be built automatically,=
 but omap device(struct omap_device) will not be built.

The platform_device will be built as well as the omap_device. There
are hooks at the platform_device creation that will proceed with the
omap_device deployment. Please check:
arch/arm/plat-omap/omap_device.c: _omap_device_notifier_call and
omap_device_build_from_dt

> Also when omap device is allocated(omap_device_alloc) hwmod_clocks are re=
gistered, but in case of ctrl_module_core device - no new clock are registe=
red.
> So, is it fine to drop omap device and skip omap_device_build() call?

As explained above, when booting with DT, you will get both, pdev and omap_=
dev.

>
> =A0BR,
> =A0 =A0Konstantin Baydarov.

All best,

Eduardo

>
>>
>>> Regards,
>>> Benoit
>>>
>>>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>>>> Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
>>>> ---
>>>> =A0arch/arm/mach-omap2/devices.c | =A0 26 ++++++++++++++++++++++++++
>>>> =A01 files changed, 26 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devic=
es.c
>>>> index 152c266..9332673 100644
>>>> --- a/arch/arm/mach-omap2/devices.c
>>>> +++ b/arch/arm/mach-omap2/devices.c
>>>> @@ -40,6 +40,32 @@
>>>> =A0#define L3_MODULES_MAX_LEN 12
>>>> =A0#define L3_MODULES 3
>>>>
>>>> +static int omap_init_control(void)
>>>> +{
>>>> + =A0 struct omap_hwmod =A0 =A0 =A0 =A0 =A0 =A0 =A0 *oh;
>>>> + =A0 struct platform_device =A0 =A0 =A0 =A0 =A0*pdev;
>>>> + =A0 const char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*oh_name, =
*name;
>>>> +
>>>> + =A0 oh_name =3D "ctrl_module_core";
>>>> + =A0 name =3D "omap-control-core";
>>>> +
>>>> + =A0 oh =3D omap_hwmod_lookup(oh_name);
>>>> + =A0 if (!oh) {
>>>> + =A0 =A0 =A0 =A0 =A0 pr_err("Could not lookup hwmod for %s\n", oh_nam=
e);
>>>> + =A0 =A0 =A0 =A0 =A0 return PTR_ERR(oh);
>>>> + =A0 }
>>>> +
>>>> + =A0 pdev =3D omap_device_build(name, -1, oh, NULL, 0, NULL, 0, true)=
;
>>>> + =A0 if (IS_ERR(pdev)) {
>>>> + =A0 =A0 =A0 =A0 =A0 pr_err("Could not build omap_device for %s %s\n"=
,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name, oh_name);
>>>> + =A0 =A0 =A0 =A0 =A0 return PTR_ERR(pdev);
>>>> + =A0 }
>>>> +
>>>> + =A0 return 0;
>>>> +}
>>>> +postcore_initcall(omap_init_control);
>>>> +
>>>> =A0static int __init omap3_l3_init(void)
>>>> =A0{
>>>> =A0 =A0 struct omap_hwmod *oh;
>



--=20

Eduardo Valentin
