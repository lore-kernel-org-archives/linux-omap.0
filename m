From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v12 2/4] PM / Domains: add setter for dev.pm_domain
Date: Mon, 8 Feb 2016 22:50:39 +0100
Message-ID: <CAJZ5v0jUipo06fpSQsKi+5Po_32ntgc3Ns29=17SgQr2PSj+kA@mail.gmail.com>
References: <1452181575-9206-1-git-send-email-tomeu.vizoso@collabora.com>
	<CAHp75VdWPUZ8F5rsGn3M1e5Pgpcg1CErBej9PE_3+ZPke5CDFA@mail.gmail.com>
	<CAHp75Vf9TS-AxJALQjiwNjMCT8ct5SBanYzrEsV9aj=DsUw-OA@mail.gmail.com>
	<1783906.XctYjeUNLr@vostro.rjw.lan>
	<44858.1454967873@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <44858.1454967873@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Kurtz <djkurtz@chromium.org>, David Airlie <airlied@linux.ie>, Tomas Winkler <tomas.winkler@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-arm Mailing List <linux-arm-kernel@lists.infr>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 8, 2016 at 10:44 PM,  <Valdis.Kletnieks@vt.edu> wrote:
> On Fri, 29 Jan 2016 22:35:18 +0100, "Rafael J. Wysocki" said:
>> > One more test unveils this one
>> >
>> > # modprobe -r sdhci-acpi
>> > [ 1289.909441] ------------[ cut here ]------------
>> > [ 1289.918205] WARNING: CPU: 1 PID: 4374 at
>> > /home/andy/prj/linux-otc/drivers/base/power/common.c:150
>> > dev_pm_domain_set+0x51/0x60()
>> > [ 1289.934681] PM domains can only be changed for unbound devices
>> > [ 1289.944843] Modules linked in: sdhci_acpi(-) sdhci mmc_core
>> > led_class [last unloaded: dw_dmac_core]
>> > [ 1289.958802] CPU: 1 PID: 4374 Comm: modprobe Not tainted 4.5.0-rc1+ #3
>> > [ 1289.969736]  ffffffff81c38330 ffff88007bb53d18 ffffffff8133162f
>> > ffff88007bb53d60
>> > [ 1289.981844]  ffff88007bb53d50 ffffffff8105cd12 ffff88017a007410
>> > 0000000000000000
>> > [ 1289.993996]  0000000000000001 0000000000000080 0000000000000000
>> > ffff88007bb53db0
>> > [ 1290.006123] Call Trace:
>> > [ 1290.012600]  [<ffffffff8133162f>] dump_stack+0x44/0x55
>> > [ 1290.022052]  [<ffffffff8105cd12>] warn_slowpath_common+0x82/0xc0
>> > [ 1290.032462]  [<ffffffff8105cd9c>] warn_slowpath_fmt+0x4c/0x50
>> > [ 1290.042589]  [<ffffffff814867c1>] dev_pm_domain_set+0x51/0x60
>
> My Dell Latitude laptopi on next-20160201 is throwing a similar error
> at shutdown, except the traceback continues:
>
> mei_me_remove+0xbd/0xc0
> pci_device_shutdown+0x32/0x50
> device_shutdown+0xe2/0x210
>
> (sorry, that's all I have, transcribing from one frame of video shot while
> the system was shutting down....)

This should be fixed in 4.5-rc3, so please retest.

Thanks,
Rafael
