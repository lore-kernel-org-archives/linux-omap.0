From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v4 1/5] OMAP4: hwmod: Add names for DMIC memory address
 space
Date: Fri, 16 Dec 2011 15:43:31 +0100
Message-ID: <4EEB5913.3090901@ti.com>
References: <1322487943-14280-1-git-send-email-peter.ujfalusi@ti.com> <1322487943-14280-2-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.00.1112152327410.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39131 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755762Ab1LPOnm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 09:43:42 -0500
In-Reply-To: <alpine.DEB.2.00.1112152327410.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 12/16/2011 7:28 AM, Paul Walmsley wrote:
> Hi Beno=EEt
>
> On Mon, 28 Nov 2011, Peter Ujfalusi wrote:
>
>> To be able to get the memory resources by name from
>> the DMIC driver (for MPU and for DMA).
>
> Any comments on this one?  Looks like we'd need to add these names as
> hints in the script.

Maybe not, in theory we should be able to detect the dual mapping and=20
add the proper name. I did that for some other IP in the ABE domain, so=
=20
it should be doable for that one too.

>> Signed-off-by: Peter Ujfalusi<peter.ujfalusi@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

Benoit

>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_44xx_data.c
>> index 7695e5d..8b75c60 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -1028,6 +1028,7 @@ static struct omap_hwmod_dma_info omap44xx_dmi=
c_sdma_reqs[] =3D {
>>
>>   static struct omap_hwmod_addr_space omap44xx_dmic_addrs[] =3D {
>>   	{
>> +		.name		=3D "mpu",
>>   		.pa_start	=3D 0x4012e000,
>>   		.pa_end		=3D 0x4012e07f,
>>   		.flags		=3D ADDR_TYPE_RT
>> @@ -1046,6 +1047,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_ab=
e__dmic =3D {
>>
>>   static struct omap_hwmod_addr_space omap44xx_dmic_dma_addrs[] =3D =
{
>>   	{
>> +		.name		=3D "dma",
>>   		.pa_start	=3D 0x4902e000,
>>   		.pa_end		=3D 0x4902e07f,
>>   		.flags		=3D ADDR_TYPE_RT
>
>
>
> - Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
