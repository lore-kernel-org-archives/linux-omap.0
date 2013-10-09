From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Let DT say what devices should not to
 idled or reset
Date: Wed, 9 Oct 2013 14:19:41 +0530
Message-ID: <525518A5.6030402@ti.com>
References: <1376983966-16490-1-git-send-email-rnayak@ti.com>
 <1376983966-16490-4-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.02.1310090720230.30199@utopia.booyaka.com>
 <525507A4.9010308@ti.com> <52551175.3070705@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52551175.3070705@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-doc@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 09 October 2013 01:49 PM, Benoit Cousson wrote:
> Hi Rajendra,
> =

> On 09/10/2013 09:37, Rajendra Nayak wrote:
>> On Wednesday 09 October 2013 12:54 PM, Paul Walmsley wrote:
>>> Hi Beno=EEt, Rajendra,
>>>
>>> On Tue, 20 Aug 2013, Rajendra Nayak wrote:
>>>
>>>> Now that we have DT bindings to specify which devices on the SoC shoul=
d not
>>>> be reset or idled, get rid of the same information existing as part of=
 the
>>>> hwmod data files and pass this info from DT instead.
>>>>
>>>> For GPMC, the HWMOD_INIT_NO_RESET flag seems to be added in hwmod not =
due to
>>>> any errata around the GPMC IP, but rather because any timings
>>>> set by the bootloader are not being correctly programmed by the kernel.
>>>> This seems like something that needs to be fixed as part of GPMC driver
>>>> in the kernel, and hence the flag is left as is in hwmod, which can be
>>>> removed once the driver does what its expected to.
>>>>
>>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>>> ---
>>>>   arch/arm/boot/dts/am33xx.dtsi              |    2 ++
>>>>   arch/arm/boot/dts/omap4.dtsi               |    3 +++
>>>>   arch/arm/boot/dts/omap5.dtsi               |    2 ++
>>>>   arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    4 ++--
>>>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 +---
>>>>   arch/arm/mach-omap2/omap_hwmod_54xx_data.c |    2 --
>>>>   6 files changed, 10 insertions(+), 7 deletions(-)
>>>
>>> Looking at this one, maybe the best thing for this patch is for Rajendra
>>> to split it into two patches.  Beno=EEt can merge the DTS patch first, =
then
>>> I can merge the hwmod side as a cleanup once the first one goes in.  Th=
at
>>> will avoid conflicts from other DTS and hwmod changes going into the tr=
ee.
>>>
>>> Rajendra, when you do the split, please add in the DT documentation part
>>> from patch 2.  Am going to strip that out from the second patch and just
>>> merge the hwmod changes.
>>>
>>> Sound good?
>>
>> Sure Paul, I'll repost the complete series with proper splits such that =
its
>> easier for you and Benoit to pick them up independently.
> =

> If you could do it soon, I'm about to send an early pull request to Tony =
to avoid the trouble we had last time.

I am sending them right-away Benoit.

> =

> Thanks,
> Benoit
> =
