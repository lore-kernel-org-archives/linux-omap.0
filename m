From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: CSST 3430 V2.0 released
Date: Thu, 27 Sep 2007 08:25:02 -0500
Message-ID: <782515bb0709270625s6ace4be5ve24186cbddc09a07@mail.gmail.com>
References: <46FB9CFD.5090107@gmail.com>
	<9C23CDD79DA20A479D4615857B2E2C47019756EF@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47019756EF@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP List <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Khasim,
On 9/27/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> Thanks for the update, if possible can you please give us the instructions
> to download u-boot / x-loader on 3430 SDP using this CSST.
On u-boot:
The instructions in the document in still the same and valid for 3430
also. quick start guide in CSST has details on how this is done.
On X-loader:
CSST now comes with a custom x-loader for nand type devices which will
load 0x40000 sized image from nand offset 0x20000 to sdram and give
control to it. you could "in theory" put CSST's xloader in 0x0,
uboot.bin in 0x20000 and expect it to boot (Note: I have not tried
this yet). image formating information is available in quick start
guide with screenshots :)..

Regards,
Nishanth Menon
