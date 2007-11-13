From: Kevin Hilman <khilman@mvista.com>
Subject: 3430 and UART3 parent clocks
Date: Tue, 13 Nov 2007 11:34:11 -0800
Message-ID: <1194982452.7433.55.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Paul,

On 3430 the board init code enables all 3 UARTs, but it appears the the
clocks for UART3 are not getting enabled because the first access to
UART3 registers crashes with:

Unhandled fault: external abort on non-linefetch (0x1028) at 0xd9020004 

Simply disabling UART3 in the enabled_uarts of board-3430sdp.c gets me a
booting board.

I haven't dug into the details yet, but there are some warnings during
serial init  which suggest that the parent clocks that UART3 depends on
are not being enabled either:

clock.c: Enable for core_l4_ick without enable code
clock.c: Enable for dpll4_ck without enable code
clock.c: Enable for dpll4_x2_ck without enable code
clock.c: Enable for cm_96m_fck without enable code
clock.c: Enable for omap_48m_fck without enable code
clock.c: Enable for core_48m_fck without enable code
clock.c: Enable for per_48m_fck without enable code

Kevin
