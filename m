From: "Vutla, Lokesh" <lokeshvutla@ti.com>
Subject: Re: Help needed with remaining plat headers
Date: Fri, 28 Sep 2012 12:28:58 +0530
Message-ID: <CAJ1gdcaU2AcbAJvkFKFGdscZfzMMQRuAmjk6Nf+p-EGhRx4+GQ@mail.gmail.com>
References: <20120920232907.GN28835@atomide.com> <20120927202615.GS4840@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9F522B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:38371 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222Ab2I1G7U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 02:59:20 -0400
Received: by obbuo13 with SMTP id uo13so2617558obb.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 23:59:19 -0700 (PDT)
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9F522B@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>

Hi,
I see a module build failure in linux-next tree.
Any one else facing this issue or I am missing something.
Using master branch on
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
Below is the log .

$ make modules -j 10
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CALL    scripts/checksyscalls.sh
  CC [M]  sound/sound_core.o
  CC [M]  crypto/ecb.o
  CC [M]  crypto/arc4.o
  CC [M]  sound/core/compress_offload.o
  CC [M]  drivers/base/regmap/regmap-spi.o
  CC [M]  sound/core/hwdep.o
  CC [M]  net/bluetooth/af_bluetooth.o
  CC [M]  drivers/bluetooth/hci_ldisc.o
  CC [M]  drivers/bluetooth/hci_h4.o
  CC [M]  net/bluetooth/hci_core.o
  CC [M]  drivers/bluetooth/hci_bcsp.o
  CC [M]  drivers/bluetooth/hci_ll.o
  CC [M]  drivers/bluetooth/bcm203x.o
  CC [M]  sound/core/memalloc.o
  CC [M]  drivers/bluetooth/bpa10x.o
  CC [M]  sound/core/pcm.o
  LD [M]  drivers/bluetooth/hci_uart.o
  CC [M]  net/bluetooth/hci_conn.o
  CC [M]  sound/core/pcm_native.o
  CC [M]  sound/core/pcm_lib.o
  CC [M]  net/bluetooth/hci_event.o
  CC [M]  sound/core/pcm_timer.o
  CC [M]  net/bluetooth/mgmt.o
  CC [M]  sound/core/pcm_misc.o
  CC [M]  sound/core/pcm_memory.o
  CC [M]  net/mac80211/main.o
  CC [M]  drivers/net/wireless/libertas/cfg.o
  CC [M]  net/mac80211/status.o
  CC [M]  sound/core/rawmidi.o
  CC [M]  sound/core/timer.o
  CC [M]  sound/core/sound.o
  CC [M]  sound/core/init.o
  CC [M]  sound/soc/soc-core.o
  CC [M]  sound/core/memory.o
  CC [M]  net/mac80211/sta_info.o
  CC [M]  net/mac80211/wep.o
  CC [M]  net/mac80211/wpa.o
  CC [M]  net/mac80211/scan.o
  CC [M]  net/mac80211/offchannel.o
  CC [M]  net/bluetooth/hci_sock.o
  CC [M]  drivers/net/wireless/libertas/cmd.o
  CC [M]  net/bluetooth/hci_sysfs.o
  CC [M]  sound/core/info.o
  CC [M]  net/mac80211/ht.o
  CC [M]  net/mac80211/agg-tx.o
  CC [M]  sound/core/control.o
  CC [M]  sound/core/misc.o
  CC [M]  sound/core/device.o
  CC [M]  sound/soc/soc-dapm.o
  CC [M]  net/bluetooth/l2cap_core.o
  CC [M]  drivers/net/wireless/libertas/cmdresp.o
  CC [M]  net/bluetooth/l2cap_sock.o
  CC [M]  net/bluetooth/smp.o
  CC [M]  net/bluetooth/sco.o
  CC [M]  sound/soc/soc-jack.o
  CC [M]  net/mac80211/agg-rx.o
  CC [M]  drivers/net/wireless/libertas/debugfs.o
  CC [M]  drivers/net/wireless/libertas/ethtool.o
  CC [M]  drivers/net/wireless/libertas/main.o
  CC [M]  sound/core/sound_oss.o
  CC [M]  sound/core/info_oss.o
  CC [M]  net/bluetooth/lib.o
  CC [M]  net/bluetooth/a2mp.o
  CC [M]  net/mac80211/ibss.o
  CC [M]  drivers/net/wireless/libertas/rx.o
  CC [M]  drivers/net/wireless/libertas/tx.o
  CC [M]  sound/core/jack.o
  CC [M]  drivers/net/wireless/libertas/firmware.o
  CC [M]  sound/soc/soc-cache.o
  CC [M]  sound/core/oss/mixer_oss.o
  CC [M]  drivers/net/wireless/libertas/if_sdio.o
  CC [M]  drivers/net/wireless/libertas/if_usb.o
  CC [M]  sound/soc/soc-utils.o
  CC [M]  net/mac80211/iface.o
  CC [M]  net/wireless/core.o
  CC [M]  net/wireless/sysfs.o
  CC [M]  sound/core/oss/pcm_oss.o
  CC [M]  sound/soc/soc-pcm.o
  CC [M]  sound/usb/card.o
  LD [M]  net/bluetooth/bluetooth.o
  CC [M]  net/wireless/radiotap.o
  CC [M]  sound/core/oss/pcm_plugin.o
  CC [M]  sound/core/oss/io.o
  CC [M]  net/wireless/util.o
  LD [M]  drivers/net/wireless/libertas/libertas.o
  LD [M]  drivers/net/wireless/libertas/usb8xxx.o
  LD [M]  drivers/net/wireless/libertas/libertas_sdio.o
  CC [M]  net/wireless/reg.o
  CC [M]  sound/soc/soc-compress.o
  CC [M]  sound/usb/clock.o
  CC [M]  sound/soc/soc-io.o
  CC [M]  net/mac80211/rate.o
  CC [M]  sound/usb/endpoint.o
  CC [M]  net/wireless/scan.o
  CC [M]  net/wireless/nl80211.o
  CC [M]  sound/core/oss/copy.o
  CC [M]  drivers/usb/gadget/zero.o
  CC [M]  sound/soc/codecs/twl4030.o
  CC [M]  drivers/usb/gadget/usbstring.o
  CC [M]  sound/core/oss/linear.o
  CC [M]  drivers/usb/gadget/config.o
  CC [M]  sound/usb/format.o
  CC [M]  net/mac80211/michael.o
  CC [M]  net/mac80211/tkip.o
  CC [M]  drivers/video/cfbfillrect.o
  CC [M]  sound/core/oss/mulaw.o
  CC [M]  sound/core/oss/route.o
  CC [M]  drivers/usb/gadget/epautoconf.o
  CC [M]  drivers/usb/gadget/composite.o
  CC [M]  drivers/video/cfbcopyarea.o
  CC [M]  sound/usb/helper.o
  LD [M]  sound/soc/codecs/snd-soc-twl4030.o
  CC [M]  sound/usb/mixer.o
  CC [M]  sound/usb/mixer_quirks.o
  CC [M]  sound/core/oss/rate.o
  CC [M]  sound/usb/pcm.o
  CC [M]  sound/soc/omap/omap-mcbsp.o
  CC [M]  sound/soc/omap/mcbsp.o
  LD [M]  sound/core/oss/snd-mixer-oss.o
  LD [M]  sound/core/oss/snd-pcm-oss.o
  LD [M]  sound/core/snd.o
  LD [M]  sound/core/snd-hwdep.o
  LD [M]  sound/core/snd-timer.o
  LD [M]  sound/core/snd-pcm.o
  LD [M]  sound/core/snd-page-alloc.o
  LD [M]  sound/core/snd-rawmidi.o
  LD [M]  sound/core/snd-compress.o
  CC [M]  drivers/video/cfbimgblt.o
  CC [M]  sound/soc/omap/omap-pcm.o
  CC [M]  net/wireless/mlme.o
  CC [M]  net/mac80211/aes_ccm.o
  CC [M]  net/wireless/ibss.o
  CC [M]  sound/usb/proc.o
  CC [M]  sound/usb/quirks.o
  LD [M]  drivers/usb/gadget/libcomposite.o
  CC [M]  sound/soc/omap/omap3pandora.o
  LD [M]  drivers/usb/gadget/g_zero.o
  CC [M]  sound/usb/stream.o
  CC [M]  drivers/video/backlight/backlight.o
  CC [M]  drivers/video/backlight/generic_bl.o
  CC [M]  sound/usb/midi.o
  CC [M]  net/mac80211/aes_cmac.o
  CC [M]  net/mac80211/cfg.o
  LD [M]  sound/soc/omap/snd-soc-omap.o
  LD [M]  sound/soc/omap/snd-soc-omap-mcbsp.o
  LD [M]  sound/soc/omap/snd-soc-omap3pandora.o
  LD [M]  sound/soundcore.o
  CC [M]  net/wireless/sme.o
  CC [M]  net/mac80211/rx.o
  LD [M]  sound/soc/snd-soc-core.o
  CC [M]  net/mac80211/spectmgmt.o
  CC [M]  drivers/video/omap2/displays/panel-generic-dpi.o
  CC [M]  net/wireless/chan.o
  CC [M]  drivers/video/omap2/displays/panel-sharp-ls037v7dw01.o
  CC [M]  net/mac80211/tx.o
  CC [M]  drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.o
  CC [M]  net/wireless/ethtool.o
  CC [M]  net/mac80211/key.o
  CC [M]  net/mac80211/util.o
  CC [M]  drivers/video/omap2/displays/panel-taal.o
  CC [M]  net/mac80211/wme.o
  CC [M]  net/mac80211/event.o
  LD [M]  sound/usb/snd-usb-audio.o
  LD [M]  sound/usb/snd-usbmidi-lib.o
  CC [M]  net/wireless/mesh.o
  CC [M]  net/wireless/ap.o
  CC [M]  drivers/video/omap2/displays/panel-tpo-td043mtea1.o
  CC [M]  net/mac80211/chan.o
  CC [M]  net/mac80211/trace.o
  CC [M]  net/mac80211/mlme.o
  CC [M]  net/wireless/lib80211.o
  CC [M]  drivers/video/omap2/displays/panel-acx565akm.o
  CC [M]  drivers/video/omap2/dss/core.o
  CC [M]  net/mac80211/pm.o
  CC [M]  drivers/video/omap2/dss/dss.o
  CC [M]  net/mac80211/rc80211_pid_algo.o
  CC [M]  net/mac80211/rc80211_minstrel.o
  LD [M]  net/wireless/cfg80211.o
  CC [M]  net/mac80211/rc80211_minstrel_ht.o
  CC [M]  drivers/video/omap2/omapfb/omapfb-main.o
  CC [M]  drivers/video/omap2/dss/dss_features.o
  CC [M]  drivers/video/omap2/dss/dispc.o
  CC [M]  drivers/video/omap2/omapfb/omapfb-sysfs.o
  CC [M]  drivers/video/omap2/omapfb/omapfb-ioctl.o
  CC [M]  drivers/video/omap2/dss/dispc_coefs.o
  CC [M]  drivers/video/omap2/dss/display.o
  CC [M]  drivers/video/omap2/dss/manager.o
  CC [M]  drivers/video/omap2/dss/manager-sysfs.o
  CC [M]  drivers/video/omap2/dss/overlay.o
  CC [M]  drivers/video/omap2/dss/overlay-sysfs.o
  CC [M]  drivers/video/omap2/dss/output.o
  CC [M]  drivers/video/omap2/dss/apply.o
  CC [M]  drivers/video/omap2/dss/dpi.o
  CC [M]  drivers/video/omap2/dss/rfbi.o
  CC [M]  drivers/video/omap2/dss/venc.o
  CC [M]  drivers/video/omap2/dss/venc_panel.o
  CC [M]  drivers/video/omap2/dss/sdi.o
  CC [M]  drivers/video/omap2/dss/dsi.o
  CC [M]  drivers/video/omap2/dss/hdmi.o
  LD [M]  drivers/video/omap2/omapfb/omapfb.o
  CC [M]  drivers/video/omap2/dss/hdmi_panel.o
  CC [M]  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.o
  LD [M]  net/mac80211/mac80211.o
  LD [M]  drivers/video/omap2/dss/omapdss.o
  Building modules, stage 2.
  MODPOST 45 modules
ERROR: "snd_hwparams_to_dma_slave_config"
[sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_pointer" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_close" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_get_chan" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_trigger" [sound/soc/omap/snd-soc-omap.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Thanks
Lokesh


On Fri, Sep 28, 2012 at 10:16 AM, Mohammed, Afzal <afzal@ti.com> wrote:
> Hi Tony,
>
> On Fri, Sep 28, 2012 at 01:56:16, Tony Lindgren wrote:
>
>> Please see below a status update on the remaining problem
>> plat headers.
>
>> > gpmc.h
>>
>> Afzal, can you do a patch for gpmc.h?
>
> Yes, I will do it.
>
> Regards
> Afzal
