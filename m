From: "zil iram" <zil_iram@hotmail.com>
Subject: SPI question
Date: Mon, 15 Jan 2007 14:29:15 +0000
Message-ID: <BAY130-F292E20F8C782D7087AF55BF8B50@phx.gbl>
References: <7b1b9c8b0701142227t2c115db0i45ea7cbb86b67a37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7b1b9c8b0701142227t2c115db0i45ea7cbb86b67a37@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
            I am working on SPI on the osk right now. I connected a sensor 
to the uwire pins of the osk.
I enabled the spi driver(spi.c), and the microwire driver for omap. Is it 
enough to use the spi.c APIs to access(read/write) the sensor that I have 
attached through SPI? Does the SPI core driver(spi.c) wrap the microwire 
driver?

Thanks,
Lizette

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
