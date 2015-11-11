From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 0/3] ARM: OMAP2+ McASP(3) support for DRA7xx family
Date: Wed, 11 Nov 2015 10:01:32 +0200
Message-ID: <5642F5DC.8030902@ti.com>
References: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1510301603530.7580@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1510301603530.7580@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Tony,

On 10/30/2015 06:11 PM, Paul Walmsley wrote:
> Hi P=E9ter
>=20
> On Fri, 30 Oct 2015, Peter Ujfalusi wrote:
>=20
>> Changes since v2:
>> - DTS patch added which is needed because of the clock handling chan=
ges
>>
>> Felip Balbi reported that linux-next is broken right now since the D=
TS part of
>> the earlier series has been applied, but we do not have the mcasp hw=
mod in the
>> kernel:
>> ...
>> [    0.181029] platform 48468000.mcasp: Cannot lookup hwmod 'mcasp3'
>> ...
>> [    6.121072] davinci-mcasp 48468000.mcasp: _od_fail_runtime_resume=
: FIXME: missing hwmod/omap_dev info
>> [    6.130790] ------------[ cut here ]------------
>> [    6.135643] WARNING: CPU: 0 PID: 244 at drivers/bus/omap_l3_noc.c=
:147 l3_interrupt_handler+0x220/0x34c()
>> [    6.145576] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PE=
R2_P3 (Read): Data Access in User mode during Functional access
>> ...
>>
>> This is the followup series for the hwmod changes needed to get audi=
o working
>> on DRA7xx family based boards.
>> The DTS patches has been applied by Tony from the original series:
>> http://www.spinics.net/lists/linux-omap/msg121473.html
>>
>> I have addressed your comments in the hwmod data and did some resear=
ch also
>> regarding to the use of ahclkx as fclk in the original submission.
>> It turned out that McASP _needs_ all clocks to be enabled (fclk, icl=
k and
>> ahclkx/r) to be able to access registers. The original patch where w=
e handled
>> the ahclkx as fclk worked, because the fclk clock got enabled in the=
 HW w/o
>> any SW interaction.
>> All in all, the McASP found in DRA7 needs all clocks to be enabled.
>> To satisfy this I have introduced a new flag to hwmod, which means t=
hat the
>> listed optional clocks need to be handled alongside with the fclk cl=
ock.
>=20
> Thanks.  I'm happy with your series and appreciate the indepth=20
> investigation.  As you probably saw last week, we've hit the limit fo=
r=20
> v4.4-rc1:
>=20
> http://marc.info/?l=3Dlinux-omap&m=3D144564929721826&w=3D2
>=20
> This is why I haven't done anything with this series at this time. =20
> Unfortunately I don't have a DRA7xx board, so I can't do any testing.=
 =20
> But if this series fixes a problem with DRA7xx in linux-next, we shou=
ld=20
> definitely merge it.
>=20
> Tony, if you want to take this now, you can either take it with my ac=
k, or=20
> I can send a pull request.  Or, if you'd prefer to take it for v4.4-r=
c2,=20
> I can send a pull request after v4.4-rc1.

The ARM soc changes for 4.4 are now pulled in to mainline, including th=
e
DRA7/72/X15 audio related DTS changes, but this three patch is not. Thi=
s means
that dra7-evm, dra72-evm and bealge-x15 will not boot from mainline.
Is there a way to push these patches as soon as possible?

Thanks,
P=E9ter
