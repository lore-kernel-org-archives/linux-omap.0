Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433219;
	b=r0Yh2H5w/tRr2+dmtTPBrcvlvCSH8PhXmKyOtbPyUIldc0PHPnfXPO/Qdd+ORLxXu90T
	 uKGMQDOvq+fGiWlNUtJAukLImF+IUA3ASBWcRoLzci1FGsb3WRmigioiGftSmtI2RfUeD
	 gOuPNNxK+x1XsG0DYtzX297W6Uotvj+yANeiveFFjHyl/1Uk/kPXNIKqyHU9b7994mSLn
	 8SY9GrQRhvRl6ceMWt5us6dAQv3pVHDs6byWzHYY9zxjCfY4ByxU1mnJcN7+eOxWnOIW1
	 qfwPDBc6SfA5HWPH5Y4W98PUNp5+a0jiPdkGrgUrpC3SrFMHlfuHz4smGTb86vMfoTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433219;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Pk1d4FIc1e+8jPoKAjk96xMQdhYfXOh9uAYt7f04oRE=;
	b=dWIaGJ4EIFLKqbkrN3ropSDMZltRZZedZQCbx7gNMAdHflczsn1/HpchTV5XKl0ZLQ8g
	 6jNXD1sHLFXism3jpnfAXcn/sQ5cqEfE+vTuyTmjY4v7N75VvsprSQQ1jKA3LdTBCbR98
	 kqjacOIrQqotYSxG0xjHb4G6Ko5oMBWxFH+H7opGmQiOldiwXwueMXr3mQ6L/WulHUiXv
	 WF4bDoQQ7dTc6pqPslTXElvzjhopvjdmJmI7U6aKoA6pspwJG3G3B+wMPBuXQVpoTryBH
	 TRYDr7BIgI/GfsC+/uWAKyqptmuMxF3KUIeKuqATAKiicGvz5cyy7/9UV4dAxSXRaig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b="zFcd0/Cb";
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372A606A324
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2026 21:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9372A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=zFcd0/Cb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Pk1d4FIc1e+8jPoKAjk96xMQdhYfXOh9uAYt7f04oRE=; t=1794433219; x=1795642819; 
	b=zFcd0/CbwR4BFzJvMCRGwIvXsFxZXXypeQEFwwHI6jULi/XQ/ZvP9wtew34OSsyBreEXyJOaeuA
	LrhLqbgVup+HTrV5Lc6L4fLSeHqAGPyAdINenz/jBUGanWT8+AAE9FeMv+LqqnpyD27zGCSYBbAsL
	oyU8cc6oKBF0USDRR9b0qSWY8uLH9YblpILYlW3gbRueUfYzhaXPg612pxJQzjUkYWkhM9rCArBpM
	M/salqRBZxb8rpKqTHqPAsYcurU0fu/nnOzTh9wvf0uMQMkDq+atbaWE++lkrMU0faj/szpiHjo0C
	N64+xwjNpTzT8N9XLKV4eATrBmqIqvdeUOsw==;
Date: Wed, 11 Nov 2026 22:40:15 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, Tomi
 Valkeinen <tomi.valkeinen@ideasonboard.com>, bparrot@ti.com
Subject: [BUG] WARN() after second suspend on omapdrm
Message-ID: <20261111224015.2003c9ba@kemnade.info>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

This is an older bug, no idea what strange side effects it might have:

