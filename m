From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH v12 2/4] PM / Domains: add setter for dev.pm_domain
Date: Mon, 08 Feb 2016 16:44:33 -0500
Message-ID: <44858.1454967873@turing-police.cc.vt.edu>
References: <1452181575-9206-1-git-send-email-tomeu.vizoso@collabora.com> <CAHp75VdWPUZ8F5rsGn3M1e5Pgpcg1CErBej9PE_3+ZPke5CDFA@mail.gmail.com> <CAHp75Vf9TS-AxJALQjiwNjMCT8ct5SBanYzrEsV9aj=DsUw-OA@mail.gmail.com>
 <1783906.XctYjeUNLr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1783906.XctYjeUNLr@vostro.rjw.lan>
Content-ID: <46387.1454964079.1@turing-police.cc.vt.edu>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Kurtz <djkurtz@chromium.org>, David Airlie <airlied@linux.ie>, Tomas Winkler <tomas.winkler@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 29 Jan 2016 22:35:18 +0100, "Rafael J. Wysocki" said:
> > One more test unveils this one
> > 
> > # modprobe -r sdhci-acpi
> > [ 1289.909441] ------------[ cut here ]------------
> > [ 1289.918205] WARNING: CPU: 1 PID: 4374 at
> > /home/andy/prj/linux-otc/drivers/base/power/common.c:150
> > dev_pm_domain_set+0x51/0x60()
> > [ 1289.934681] PM domains can only be changed for unbound devices
> > [ 1289.944843] Modules linked in: sdhci_acpi(-) sdhci mmc_core
> > led_class [last unloaded: dw_dmac_core]
> > [ 1289.958802] CPU: 1 PID: 4374 Comm: modprobe Not tainted 4.5.0-rc1+ #3
> > [ 1289.969736]  ffffffff81c38330 ffff88007bb53d18 ffffffff8133162f
> > ffff88007bb53d60
> > [ 1289.981844]  ffff88007bb53d50 ffffffff8105cd12 ffff88017a007410
> > 0000000000000000
> > [ 1289.993996]  0000000000000001 0000000000000080 0000000000000000
> > ffff88007bb53db0
> > [ 1290.006123] Call Trace:
> > [ 1290.012600]  [<ffffffff8133162f>] dump_stack+0x44/0x55
> > [ 1290.022052]  [<ffffffff8105cd12>] warn_slowpath_common+0x82/0xc0
> > [ 1290.032462]  [<ffffffff8105cd9c>] warn_slowpath_fmt+0x4c/0x50
> > [ 1290.042589]  [<ffffffff814867c1>] dev_pm_domain_set+0x51/0x60

My Dell Latitude laptopi on next-20160201 is throwing a similar error
at shutdown, except the traceback continues:

mei_me_remove+0xbd/0xc0
pci_device_shutdown+0x32/0x50
device_shutdown+0xe2/0x210

(sorry, that's all I have, transcribing from one frame of video shot while
the system was shutting down....)

