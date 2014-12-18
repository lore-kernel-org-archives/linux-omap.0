From: Nishanth Menon <nm@ti.com>
Subject: Re: Fwd: next boot: 101 boots: 89 pass, 12 fail (next-20141216)
Date: Thu, 18 Dec 2014 16:37:28 -0600
Message-ID: <54935728.9010405@ti.com>
References: <E1Y0lcK-00026B-7I@ip-10-35-177-41.ec2.internal>	<CAMAWPa98kyaUJpt=GLw4cH7fkg+8BkrA0kds=H-2-4fWXy_tqw@mail.gmail.com>	<54909E30.4040300@ti.com>	<CAKohponYEqhPjZmk_WH+TbNPLHEM5HWxta7CLUoM5+2iHYw_zw@mail.gmail.com>	<CAMAWPa-_OZC3ynKYxbtXK4=z-z720JxXigT23umscMTm8VWAzA@mail.gmail.com> <CAKohpokWe+MGNM7N8recCsV7O6pFDdJ89QKnqyj9TK_WRtW7yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAKohpokWe+MGNM7N8recCsV7O6pFDdJ89QKnqyj9TK_WRtW7yQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On 12/17/2014 08:01 PM, Viresh Kumar wrote:
> On 17 December 2014 at 22:46, Kevin Hilman <khilman@kernel.org> wrote=
:
>> So this looks like a bug that has been hiding, but just exposed
>> because cpufreq-cpu0 (now cpufreq-dt) was not getting built-in since
>> before v3.18.
>>
>> On omap4-panda-es, v3.18 with multi_v7_defconfig + CPUFREQ_DT enable=
d,
>> I see this:
>>
>> [    2.062103] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted
>> freq: 699977 KHz
>> [    2.070404] cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial
>> frequency changed to: 700000 KHz
>>
>> No BUG.  But, in next-20141216,
>>
>> [    2.083953] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted
>> freq: 699977 KHz
>> [    2.091949] cpu cpu0: failed to set clock rate: -22
>> [    2.097045] cpufreq: __target_index: Failed to change cpu frequen=
cy: -22
>>
>> And then the BUG.
>>
>> So the BUG() itself isn't the problem with this regression.  There's
>> been a fair amount of changes in the OMAP clk driver (including some
>> other regressions), so I suspect the culprit to be lying somewhere i=
n
>> the recent OMAP clock changes.
>=20
> Yeah. I agree..
>=20
https://git.linaro.org/people/mike.turquette/linux.git/commit/6f8e853d1=
8a98ee95832ffebfaa288d42ae28cd5

=46inally makes it work.

build warnings actually did give an indication of the issue at hand..
> next-20141216
> arch/arm/mach-omap2/cclock3xxx_data.c:262:2: warning: initialization =
from incompatible pointer type [enabled by default]
> arch/arm/mach-omap2/cclock3xxx_data.c:262:2: warning: (near initializ=
ation for =E2=80=98dpll1_ck_ops.determine_rate=E2=80=99) [enabled by de=
fault]
> arch/arm/mach-omap2/cclock3xxx_data.c:375:2: warning: initialization =
from incompatible pointer type [enabled by default]
> arch/arm/mach-omap2/cclock3xxx_data.c:375:2: warning: (near initializ=
ation for =E2=80=98dpll4_ck_ops.determine_rate=E2=80=99) [enabled by de=
fault]
> drivers/clk/ti/dpll.c:38:2: warning: initialization from incompatible=
 pointer type [enabled by default]
> drivers/clk/ti/dpll.c:38:2: warning: (near initialization for =E2=80=98=
dpll_m4xen_ck_ops.determine_rate=E2=80=99) [enabled by default]
> drivers/clk/ti/dpll.c:61:2: warning: initialization from incompatible=
 pointer type [enabled by default]
> drivers/clk/ti/dpll.c:61:2: warning: (near initialization for =E2=80=98=
dpll_ck_ops.determine_rate=E2=80=99) [enabled by default]
> drivers/clk/ti/dpll.c:72:2: warning: initialization from incompatible=
 pointer type [enabled by default]
> drivers/clk/ti/dpll.c:72:2: warning: (near initialization for =E2=80=98=
dpll_no_gate_ck_ops.determine_rate=E2=80=99) [enabled by default]
> drivers/clk/ti/dpll.c:111:2: warning: initialization from incompatibl=
e pointer type [enabled by default]
> drivers/clk/ti/dpll.c:111:2: warning: (near initialization for =E2=80=
=98omap3_dpll_ck_ops.determine_rate=E2=80=99) [enabled by default]
> drivers/clk/ti/dpll.c:123:2: warning: initialization from incompatibl=
e pointer type [enabled by default]
> drivers/clk/ti/dpll.c:123:2: warning: (near initialization for =E2=80=
=98omap3_dpll_per_ck_ops.determine_rate=E2=80=99) [enabled by default]


