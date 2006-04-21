From: Kevin Hilman <khilman@mvista.com>
Subject: Re: Kernel Boot Problem - OMAP 730 P2 - v2.6.9-rc1-omap1
Date: Fri, 21 Apr 2006 09:32:29 -0700
Message-ID: <4449091D.2030009@mvista.com>
References: <OFB11CB3E7.FA5ED181-ON65257157.002A9E00-65257157.002C2D03@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <OFB11CB3E7.FA5ED181-ON65257157.002A9E00-65257157.002C2D03@flextronicssoftware.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Chetan Kapoor wrote:
> Hello
> 
> Thanks for the reply.
> 
> Yes, we tried out downloading the zImage to the SDRAM & executing it using 
> 'go' command. And, we did get the kernel boot traces on the terminal. 

This is expeted.  u-boot doesn't pass bootargs when using 'go', only 'bootm'

> the uImage still doesn't seem to execute. uImage was created using the 
> mkimage utility. The command issued (on the development host) to create 
> uImage is:
> 
> mkimage -n 'Linux Kernel Image 2.6.9-rc1-omap1' -A arm -O linux -T kernel 
> -C none -a 0x10008000 -e 0x10008000 -d zImage uImage

You can also use 'make uImage' in the kernel source.  I've done a 'make uImage' 
with the latest git tree.  You can also grab the resultant uImage from 
ftp://hilman.org/omap730/uImage-2.6.16-rc5-omap1 to test on your board.

You might try updating your u-boot.  The version on my board (rev4) is 1.1.4. 
There should be a newer u-boot available on linux.omap.com (which is currently 
down.)

Kevin
