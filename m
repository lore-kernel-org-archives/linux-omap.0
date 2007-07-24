From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Trouble downloading bootloader using CSST onto 2430SDP
Date: Mon, 23 Jul 2007 22:04:41 -0500
Message-ID: <46A56C49.8050805@gmail.com>
References: <E6CCDC65B8C522458685D8D1F145FEA89E330E@CA2-MSX-C01.nw.net>	<B62D67BD8EC3324C8A3DACEEA1A0D6C6020E0328@dlee12.ent.ti.com>
	<E6CCDC65B8C522458685D8D1F145FEA89E34DC@CA2-MSX-C01.nw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <E6CCDC65B8C522458685D8D1F145FEA89E34DC@CA2-MSX-C01.nw.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Krishna Prasad Herur <kherur@nextwave.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Krishna Prasad Herur stated on 7/23/2007 8:45 PM:
> Aah, you are right. I do have 5.0 SDP, and the documentation does say
> UART not supported. I will try with the latest CSST tool.
>   
One more warning -> VG 5.0 board does support USB over Triton 2(no more
slow UART downloads :) ). This is the USB port on the processor board -
the one closer to the LCD screen.
CSST version currently stands at 1.11.0.3.

Regards,
Nishanth Menon
