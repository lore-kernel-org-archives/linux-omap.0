From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v2 01/13] OMAP: hwmod: Add member 'name' to
 omap_hwmod_addr_space struct
Date: Mon, 7 Feb 2011 11:32:06 +0530
Message-ID: <AANLkTinVYk8gdvMMfEh=79R_gvt1FqsorEuhmPToX=38@mail.gmail.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<1296485437-12806-2-git-send-email-kishon@ti.com>
	<8762szpor3.fsf@ti.com> <4D4C5FDC.7050008@ti.com>
	<87d3n7la3a.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <87d3n7la3a.fsf@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Basak, Partha" <p-basak2@ti.com>, "Varadarajan,
	Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Sat, Feb 5, 2011 at 3:46 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Cousson, Benoit" <b-cousson@ti.com> writes:
>
>> On 2/4/2011 8:45 PM, Hilman, Kevin wrote:
>>> Kishon Vijay Abraham I<kishon@ti.com> =A0writes:
>>>
>>>> Adds a structure member 'name' to 'omap_hwmod_addr_space' structure.
>>>> The drivers can use platform_get_resource_byname() to get resource of
>>>> type 'IORESOURCE_MEM' by name so that it need not rely on the order to=
 get
>>>> the proper resource.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>>> ---
>>>> =A0 arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
1 +
>>>> =A0 arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A04 +++-
>>>> =A0 2 files changed, 4 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/om=
ap_hwmod.c
>>>> index 709543a..7bd4900 100644
>>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>>> @@ -1898,6 +1898,7 @@ int omap_hwmod_fill_resources(struct omap_hwmod =
*oh, struct resource *res)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 os =3D oh->slaves[i];
>>>>
>>>> =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j< =A0os->addr_cnt; j++) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (res + r)->name =3D (os->addr + =
j)->name;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (res + r)->start =3D (os->addr=
 + j)->pa_start;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (res + r)->end =3D (os->addr +=
 j)->pa_end;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (res + r)->flags =3D IORESOURC=
E_MEM;
>>>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/p=
lat-omap/include/plat/omap_hwmod.h
>>>> index 76f0274..85899a7 100644
>>>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>>> @@ -178,7 +178,8 @@ struct omap_hwmod_omap2_firewall {
>>>> =A0 #define ADDR_TYPE_RT =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<< =A01)
>>>>
>>>> =A0 /**
>>>> - * struct omap_hwmod_addr_space - MPU address space handled by the hw=
mod
>>>> + * struct omap_hwmod_addr_space - address space handled by the hwmod
>>>
>>> Any reason you modified the comment here?
>>
>> The idea of that patch is to allow hwmod to provide address space
>> accessible from SDMA (though L3). Hence the suppression of the MPU.
>> In the future, we might even be able to provide the address for the
>> DSP or the IPU viewpoint
>>
>
> OK, this rationale is missing from the changelog, and seems very much
> unrelated to $SUBJECT patch.

   ok. Will change it in the next version.

>
> Kevin
>
>
>
