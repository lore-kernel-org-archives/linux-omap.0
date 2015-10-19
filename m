From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: dts: Add basic support for isee igepv5
Date: Mon, 19 Oct 2015 07:50:52 -0700
Message-ID: <20151019145052.GB21839@atomide.com>
References: <1444756728-11185-1-git-send-email-tony@atomide.com>
 <1444756728-11185-3-git-send-email-tony@atomide.com>
 <CAFqH_52T8rPJp-8+Bb7Tjv-kcACU8FJGtqFWOhj02DzQ2yc7nw@mail.gmail.com>
 <20151016145707.GU10113@atomide.com>
 <CAMVEqEkoXoE1wgT8p5BNW7TAjz5Xtcvx7gXvk7rbdQXg8bXpzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMVEqEkoXoE1wgT8p5BNW7TAjz5Xtcvx7gXvk7rbdQXg8bXpzg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pau Pajuel <ppajuel@gmail.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, Enric Balletbo Serra <eballetbo@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, =?utf-8?Q?Agust=C3=AD?= Fontquerni i Gorchs <afontquerni@iseebcn.com>, egavin@iseebcn.com, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Pau Pajuel <ppajuel@gmail.com> [151019 06:40]:
> Hi Tony,
> 2015-10-16 16:57 GMT+02:00 Tony Lindgren <tony@atomide.com>:
> > >
> > > So far I've tested that basic things work, such as serial, USB
> > > Ethernet, HDMI and WLAN.

Also mSATA works too BTW.

> I am testing your patch without succes. Which u-boot version are you using?

I'm using the isee git tree u-boot with the following enabled in the
omap5_igep0050.h:

#define IGEPv5_MEMORY_4G
#define CONFIG_SUPPORT_RAW_INITRD
#define CONFIG_ENV_IS_IN_FAT
#define FAT_ENV_INTERFACE		"mmc"
#define FAT_ENV_DEVICE			1
#define FAT_ENV_PART			1
#define FAT_ENV_FILE			"uboot.env"
#define CONFIG_FAT_WRITE

The CONFIG_SUPPORT_RAW_INITRD is needed to support raw initramfs instead of
using mkimage on it for bootz command. I don't think these changes should
affect booting though.

> Do you apply config changes into omap2plus_defconfig

Looks like I only enabled CONFIG_USB_NET_SMSC75XX.

> Here is my setup and log: http://pastebin.com/j51ugRvK

My guess is that you need to play with initrd_high etc, try doing something
like this in u-boot:

setenv fdtaddr 80a00000
setenv loadaddr 80c00000
setenv rdaddr 81400000
setenv fdt_high 8c000000
setenv initrd_high ffffffff

And see if that helps?

BTW, we really need to use initramfs based booting on these for NFS to
avoid having to compile all the USB into the kernel. Well at least for
the mainline omap2plus_defconfig.

Regards,

Tony
