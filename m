From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [GIT PULL] fixes for tidspbridge 2.6.37-rc1
Date: Tue, 9 Nov 2010 01:00:59 +0200
Message-ID: <AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 7, 2010 at 11:36 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> The situation of tidspbridge driver on staging has been pretty sad,
> basically, it has never worked. This is a step backwards from the
> previous situation where it was clear which branch to use to get it
> working. Unfortunately, the ARM and OMAP trees haven't made it easy,
> as changes in those trees have broken it even further.

Here's another try, this one has only one patch that needs omap
maintainers to ack.

 git://gitorious.org/~felipec/linux-omap/felipec.git fc-dsp-fix-v37-rc1-min

These are the changes since v2.6.37-rc1:

Felipe Contreras (14):
      Revert "staging: tidspbridge - update Kconfig to select IOMMU module"
      Revert "staging: tidspbridge - remove dmm custom module"
      Revert "staging: tidspbridge - deprecate
reserve/unreserve_memory funtions"
      Revert "staging: tidspbridge - remove reserved memory clean up"
      Revert "staging: tidspbridge: remove dw_dmmu_base from cfg_hostres struct"
      Revert "staging: tidspbridge - move all iommu related code to a new file"
      Revert "staging: tidspbridge - remove hw directory"
      Revert "staging: tidspbridge - fix mmufault support"
      Revert "staging: tidspbridge - remove custom mmu code from tiomap3430.c"
      Revert "staging: tidspbridge - rename bridge_brd_mem_map/unmap
to a proper name"
      Revert "staging: tidspbridge - move shared memory iommu maps to
tiomap3430.c"
      Revert "staging: tidspbridge: replace iommu custom for
opensource implementation"
      staging: tidspbridge: hack to make it compile on v37-rc1
      omap: dsp: remove shm from normal memory

-- 
Felipe Contreras
