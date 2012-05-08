From: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4 00/39] OMAP GPMC driver conversion
Date: Tue, 8 May 2012 11:27:58 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E987D39@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1335874494.git.afzal-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org" <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <lin>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tue, May 01, 2012 at 17:49:03, Mohammed, Afzal wrote:
> GPMC driver conversion patch series. Some peripherals has GPMC helper
> functions, these has been modified to cater to the needs of GPMC
> driver. All the boards using GPMC has been adapted to use the new
> GPMC driver.
> 
> GPMC HWMOD entry for OMAP2/3 has been added. On OMAP3, kernel does
> spit "omap_hwmod: gpmc: cannot be enabled for reset (3)", but
> peripherals connected via GPMC are working. Really shaky about OMAP2
> GPMC HWMOD entry. Would be helpful if someone can help me in resolving
> warning on OMAP3 & verify whether OMAP2 entry is proper. The series
> adapts to HWMOD.
> 
> Drivers, NAND & OneNAND of OMAP has been modified to make use of GPMC
> changes & cleaned up the now unnecessary exported symbol usages.
> 
> This series has been made on top of,
> 5e136da Linux-omap rebuilt: Updated to -rc5,
> A patch by Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>,
> OMAP3: igep0020: Add support for Micron NAND Flash storage memory,
> has also been incorporated into the series as this was necessary for
> igep0020 board.
> 
> This has been tested on omap3 evm (SMSC911x) & beagle board (NAND)


Please let me know your comments on this series.

Regards
Afzal
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
