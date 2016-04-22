From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Fri, 22 Apr 2016 16:12:55 +0300
Message-ID: <571A2357.3060006@ti.com>
References: <20160412163750.GR5995@atomide.com> <570E3428.5020804@ti.com>
 <20160413152829.GQ5995@atomide.com> <570F4804.4050006@ti.com>
 <20160414165514.GL5995@atomide.com> <570FF163.1050603@ti.com>
 <20160414203457.GM5995@atomide.com> <5710C10A.6040908@ti.com>
 <20160415151651.GP5995@atomide.com> <571145F6.2040508@ti.com>
 <20160418235152.GZ5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160418235152.GZ5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, jarkko.nikula@bitmer.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/19/2016 02:51 AM, Tony Lindgren wrote:
>>> Then all these modules just sit on the L4 interconnet at
>>> separate targets, including the clockdomain.
>>
>> The McBSPi core and it's sidetone is in the same clock domain as the=
 sidetone
>> is using the McBSPi interface clock. It is kind of a leech ;)
>=20
> Well they still are able to use the McBSP interface clock independent=
ly
> AFAIK :)

After trying to hunt down documentation (which I'm still in the process=
):
Initially the sidetone was designed to be built inside of the MCBSPLP i=
p found
in OMAP3, but at some point it has been decided to attach the sidetone =
from
the outside and make wire up the connection like it is ended up in OMAP=
3.
I have not found reasoning, but if I can guess they wanted to avoid thr=
ee
different McBSPLP modules in OMAP3:
type1: McBSP1,4,5 - MCBSPLP with 128 FIFO
type2: McBSP2 - MCBSPLP + 1024+256 FIFO + sidetone
type3: McBSP3 - MCBSPLP + 128 FIFO + sidetone

Also the sidetone is never used again in OMAP4/5 so it made the integra=
tion
and errata (if any) fixes easier for the upcoming SoCs.
But it is just a guess.

=46rom the documents it is also clear that McBSPLP.sidetone is using th=
e
McBSPLP's ICLK, but what is not explained in the TRM is that there are
internal clocks going from McBSP to sidetone for the data bus between t=
hem.
The iclk is needed so the core can kind of run independently from the c=
locks
coming from McBSPLP (for data exchange between the two modules).
If McBSP is not configured these clocks are not running which renders t=
he
sidetone non operational.

I can send a cut down series to fix the current sidetone hwmod (main_cl=
k and
prevent it to look at the PRCM bit) plus reworking the pdata callback s=
o we
can support both legacy and DT boot.

--=20
P=E9ter
