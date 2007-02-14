From: "zil iram" <zil_iram@hotmail.com>
Subject: SPI on omap5912
Date: Wed, 14 Feb 2007 10:27:25 +0000
Message-ID: <BAY130-F4DCEF5FF81D4F3D9E6F61F8970@phx.gbl>
References: <000001c74f78$215d9740$6418c5c0$@lu@serialsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <000001c74f78$215d9740$6418c5c0$@lu@serialsys.com.hk>
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

I would like to ask you regarding the spi conroller (spi master/slave) on 
omap. I looked at the document regarding the omap serial interfaces -- 
spru760a-serial.pdf and from what I have read,
the spi controller can hold the chipselect line to its active level to a 
maximum of 32 bits of data,

	the device enable (nTSPENi) goes low once the WR bit is set and goes back 
to high again once the transmission is complete.
	the registers SPI_TX & SPI_RX which are 32bits wide are used for each 
transmission, meaning, each transmission can only handle 32bits
	therefore, the CS line can only be held to a maximum of 32 bits

Is there a way to hold the CS line longer? I would like to write 32bits to 
an address on my sensor which is connected through SPI. To be able to do 
that, I must
first write the 8-bit address and then write the next 32 bits of data with 
the CS line held low throughout the process. Currently, I could only write 
24 bits of data after
writing the 8 bit address since after this, the CS signal goes back to high.

Is there a way to hold the CS line longer than 32 bits? Is there a way to 
transfer more than 32 bits with the CS line held to its active level?

Thanks,
Lizette

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
