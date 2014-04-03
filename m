From: Balaji T K <balajitk@ti.com>
Subject: Re: OMAP baseline test results for v3.14
Date: Thu, 3 Apr 2014 19:14:15 +0530
Message-ID: <533D65AF.1060303@ti.com>
References: <alpine.DEB.2.02.1404021600320.15928@utopia.booyaka.com>
 <20140402162102.GB12234@atomide.com>
 <alpine.DEB.2.02.1404021631040.15928@utopia.booyaka.com>
 <20140402163521.GD12234@atomide.com>
 <CAGo_u6qJt5BRQHDvRjWe7Gjt+AfEBxaOPxCnq66QxMUdZew3Vg@mail.gmail.com>
 <20140402171513.GE12234@atomide.com> <20140403133237.GA6019@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140403133237.GA6019@luxor.wired.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, kernel-build-reports@lists.linaro.org, Tony Lindgren <tony@atomide.com>, "menon.nishanth@gmail.com" <menon.nishanth@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 03 April 2014 07:02 PM, Paolo Pisati wrote:
> On Wed, Apr 02, 2014 at 10:15:13AM -0700, Tony Lindgren wrote:
>>> Paul uses MMC filesystem, I use NFS. As Felipe Pointed out as well, I
>>> did rootcause MMC filesystem mount issue here:
>>> http://marc.info/?l=linux-omap&m=139637044425644&w=2
>>
>> Balaji, care to take a look at the issue for MMC? It may
>> be already fixed in next with the PBIAS handling?
> 
> it may be related (or not), but i'm experiencing reboot issues with 3.13/.14 on
> omap4 (panda), and after a bisection i found out that reverting
> 

Do you have any logs for it ?

> commit e002264f7e45d7661b237045577052fd0b40f89c
> Author: Balaji T K <balajitk <at> ti.com>
> Date:   Mon Oct 21 00:25:18 2013 +0530
> 
>      mmc: omap_hsmmc: Fix pbias_disable for omap4
> 
>      pbias_disable is set to protect the mmc pbias i/o cells in DT boot
>      by preventing voltage switch. Currently pbias_disable is enabled only
>      for omap3 and not for omap4 due to reg_offset difference of 0x100.
>      Enable pbias_disable for omap4+ too by using res->start
>      which does not include the reg_offset.
> 
>      Signed-off-by: Balaji T K <balajitk <at> ti.com>
>      Signed-off-by: Chris Ball <cjb <at> laptop.org>
> 
> made it go away: can you point me to those pbias handling patches (i guess
> something about dt-booting handling pbias correctly now)?

It is avaliable in linux-next /mmc-next [1]

[1]
http://git.kernel.org/cgit/linux/kernel/git/cjb/mmc.git/log/?id=refs/heads/mmc-next

mmc: omap_hsmmc: remove pbias workaround
ARM: OMAP: enable SYSCON and REGULATOR_PBIAS in omap2plus_defconfig
ARM: dts: add pbias dt node
mmc: omap_hsmmc: adapt hsmmc to use pbias regulator
regulator: add pbias regulator support
mmc: omap_hsmmc: handle vcc and vcc_aux independently
mmc: omap_hsmmc: use devm_regulator API

Thanks and Regards,
Balaji T K
