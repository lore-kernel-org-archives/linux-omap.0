From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4 0/3] mtd: nand: OMAP: ELM error correction support
 for BCH ecc
Date: Wed, 16 Jan 2013 12:22:01 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA5DFA9@DBDE01.ent.ti.com>
References: <1357286211-5012-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1357286211-5012-1-git-send-email-avinashphilip-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hebbar,
 Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org" <ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Artem,

On Fri, Jan 04, 2013 at 13:26:48, Philip, Avinash wrote:
> Support to use ELM as BCH 4 & 8 bit error correction module. Also performance
> enhancement by adding single shot read_page and write_page functions for the
> nand flashes with page size less than 4 KB.
> 
> ELM module can be used to correct errors reported by BCH 4, 8 & 16 bit
> ECC scheme. For now only 4 & 8 bit support is added.
> 
> BCH 4 & 8 bit error detection support is already available in mainline
> kernel and works with software error correction.
> 
> This series is based on linux 3.8-rc2 and tested with [1].
> Also this patch series depend on [1] for NAND flash device
> tree data and gpmc nand device tree binding documentation updates.
> 
> 1. [PATCH v7 0/5] OMAP GPMC DT bindings
> http://www.spinics.net/lists/linux-omap/msg83505.html
> 
> Tested on am335x-evm for BCH 4 and 8 bit error correction.

Can you apply this patch series on l2-mtd tree as it will help RBL compatibility
ecc layout for NAND flash in am335x-platforms and hardware based BCH error
correction.

Thanks
Avinash

> 
> Changes since v1:
> 	- Erased page is identified by checking byte [13/7] in read
> 	  ecc. To filter out bit flips in OOB area, check 0 bits in
> 	  the byte greater than 4.
> 	- GPMC ecc engine configuration moves to omap2.c NAND driver.
> 
> Changes since v2:
> 	- Added runtime detection of elm module, instead of depending
> 	  on platform data.
> 	- Added bit flip correction in OOB ecc data if bit flip happen
> 	  OOB data.
> 
> Changes since v3:
> 	- Availability and usability of ELM module is detected from device
> 	  tree nodes by checking availability of ELM node in device tree.
> 
> Philip Avinash (3):
>   mtd: nand: omap2: Update nerrors using ecc.strength
>   mtd: devices: elm: Add support for ELM error correction
>   mtd: nand: omap2: Support for hardware BCH error correction.
> 
>  Documentation/devicetree/bindings/mtd/elm.txt      |   16 +
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |    4 +
>  drivers/mtd/devices/Makefile                       |    4 +-
>  drivers/mtd/devices/elm.c                          |  405 ++++++++++++++
>  drivers/mtd/nand/omap2.c                           |  583 ++++++++++++++++++--
>  include/linux/platform_data/elm.h                  |   54 ++
>  6 files changed, 1023 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/elm.txt
>  create mode 100644 drivers/mtd/devices/elm.c
>  create mode 100644 include/linux/platform_data/elm.h
> 
> -- 
> 1.7.9.5
> 
> 
