From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [Help][OMAP_osk_5912]How to get an extra serial port for
	developing?
Date: Mon, 13 Mar 2006 14:02:51 -0800
Message-ID: <4415EC0B.6020905@am.sony.com>
References: <20060311164424.2CCCD85317@mailreg.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060311164424.2CCCD85317@mailreg.nctu.edu.tw>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Keria Seymour <subsun.ece94g@nctu.edu.tw>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Keria Seymour wrote:
> We all now the OSK5912 board already has a built-in serial port, but could
> you tell me how to get an extra port for developing?
> 
> (For our application, we need one serial port for RS-232 connection
> Bluetooth and another for console.)

The 5912 has two 8250 compatable UARTS, but only the first has a RS232C line
driver.  You need to add a second (externel) line driver for the second
UART.  The signals come out on connector P11.  Check the schematic diagram.

-Geoff
