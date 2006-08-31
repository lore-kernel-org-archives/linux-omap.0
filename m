From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: IP-Config: Failed to open eth0
Date: Thu, 31 Aug 2006 13:20:57 +0200
Message-ID: <20060831112057.GA11784@orphique>
References: <20060831033746.25882.qmail@web17810.mail.tpe.yahoo.com>
	<20060831090634.93519.qmail@web17805.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060831090634.93519.qmail@web17805.mail.tpe.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: kabbin <kabbin26@yahoo.com.tw>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 31, 2006 at 05:06:34PM +0800, kabbin wrote:
> Dear all: 
>   I cannot boot from NFS. Could anyone help me please?  My board is omap2420h4,  kernel 2.6.10  
> 
> 
> Does following means that the network driver configuration is wrong?
> Why Invalid ethernet MAC address ?  I have setenv ethaddr already.
> 
> I got :
> 
> Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
> smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
> eth0: SMC91C94 (rev 9) at 0xc4858300 IRQ 188 [nowait]
> eth0: Invalid ethernet MAC address.  Please set using ifconfig

Did you read that hint? ifconfig (8) lives on your NFS root you so you
have serious problem ;-) You can either use initrd as workaround 
or preferably set MAC address corectly. Assuming you are using U-boot:
http://www.denx.de/wiki/bin/view/DULG/EthernetDoesNotWorkInLinux
You can also look at U-Boot source code:
board/voiceblue/eeprom.c

Best regards,
	ladis
