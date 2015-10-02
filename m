From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 01/11 RESEND] ARM: OMAP: DRA7: hwmod: Add data for McASP3
Date: Fri, 2 Oct 2015 15:48:43 +0300
Message-ID: <560E7D2B.1090100@ti.com>
References: <1442326206-30192-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1509270631440.7947@utopia.booyaka.com>
 <560BB434.6080308@ti.com>
 <alpine.DEB.2.02.1510020854390.11596@utopia.booyaka.com>
 <560E6912.4030902@ti.com> <560E7094.408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <560E7094.408@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/02/2015 02:55 PM, Peter Ujfalusi wrote:
> On 10/02/2015 02:22 PM, Peter Ujfalusi wrote:
>> Paul,
>>
>> On 10/02/2015 12:07 PM, Paul Walmsley wrote:
>>> Hello P=E9ter,
>>>
>>> On Wed, 30 Sep 2015, Peter Ujfalusi wrote:
>>>
>>>> On 09/27/2015 10:02 AM, Paul Walmsley wrote:
>>>>>>  /*
>>>>>> + * 'mcasp' class
>>>>>> + *
>>>>>> + */
>>>>>> +static struct omap_hwmod_class_sysconfig dra7xx_mcasp_sysc =3D {
>>>>>> +	.sysc_offs	=3D 0x0004,
>>>>>> +	.sysc_flags	=3D SYSC_HAS_SIDLEMODE,
>>>>>> +	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
>>>>>> +	.sysc_fields	=3D &omap_hwmod_sysc_type3,
>>>>>> +};
>>>>>> +
>>>>>> +static struct omap_hwmod_class dra7xx_mcasp_hwmod_class =3D {
>>>>>> +	.name	=3D "mcasp",
>>>>>> +	.sysc	=3D &dra7xx_mcasp_sysc,
>>>>>> +};
>>>>>> +
>>>>>> +/* mcasp3 */
>>>>>> +static struct omap_hwmod dra7xx_mcasp3_hwmod =3D {
>>>>>> +	.name		=3D "mcasp3",
>>>>>> +	.class		=3D &dra7xx_mcasp_hwmod_class,
>>>>>> +	.clkdm_name	=3D "l4per2_clkdm",
>>>>>> +	.main_clk	=3D "mcasp3_ahclkx_mux",
>>>>>
>>>>> I'd expect this clock to be something derived from mcasp3_aux_gfclk, =

>>>>> according to Table 24-408 "Clocks and Resets" of SPRUHZ6.  Could you =

>>>>> please doublecheck this?
>>>>
>>>> I can not explain this. If I change the main_clk to "mcasp3_aux_gfclk_=
mux"
>>>> then I can not access to McASP3 register at all.
>>>> I don't see anything popping out in the clock data, nor in other place=
s.
>>>
>>> OK thank you for testing that.  Maybe just add a brief comment along th=
ose =

>>> lines in the hwmod data, above the structure record declaration?
>>
>> Now I more or less figured out the root of the issue. According to the
>> documentations the McASP in dra7xx family has following clocks:
>> ICLK - interface clock
>> GFCLK - functional clock
>> AHCLKX - Transmit high-frequency master clock
>> AHCLKR - Receive high-frequency master clock (on selected instances)
>>
>> In order to access registers all of these clock lines must have valid cl=
ock
>> signal. No other SoC with McASP has this setup.
>> As for why things seams to work when mcasp3_ahclkx_mux is set as main_cl=
k and
>> mcasp3_aux_gfclk_mux is not handled at all?
>> The mcasp3_aux_gfclk_mux by default is from PER_ABE_X1GFCLK we never cha=
nge
>> this. On dra7/72 evm the AHCLKX is reparented to ATL2 clock.
>> When with pm_runtime we enable the device, the mcasp3_ahclkx_mux will be
>> enabled by the SW (and ATL as well) _and_ the mcasp3_aux_gfclk_mux path =
will
>> be enabled by HW w/o SW.
>> The reason why I have had crash when I switched the main_clk to
>> mcasp3_aux_gfclk_mux is that even the path for the mcasp3_ahclkx_mux is
>> enabled by the HW, the ATL itself was not enabled, so it was not generat=
ing
>> the needed clocks. Same goes backwards for the gfclk: if I reparent it to
>> let's say HDMI clock - which is not present, and handle the ahclkx clock=
 I
>> have similar crash.
>> All in all: the McASP3 needs ICLK and both FCLK and AHCLKX to be running=
 in
>> order to be able to access registers.
>>
>> This current setup works fine, the only issue I see is that the refcount=
s for
>> the mcasp3_aux_gfclk_mux path is not reflecting the reality.
>>
>> With Tero we looked at different angles of this and how to solve it w/o
>> considering it as a hack.
>> Either we go with the hwmod data with main_clk set to mcasp3_ahclkx_mux =
and
>> document it in a comment, or:
>> Add new flag HWMOD_OPT_CLKS_NEEDED to hwmods to use to tell that the opt=
ional
>> clocks are not really optional as they are needed to be enabled in order=
 to
>> access to the IP. In omap_hwmod.c's _enable_clocks() and _disable_clocks=
() we
>> call _enable_optional_clocks()/_disable_optional_clocks() if the flag is=
 set
>> for the hwmod and add the ahclkx_mux as optional clock for McASP3.
> =

> This might be awkward to say that the optional clocks are not optional,
> probably would be better to add:
> struct omap_hwmod {
> 	...
> 	struct omap_hwmod_opt_clk	*needed_clks;
> 	...
> 	u8				needed_clks_cnt;
> 	...
> };
> =

> and use the needed_clks in _init_main_clk()/_enable_clocks()/_disable_clo=
cks() ?

Arrgh, but how to deal with this via DT bindings? It will be better to mark
the optional clocks as needed.

-- =

P=E9ter
