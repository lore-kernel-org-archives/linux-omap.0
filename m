From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH] ARM: omap2plus_defconfig: Fix selected
 panels after generic panel changes
Date: Mon, 7 Oct 2019 18:09:57 +0200
Message-ID: <20191007180957.69cf7b55@aktux>
References: <20191003165539.50318-1-tony@atomide.com>
 <03ca02c1-2816-17cd-03fd-5b72e5d0ec96@ti.com>
 <39E48EC6-65FE-419B-BBE8-E72CB44B517D@goldelico.com>
 <20191006145348.GD4740@pendragon.ideasonboard.com>
 <20191006223958.67725fdf@aktux> <20191007064035.72016c78@aktux>
 <654d00a7-d802-d116-84c4-7c614d0fe272@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <654d00a7-d802-d116-84c4-7c614d0fe272@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>, Jyri Sarha <jsarha@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 7 Oct 2019 17:29:20 +0300
Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> On 07/10/2019 07:40, Andreas Kemnade wrote:
> 
> >>> That's really weird, the driver name, the SPI device table and the OF
> >>> device table are the same (except for the "omapdss," prefix that we
> >>> don't add anymore in omapdss-boot-init.c). Would you be able to
> >>> investigate what broke ?
> >>>      
> >> in earlier times:
> >>
> >> root@gta04:/sys/bus/spi/devices/spi4.0# cat modalias
> >> spi:tpo,td028ttec1
> >>
> >> now in 5.4-rc1:
> >> root@gta04:/sys/bus/spi/devices/spi4.0# cat modalias
> >> spi:td028ttec1
> >>
> >> root@gta04:~# modinfo /lib/modules/5.4.0-rc1-letux+/kernel/drivers/gpu/drm/panel/panel-tpo-td028ttec1.ko
> >> filename:       /lib/modules/5.4.0-rc1-letux+/kernel/drivers/gpu/drm/panel/panel-tpo-td028ttec1.ko
> >> license:        GPL
> >> description:    Toppoly TD028TTEC1 panel driver
> >> author:         H. Nikolaus Schaller <hns@goldelico.com>
> >> srcversion:     6B3E224BCD3D76253CF361C
> >> alias:          of:N*T*Ctoppoly,td028ttec1C*
> >> alias:          of:N*T*Ctoppoly,td028ttec1
> >> alias:          of:N*T*Ctpo,td028ttec1C*
> >> alias:          of:N*T*Ctpo,td028ttec1
> >> alias:          spi:toppoly,td028ttec1
> >> alias:          spi:tpo,td028ttec1
> >> depends:        drm
> >> intree:         Y
> >> name:           panel_tpo_td028ttec1
> >> vermagic:       5.4.0-rc1-letux+ SMP preempt mod_unload ARMv7 p2v8
> >>
> >> That alias is not in the list.
> >>  
> > some more research:
> > in former times
> > of_modalias_node() has stripped the omapdss prefix, result: modalias=spi:tpo,td028ttec1
> > now it strips the tpo prefix because there is no omapdss prefix anymore.  
> 
> I haven't studied this more yet, but yes, I can see of_modalias_node 
> stripping the vendor prefix on purpose. I do wonder how this is supposed 
> to work, it would make more sense to me to keep the vendor prefix.
> 
> Is the spi_device_id supposed to be without vendor prefix? With a quick 
> grep, this seems to be the case.
> 
as it is done in drivers/spi/spi.c we have no influence from drm side.
So we must live with it. Also checked several drivers, no vendor-prefix
there.

Regards,
Andreas