As of next-20141218 things seem to have settled down a bit.
next-20141218 + https://patchwork.kernel.org/patch/5484401/

Various platforms I have access to looks like the following: it is a
pretty simple script, and I am still getting my remote farm to work
properly when scripts are downloaded over serial port.. but anyways..
> next-20141218
>  1:                     am335x-evm: BOOT: PASS: err=3D10 warn=3D25, C=
PUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s2BvPhDIrP
>  2:                      am335x-sk: BOOT: PASS: err=3D9 warn=3D26, CP=
UFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s21kzAb5L3
>  3:                     am3517-evm: BOOT: FAIL: http://slexy.org/raw/=
s202ZptHTS (script download failed + a warning has popped up for OPP)
>  4:                      am37x-evm: BOOT: FAIL: http://slexy.org/raw/=
s20pvU2Nl2 (script download fail)
>  5:                      am437x-sk: BOOT: PASS: crit=3D2 err=3D13 war=
n=3D57, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s2hKPxe9YG
>  6:                    am43xx-epos: BOOT: PASS: crit=3D2 err=3D16 war=
n=3D58, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s2R6OoHCBj
>  7:                   am43xx-gpevm: BOOT: PASS: crit=3D2 err=3D13 war=
n=3D57, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s20fG9U1ZL
>  8:    BeagleBoard-X15(am57xx-evm): BOOT: PASS: err=3D20 warn=3D24, C=
PUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s2qzlorZWB
>  9:                 BeagleBoard-XM: BOOT: PASS: err=3D9 warn=3D19, CP=
UFreq: PASS, CPUIdle: FAIL: http://slexy.org/raw/s2OzLVwqPy
> 10:            beagleboard-vanilla: BOOT: PASS: err=3D9 warn=3D25, CP=
UFreq: PASS, CPUIdle: FAIL: http://slexy.org/raw/s21EMHNZVl
> 11:               beaglebone-black: BOOT: PASS: err=3D8 warn=3D25, CP=
UFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s2quawv4Qe
> 12:                     beaglebone: BOOT: PASS: err=3D9 warn=3D20, CP=
UFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s2iCPBeBSA
> 13:                     craneboard: BOOT: PASS: err=3D21 warn=3D93, C=
PUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s21Mshl31r
> 14:                     dra72x-evm: BOOT: PASS: crit=3D2 err=3D14 war=
n=3D27, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s2JiZnJlRL
> 15:                     dra7xx-evm: BOOT: PASS: err=3D11 warn=3D31, C=
PUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s20g14WWfL
> 16:         OMAP3430-Labrador(LDP): BOOT: PASS: err=3D7 warn=3D25, CP=
UFreq: PASS, CPUIdle: FAIL: http://slexy.org/raw/s2PZR2j1Kw
> 17:                           n900: BOOT: FAIL: http://slexy.org/raw/=
s2lHkDllfG (I have been seeing this for a while - not reproducible on T=
ony's setup.. not a regression)
> 18:                      omap5-evm: BOOT: PASS: err=3D15 warn=3D24, C=
PUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s21GJKUu8d
> 19:                  pandaboard-es: BOOT: PASS: err=3D20 warn=3D33, C=
PUFreq: PASS, CPUIdle: PASS: http://slexy.org/raw/s21X5eWQnW
> 20:             pandaboard-vanilla: BOOT: PASS: err=3D20 warn=3D31, C=
PUFreq: PASS, CPUIdle: PASS: http://slexy.org/raw/s21HadWaKr
> 21:                        sdp2430: BOOT: FAIL: http://slexy.org/raw/=
s284xHOf52 (script download fail)
> 22:                        sdp3430: BOOT: PASS: err=3D22 warn=3D28, C=
PUFreq: PASS, CPUIdle: FAIL: http://slexy.org/raw/s2GJpDG16e
> 23:                        sdp4430: BOOT: PASS: err=3D21 warn=3D33, C=
PUFreq: PASS, CPUIdle: PASS: http://slexy.org/raw/s21ChfWSXs
> TOTAL =3D 23 boards, Booted Boards =3D 19, No Boot boards =3D 4

script download fail does imply my farm has still issues to resolve..
but anyways.. more or less we are back operational again since it was
broken by next-20141216

--=20
Regards,
Nishanth Menon
