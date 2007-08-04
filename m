From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Subject: [PATCH 3/3] [ARM] OMAP: Adding Support for 2K nand	page
 support on omap2430
Date: Sat, 04 Aug 2007 08:39:47 -0500
Message-ID: <46B481A3.8090204@gmail.com>
References: <809D758398CC1F49AA8E493528AD4A27014DF6AF@ntxsjombx02.micron.com>	<8bf247760707310753h7ca6cb78u3af809454d159a59@mail.gmail.com>	<809D758398CC1F49AA8E493528AD4A27014DF6B8@ntxsjombx02.micron.com>
	<8bf247760708031016m3bf55e45pe2161a51c65e1c46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <8bf247760708031016m3bf55e45pe2161a51c65e1c46@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ram <vshrirama@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Ram,
Ram stated on 8/3/2007 12:16 PM:
>   My nand chip is a 128 MB chip. hence the base address i have taken
> is 0x10000000
>   which is 128MB boundary.
>   hence my chip address and mask will become 0x850.(0x6e000078)
it is a nand chip rt? Nands are I/O dev accessed using
GPMC_ADDR,CMD,DATA regs. So gpmc config wise, it does not matter where u
put it.. and u dont need to allocate 128M/put it on 128M boundary.
boundary restrictions are more valid for NOR-like devices.
Regards,
Nishanth Menon
