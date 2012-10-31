From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Wed, 31 Oct 2012 10:52:19 -0700
Message-ID: <20121031175219.GH12739@atomide.com>
References: <1351783082-11411-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351783082-11411-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pantelis Antoniou <panto@antoniou-consulting.com> [121031 10:26]:
> It is painless to move the adapter DT devices to arch/arm/mach-omap2
> 
> However I got bit by the __init at omap_build_device family functions.
> If you don't remove it, crashes every time you instantiate a device
> at runtime, or you load the cape driver as a module.

Hmm I think you misunderstood me. You only need to create the
platform_device under arch/arm/mach-omap2. The device creation
happens only at __init, so omap_build_device can stay as __init.
The driver itself should be under drivers.

But is this bus on non-device-tree omaps? If not, just make it
device tree only.

Regards,

Tony
