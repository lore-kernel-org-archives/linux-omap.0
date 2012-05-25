From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 04/11] OMAP: Add early device for system
	control module
Date: Fri, 25 May 2012 14:44:21 +0300
Message-ID: <CAGF5oy9TdCocydigN5gvLbWAMdPLdUP6wQju-ErRBVQF3Dj94g@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-5-git-send-email-eduardo.valentin@ti.com>
	<4FBF6DC7.6070707@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FBF6DC7.6070707@dev.rtsoft.ru>
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

Hello,

On Fri, May 25, 2012 at 2:32 PM, Konstantin Baydarov
<kbaidarov@dev.rtsoft.ru> wrote:
> =A0Hi , Eduardo.
>
> On 05/25/2012 12:25 PM, Eduardo Valentin wrote:
>> This is a way to add an early device for system control module.
>> the code is also requesting for driver registration and probing.
>> Done at early_initcall because at that time, ioremapping is possible.

OK. Which debug config you have?

In any case, that can be solved by not requesting the resource and
passing the address area by other means.

>>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/devices.c | =A0 29 +++++++++++++++++++++++++++++
>> =A01 files changed, 29 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices=
.c
>> index 9332673..58cc5c3 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -40,6 +40,35 @@
>> =A0#define L3_MODULES_MAX_LEN 12
>> =A0#define L3_MODULES 3
>>
>> +static struct resource control_resources[] =3D {
>> + =A0 =A0 [0] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0x4a002000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0x4a0027ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
>> + =A0 =A0 },
>> +};
>> +static struct platform_device control_device =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap-control-core",
>> + =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 .resource =A0 =A0 =A0 =3D control_resources,
>> + =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(control_resources),
>> +};
>> +
>> +static struct platform_device *early_devices[] __initdata =3D {
>> + =A0 =A0 &control_device,
>> +};
>> +
>> +static int __init plat_early_device_setup(void)
>> +{
>> + =A0 =A0 early_platform_add_devices(early_devices,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_S=
IZE(early_devices));
>> + =A0 =A0 early_platform_driver_register_all("early_omap_control");
>> + =A0 =A0 early_platform_driver_probe("early_omap_control", 1, false);
> I checked out git://gitorious.org/omap-thermal/omap-thermal.git omap_scm_=
dev.
> Looks like that calling devm_kzalloc() and platform_get_resource() from e=
arly_initcall is too early.
> I get following backtrace (probably the backtrace is kernel config depend=
ent):
> ...
> [ =A0 =A00.198455] [<c00193b4>] (unwind_backtrace+0x0/0xe0) from [<c02b2a=
10>] (do_raw_spin_lock+0x20/0x134)
> [ =A0 =A00.207977] [<c02b2a10>] (do_raw_spin_lock+0x20/0x134) from [<c05d=
f068>] (_raw_spin_lock_irqsave+0x58/0x64)
> [ =A0 =A00.218109] [<c05df068>] (_raw_spin_lock_irqsave+0x58/0x64) from [=
<c02f03bc>] (devres_add+0x18/0x38)
> [ =A0 =A00.227600] [<c02f03bc>] (devres_add+0x18/0x38) from [<c02f07d0>] =
(devm_kzalloc+0x50/0x5c)
> [ =A0 =A00.236206] [<c02f07d0>] (devm_kzalloc+0x50/0x5c) from [<c05c73a4>=
] (omap_control_probe+0x20/0xe4)
> [ =A0 =A00.245544] [<c05c73a4>] (omap_control_probe+0x20/0xe4) from [<c07=
b3178>] (early_platform_driver_probe+0x1ac/0x23c)
> [ =A0 =A00.256378] [<c07b3178>] (early_platform_driver_probe+0x1ac/0x23c)=
 from [<c0798030>] (plat_early_device_setup+0x2c/0x3c)
> [ =A0 =A00.267700] [<c0798030>] (plat_early_device_setup+0x2c/0x3c) from =
[<c078f8c4>] (do_one_initcall+0x90/0x164)
> [ =A0 =A00.277801] [<c078f8c4>] (do_one_initcall+0x90/0x164) from [<c078f=
9ec>] (kernel_init+0x54/0x1a4)
> [ =A0 =A00.286956] [<c078f9ec>] (kernel_init+0x54/0x1a4) from [<c0013818>=
] (kernel_thread_exit+0x0/0x8)
> [ =A0 =A00.296203] ------------[ cut here ]------------
> [ =A0 =A00.301086] WARNING: at include/linux/kref.h:41 kobject_get+0x24/0=
x48()
> [ =A0 =A00.308044] [<c00193b4>] (unwind_backtrace+0x0/0xe0) from [<c00394=
a4>] (warn_slowpath_common+0x48/0x60)
> [ =A0 =A00.317871] [<c00394a4>] (warn_slowpath_common+0x48/0x60) from [<c=
0039574>] (warn_slowpath_null+0x18/0x1c)
> [ =A0 =A00.327941] [<c0039574>] (warn_slowpath_null+0x18/0x1c) from [<c02=
a59b4>] (kobject_get+0x24/0x48)
> [ =A0 =A00.337219] [<c02a59b4>] (kobject_get+0x24/0x48) from [<c02eb588>]=
 (get_device+0x14/0x1c)
> [ =A0 =A00.345764] [<c02eb588>] (get_device+0x14/0x1c) from [<c02eb66c>] =
(device_add+0xc4/0x594)
> [ =A0 =A00.354370] [<c02eb66c>] (device_add+0xc4/0x594) from [<c03eeab4>]=
 (of_platform_device_create_pdata+0x5c/0x7c)
> [ =A0 =A00.364807] [<c03eeab4>] (of_platform_device_create_pdata+0x5c/0x7=
c) from [<c03eec94>] (of_platform_bus_create+0x1c0/0x258)
> [ =A0 =A00.376403] [<c03eec94>] (of_platform_bus_create+0x1c0/0x258) from=
 [<c03eee4c>] (of_platform_populate+0x5c/0x88)
> [ =A0 =A00.387023] [<c03eee4c>] (of_platform_populate+0x5c/0x88) from [<c=
07b3178>] (early_platform_driver_probe+0x1ac/0x23c)
> [ =A0 =A00.398101] [<c07b3178>] (early_platform_driver_probe+0x1ac/0x23c)=
 from [<c0798030>] (plat_early_device_setup+0x2c/0x3c)
> [ =A0 =A00.409423] [<c0798030>] (plat_early_device_setup+0x2c/0x3c) from =
[<c078f8c4>] (do_one_initcall+0x90/0x164)
> [ =A0 =A00.419586] [<c078f8c4>] (do_one_initcall+0x90/0x164) from [<c078f=
9ec>] (kernel_init+0x54/0x1a4)
> [ =A0 =A00.428771] [<c078f9ec>] (kernel_init+0x54/0x1a4) from [<c0013818>=
] (kernel_thread_exit+0x0/0x8)
> [ =A0 =A00.437957] ---[ end trace da227214a82491b7 ]--
> ...
>
> =A0BR,
> =A0 =A0Konstantin Baydarov.
>
>> +
>> + =A0 =A0 return 0;
>> +}
>> +early_initcall(plat_early_device_setup);
>> +
>> =A0static int omap_init_control(void)
>> =A0{
>> =A0 =A0 =A0 struct omap_hwmod =A0 =A0 =A0 =A0 =A0 =A0 =A0 *oh;
>



-- =


Eduardo Valentin
