From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/20] ARM: DTS: am335x/am43xx: Audio support and
 fixes for audio
Date: Tue, 14 Jul 2015 04:29:33 -0700
Message-ID: <20150714112933.GU17550@atomide.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150702 07:08]:
> Hi,
> 
> Changes since v1:
> - Add patch for omap2plus_defconfig to enable needed audio drivers
> - Included other board patches since they all need the change in
>   omap2plus_defconfig
> 
> Enable the simple card in omap2plus_defconfig as more boards are using that for
> audio support.
> 
> am437x-sk-evm, am335x-evmsk and am335x-evm:
> There is no reason to use the davinci-evm machine driver's compatible for audio
> support since the setup is simple and the common simple-audio-card can handle it
> just fine.
> 
> am43xx-epos-evm, am437x-gp-evm:
> Add audio support via simple-card

Applying all into omap-for-v4.3/dt thanks.

Tony
