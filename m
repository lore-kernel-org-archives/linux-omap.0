From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Let DT say what devices should not to
 idled or reset
Date: Wed, 09 Oct 2013 10:19:01 +0200
Message-ID: <52551175.3070705@baylibre.com>
References: <1376983966-16490-1-git-send-email-rnayak@ti.com> <1376983966-16490-4-git-send-email-rnayak@ti.com> <alpine.DEB.2.02.1310090720230.30199@utopia.booyaka.com> <525507A4.9010308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <525507A4.9010308@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Rajendra,

On 09/10/2013 09:37, Rajendra Nayak wrote:
> On Wednesday 09 October 2013 12:54 PM, Paul Walmsley wrote:
>> Hi Beno=EEt, Rajendra,
>>
>> On Tue, 20 Aug 2013, Rajendra Nayak wrote:
>>
>>> Now that we have DT bindings to specify which devices on the SoC sh=
ould not
>>> be reset or idled, get rid of the same information existing as part=
 of the
>>> hwmod data files and pass this info from DT instead.
>>>
>>> For GPMC, the HWMOD_INIT_NO_RESET flag seems to be added in hwmod n=
ot due to
>>> any errata around the GPMC IP, but rather because any timings
>>> set by the bootloader are not being correctly programmed by the ker=
nel.
>>> This seems like something that needs to be fixed as part of GPMC dr=
iver
>>> in the kernel, and hence the flag is left as is in hwmod, which can=
 be
>>> removed once the driver does what its expected to.
>>>
>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>> ---
>>>   arch/arm/boot/dts/am33xx.dtsi              |    2 ++
>>>   arch/arm/boot/dts/omap4.dtsi               |    3 +++
>>>   arch/arm/boot/dts/omap5.dtsi               |    2 ++
>>>   arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    4 ++--
>>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 +---
>>>   arch/arm/mach-omap2/omap_hwmod_54xx_data.c |    2 --
>>>   6 files changed, 10 insertions(+), 7 deletions(-)
>>
>> Looking at this one, maybe the best thing for this patch is for Raje=
ndra
>> to split it into two patches.  Beno=EEt can merge the DTS patch firs=
t, then
>> I can merge the hwmod side as a cleanup once the first one goes in. =
 That
>> will avoid conflicts from other DTS and hwmod changes going into the=
 tree.
>>
>> Rajendra, when you do the split, please add in the DT documentation =
part
>> from patch 2.  Am going to strip that out from the second patch and =
just
>> merge the hwmod changes.
>>
>> Sound good?
>
> Sure Paul, I'll repost the complete series with proper splits such th=
at its
> easier for you and Benoit to pick them up independently.

If you could do it soon, I'm about to send an early pull request to Ton=
y=20
to avoid the trouble we had last time.

Thanks,
Benoit

