From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: multiple board files (was Re: [PATCH] OMAP: 2430SDP: Support
	LCDdisplay as a FB device)
Date: Fri, 25 May 2007 18:51:56 -0500
Message-ID: <782515bb0705251651t12797b07yd23c40fb8568b7d7@mail.gmail.com>
References: <782515bb0705251601h7fe84dcbod53d74d46bdef28a@mail.gmail.com>
	<9C23CDD79DA20A479D4615857B2E2C47FF0C4C@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF0C4C@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Khasim,
On 5/25/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> We might not need a board file for every device, but it is necessary for few like MMC. It has lot of board specific data that if merged into a single file will cause lot of confusion.
mmc is in "arch/arm/plat-omap/devices.c" for precisely that reason..
common devices - common place.. it somehow does not make sense for
2430 though..
More stats: c_count stats might make sense in this context(though may
not be very accurate):
physical_src_lines logical_src_lines | filename
   408    79   |board-2430sdp.c
   110    16   |board-2430sdp-flash.c
    69     6   |board-2430sdp-usb.c

   550   122   |board-h4.c

   342    84   |board-apollon.c
    79    15   |board-apollon-keys.c

   366   131   |board-n800-audio.c
    42     5   |board-n800-bt.c
   515   132   |board-n800.c
   156    45   |board-n800-dsp.c
   156    59   |board-n800-flash.c
   282    94   |board-n800-mmc.c
    79    20   |board-n800-pm.c
   130    36   |board-n800-usb.c
>From the looks of it, for 2430 and apollon, I'd say we merge each sets
of board files.. but mebbe I am missing the point altogether here.. We
need to see why we want to split the files.. too much data together?
If so, are there common things we can pull out specific to mach-omap2
and put them in say, devices.c?

Regards,
Nishanth Menon
