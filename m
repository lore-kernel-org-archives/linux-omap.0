From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 06/11] OMAP2+: use control module mfd
	driver in omap_type
Date: Mon, 28 May 2012 15:32:50 +0530
Message-ID: <CAMQu2gyjJdJZKAf+TJwQfQ2BgAXe_s-soTcs7Am6O4+yy=7cLQ@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-7-git-send-email-eduardo.valentin@ti.com>
	<4FBF80D5.2000600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FBF80D5.2000600@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 25, 2012 at 6:23 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Eduardo,
>
>
> On 5/25/2012 10:25 AM, Eduardo Valentin wrote:
>>
>> OMAP system control module can be probed early, then
>> omap_type is safe to use its APIs.
>>
>> TODO: add support for other omap versions
>>
>> Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/id.c | =A0 16 +++++++++++++++-
>> =A01 files changed, 15 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>> index 5bb9746..acfd698 100644
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -18,6 +18,7 @@
>> =A0#include<linux/kernel.h>
>> =A0#include<linux/init.h>
>> =A0#include<linux/io.h>
>> +#include<linux/mfd/omap_control.h>
>>
>> =A0#include<asm/cputype.h>
>>
>> @@ -40,8 +41,14 @@ EXPORT_SYMBOL(omap_rev);
>>
>> =A0int omap_type(void)
>> =A0{
>> + =A0 =A0 =A0 struct device *scm;
>> + =A0 =A0 =A0 int ret =3D 0;
>> =A0 =A0 =A0 =A0u32 val =3D 0;
>>
>> + =A0 =A0 =A0 scm =3D omap_control_get();
>> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(scm))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> =A0 =A0 =A0 =A0if (cpu_is_omap24xx()) {
>
>
> OK, not really related to that patch, but the previous cpu_is_omap24xx ma=
kes
> me think of that :-)
>
> What about the omap<X>_check_revision used by cpu_is_XXX?
>
> This call is the very first one to require the control module access in
> order to get the ID_CODE inside the control module.
>
> So far it still use that ugly hard coded phys -> virtual address macro th=
at
> is sued for that.
>
Agree with Benoits comment. One way to deal with this is,
store the register offset with init and then just use it here.

That way you can get rid of all cpu_is_XXXX() from this function.

Regards
Santosh