[ 1841.775390] PM: suspend entry (deep)
[ 1841.775726] Filesystems sync: 0.000 seconds
[ 1841.776824] Freezing user space processes
[ 1841.778594] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[ 1841.778625] OOM killer disabled.
[ 1841.778625] Freezing remaining freezable tasks
[ 1841.806243] Freezing remaining freezable tasks completed (elapsed 0.027 =
seconds)
[ 1841.806274] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[ 1841.833557] ------------[ cut here ]------------
[ 1841.833587] WARNING: drivers/gpu/drm/omapdrm/omap_overlay.c:123 at omap_=
plane_atomic_check+0x1ec/0x438 [omapdrm], CPU#0: rtcwake/813
[ 1841.833740] Modules linked in: omapdrm wl18xx wlcore mac80211 libarc4 us=
b_f_mass_storage panel_tpo_td028ttec1 usb_f_ncm u_ether libcomposite cfg802=
11 joydev mousedev evdev snd_soc_simple_card spi_gpio spi_bitbang snd_soc_s=
imple_card_utils snd_soc_omap_twl4030 pwm_omap_dmtimer simple_bridge phy_ge=
neric display_connector cpufreq_dt pwm_bl gpio_keys omap_wdt bmg160_spi bmp=
280_spi bq27xxx_battery_hdq bq27xxx_battery omap_sham wlcore_sdio omap_rng =
omap_aes_driver crypto_engine rng_core omap_crypto ledtrig_default_on omap2=
430 phy_twl4030_usb musb_hdrc omap_hdq wire cn hwmon bmp280_i2c udc_core bm=
g160_i2c bmg160_core bmp280 usbcore twl4030_wdt bno055_i2c leds_tca6507 wat=
chdog at24 tsc2007 usb_common bno055 rtc_twl led_class hci_uart btbcm snd_s=
oc_twl4030 snd_soc_omap_mcbsp snd_soc_ti_sdma twl4030_pwrbutton bluetooth s=
nd_soc_core twl4030_madc pwm_twl_led pwm_twl snd_pcm_dmaengine twl4030_char=
ger snd_pcm bmc150_accel_i2c bmc150_accel_core bmc150_magn_i2c bmc150_magn =
industrialio_triggered_buffer kfifo_buf snd_timer
[ 1841.834350]  industrialio ecdh_generic ecc crc_ccitt snd soundcore omap_=
mailbox rfkill drm_client_lib drm_display_helper cec drm_panel drm_kms_help=
er drm omap_ssi hsi drm_panel_orientation_quirks [last unloaded: omapdrm]
[ 1841.834503] CPU: 0 UID: 0 PID: 813 Comm: rtcwake Not tainted 7.4.0-rc2-0=
0005-g105c1f8efb05 #213 VOLUNTARY=20
[ 1841.834533] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[ 1841.834533] Call trace:=20
[ 1841.834564]  unwind_backtrace from show_stack+0x28/0x2c
[ 1841.834594]  show_stack from dump_stack_lvl+0x34/0x70
[ 1841.834655]  dump_stack_lvl from __warn+0xf0/0x1fc
[ 1841.834686]  __warn from warn_slowpath_fmt+0x124/0x17c
[ 1841.834716]  warn_slowpath_fmt from omap_plane_atomic_check+0x1ec/0x438 =
[omapdrm]
[ 1841.834838]  omap_plane_atomic_check [omapdrm] from drm_atomic_helper_ch=
eck_planes+0x104/0x230 [drm_kms_helper]
[ 1841.834991]  drm_atomic_helper_check_planes [drm_kms_helper] from drm_at=
omic_helper_check+0x58/0xa0 [drm_kms_helper]
[ 1841.835052]  drm_atomic_helper_check [drm_kms_helper] from omap_atomic_c=
heck+0x28/0x20c [omapdrm]
[ 1841.835144]  omap_atomic_check [omapdrm] from drm_atomic_check_only+0x5d=
0/0x9fc [drm]
[ 1841.835449]  drm_atomic_check_only [drm] from drm_atomic_commit+0x78/0xe=
4 [drm]
[ 1841.835693]  drm_atomic_commit [drm] from drm_atomic_helper_disable_all+=
0x170/0x1cc [drm_kms_helper]
[ 1841.835845]  drm_atomic_helper_disable_all [drm_kms_helper] from drm_ato=
mic_helper_suspend+0xb8/0x1b4 [drm_kms_helper]
[ 1841.835937]  drm_atomic_helper_suspend [drm_kms_helper] from drm_mode_co=
nfig_helper_suspend+0x44/0x80 [drm_kms_helper]
[ 1841.835998]  drm_mode_config_helper_suspend [drm_kms_helper] from dpm_ru=
n_callback+0x5c/0x1fc
[ 1841.836059]  dpm_run_callback from device_suspend+0x2cc/0x728
[ 1841.836090]  device_suspend from dpm_suspend+0x1d8/0x34c
[ 1841.836120]  dpm_suspend from dpm_suspend_start+0x50/0x80
[ 1841.836151]  dpm_suspend_start from suspend_devices_and_enter+0x70/0x894
[ 1841.836181]  suspend_devices_and_enter from pm_suspend+0x264/0x3f4

The system is the GTA04 with DPI panel attached.

How to reproduce: boot to console, suspend twice.

The waring is from omap_overlay_release()
        if (WARN_ON(!overlay_map[overlay->idx]))

Observations: omap_overlay_assign() only get called initially.
omap_overlay_release() gets called on first suspend without
errors. No omap_overlay_assign() call after that.=20

Then on second suspend, the WARN() comes. After resume the display
comes up back again. But that all feels not healthy.

Verdict:

omap_plane_atomic_check() releases overlay and zeros the pointer when suspn=
ed
going from visible -> invisible. On resume when going from invisible -> vis=
ible somehow
an old state pops up with that old overlay pointer.

commit
2e54ff0e54308 ("drm/omap: dynamically assign hw overlays to planes")
is probably involved.

Regards,
Andreas
