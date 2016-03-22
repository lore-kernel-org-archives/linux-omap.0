From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup
	for sidetone
Date: Tue, 22 Mar 2016 10:53:19 +0200
Message-ID: <56F107FF.8080006@ti.com>
References: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191908070.6629@utopia.booyaka.com>
 <56EFB31C.9090103@ti.com> <20160321202107.GO9329@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160321202107.GO9329@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

Tony,

On 03/21/16 22:21, Tony Lindgren wrote:
> Hi,
> =

> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160321 01:39]:
>>
>> This is also interesting:
>> McBSP2 sidetone is in region 39 and 40 (module and L4 interconnect) whic=
h is
>> unique in case of OMAP34xx and OMAP35xx, but it is overlapping with GPIO=
6 on
>> OMAP36xx. Not sure what are the implications.
> =

> Hmm GPIO6 is in a different L4 segment though? Maybe
> you did not account for the segments?
> =

> 0x49000000 + 0x20000 + 0x2000/0x4000/0x6000 for McBSP
> 0x49000000 + 0x50000 + 0x8000 for GPIO6
> =

> Or maybe I don't understand at which physical address the
> overlap is? :)

The addresses are not overlapping, but the Region Numbers for GPIO6 and McB=
SP2
sidetone in Table 9-114 "Region Allocation for
L4-Per Interconnect". But only in case of OMAP36xx

-- =

P=E9ter
