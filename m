From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 0/5] omap: add ocp2scp as a misc driver
Date: Fri, 1 Jun 2012 03:58:00 -0700
Message-ID: <20120601105759.GJ12766@atomide.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com>
 <201205301843.51568.arnd@arndb.de>
 <CAAe_U6LFFstds=iQ7cy7gM9vWbfRgf5z0gaRp_-bu0Qjx6eA1Q@mail.gmail.com>
 <201205310922.18550.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201205310922.18550.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, paul@pwsan.com, linux@arm.linux.org.uk, b-cousson@ti.com, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [120531 02:26]:
> On Thursday 31 May 2012, ABRAHAM, KISHON VIJAY wrote:
> > >
> > > Just put the devices you actually want into the device tree instead and
> > > have them automatically created.
> > 
> > But shouldn't device tree support and non-device tree support co-exist
> > till the non-device tree is completely knocked out of the kernel? Even
> 
> Well, it's a new driver, so there is no regression in supporting it only
> on DT-enabled boards. OMAP5 is DT-only anyway and OMAP4 only supports two
> boards that should both be working with the generic DT code already.

I agree, let's keep the new omap4/5 drivers DT only.

Regards,

Tony
