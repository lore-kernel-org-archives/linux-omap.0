From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if
 booted with latest u-boot
Date: Thu, 13 Dec 2018 07:17:03 -0800
Message-ID: <20181213151703.GN6707@atomide.com>
References: <20181213135845.3965-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181213135845.3965-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux@armlinux.org.uk, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181213 13:57]:
> After some debugging I have managed to get the ethernet working with
> mainline u-boot while not breaking the networking with the case when we
> boot with the mysterious binary u-boot.

I'm pretty sure this is the most recent version of
WIP u-boot SPI support from Nishanth:

https://github.com/nmenon/u-boot/tree/v2014.04-mod/sdp4430-ethernet

>From what I recall, that did not work for Blaze though
for enabling Ethernet for tftp booting but worked on
4430-sdp. Maybe because of the same issues as these
kernel patches though.

Regards,

Tony
