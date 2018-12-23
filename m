From: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Sun, 23 Dec 2018 07:51:47 -0800
Message-ID: <20181223155147.GI6707@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181223103315.GA1936@amd>
 <20181223111059.GB1936@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181223111059.GB1936@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [181223 11:11]:
> I added some printks to motmdm_probe, and they don't appear to be
> called. I wonder if I'm missing something else in the config? I do
> have serial
> 
> root@devuan:/my/ko# ls -al /dev/ttyS0
> crw-rw---- 1 root dialout 4, 64 Dec 23 11:52 /dev/ttyS0
> 
> but not gsm multiplex:
> 
> root@devuan:/my/ko# ls -al /dev/gsm*
> ls: cannot access '/dev/gsm*': No such file or directory

Hmm with serdev you should not get /dev/ttyS0, so maybe you're missing:

CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y

Probably the Kconfig dependency should be for SERIAL_DEV_CTRL_TTYPORT
instead of SERIAL_DEV_BUS in these patches if that helps.

Or else you're missing the serdev related dts changes?

Regards,

Tony
