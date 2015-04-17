From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/6] phy: twl4030-usb: add ABI documentation
Date: Sat, 18 Apr 2015 00:14:36 +0200
Message-ID: <20150417221436.GA11429@amd>
References: <20150416075945.23307.24424.stgit@notabene.brown>
 <20150416080304.23307.7824.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150416080304.23307.7824.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu 2015-04-16 18:03:04, NeilBrown wrote:
> From: NeilBrown <neilb@suse.de>
> 
> This driver device one local attribute: vbus.
> Describe that in Documentation/ABI/testing/sysfs-platform/twl4030-usb.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  .../ABI/testing/sysfs-platform-twl4030-usb         |    8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-twl4030-usb
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-twl4030-usb b/Documentation/ABI/testing/sysfs-platform-twl4030-usb
> new file mode 100644
> index 000000000000..512c51be64ae
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-twl4030-usb
> @@ -0,0 +1,8 @@
> +What: /sys/bus/platform/devices/*twl4030-usb/vbus
> +Description:
> +	Read-only status reporting if VBUS (approx 5V)
> +	is being supplied by the USB bus.
> +
> +	Possible values: "on", "off".

Would bit be better to have values "0" and "1"? Kernel usually does
that for booleans...

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
