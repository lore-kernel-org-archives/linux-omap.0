From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH][RFC] update flash timing on OMAP5912OSK
Date: Mon, 20 Feb 2006 15:04:50 -0800
Message-ID: <20060220230450.GH30248@atomide.com>
References: <20060220.132145.74756047.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060220.132145.74756047.kaminaga@sm.sony.co.jp>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hiroki Kaminaga <kaminaga@sm.sony.co.jp> [060219 20:29]:
> Hi,
> 
> In linux-2.6.15-omap1 patch, in arch/arm/mach-omap1/board-osk.c,
> EMIFS_CS3_VAL is set to 0x30003361.
> 
> This was introduced to fix flash timing error.
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-July/004717.html
> 
> On the other hand, in SectionE:Errata in EMIFS timing at:
> http://omap.spectrumdigital.com/osk5912/osk5912_faq.html
> EMIFS_CS3_VAL was set to 0x88013141, fixing write/read rate.
> 
> Reading from
> http://focus.ti.com/lit/ug/spru742/spru742.pdf
> 3.6 EMIFS Registers,
> 
> 0x30003361 will set read mode from "page mode, 4 word/page" to 
> "asynchronous read", and read from flash slowed down.
> 
> I tested with new value 0x88013141, and works good so far.
> 
> Here is a patch against 2.6.15-omap1 patch.

Thanks, pushing today.

Tony
