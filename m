From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/14] Add support for FM radio in hcill and kill TI_ST
Date: Sun, 23 Dec 2018 08:22:28 -0800
Message-ID: <20181223162228.GN6707@atomide.com>
References: <20181221011752.25627-1-sre@kernel.org>
 <20181221180205.GH6707@atomide.com>
 <CAHCN7xK-qnRp_s9MQ2-doGqPrfC_OOgciOKHYTC9L5eiTwzT9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xK-qnRp_s9MQ2-doGqPrfC_OOgciOKHYTC9L5eiTwzT9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [181222 20:36]:
> As much as I'd like to see the ti-st kim stuff go, I am not able to
> load the Bluetooth on the Torpedo board (wl1283).  The hooks on a
> different, wl18xx and 127x board work fine.  I am not sure if there is
> anything different about the wl1283, but I don't have any other boards
> other than the Logic PD Torpedo kit.  Do you have any wl1283 boards to
> test?  I'd like to see this BT timeout stuff resolved before we dump
> the ti-st kim stuff, otherwise, I'll forever be porting drivers.  :-(

Sebastian and I both tested this with droid 4, which has wl1283. So
it's probably some missing GPIO/regulator/pinconf stuff that the
pdata-quirks.c does for you.

Maybe try adding back also the pdata-quirks.c code and see if that
helps?

Regards,

Tony
