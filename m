From: Brian Swetland <swetland@google.com>
Subject: Re: Trasnferring u-boot to P2 730
Date: Fri, 7 Apr 2006 09:29:38 -0700
Message-ID: <20060407162938.GA9920@localhost.localdomain>
References: <99E943D7AA8E3A448619E1F809F2A2A202CE6ACF@dlee04.ent.ti.com>
	<OF252DA920.39024BFA-ON65257149.004C9463-65257149.004F0E12@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <OF252DA920.39024BFA-ON65257149.004C9463-65257149.004F0E12@flextronicssoftware.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Cc: Linux-omap-open-source@linux.omap.com, linux-omap-open-source-bounces@linux.omap.com
List-Id: linux-omap@vger.kernel.org

[Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>]
> Hello 
> 
> I am also working on the P2 board and having similar problems with u-boot 
> download onto the board.
> 
> Can we not use OST Tools - a TI application, for downloading the 
> u-boot.bin onto the P2 board RAM/FLASH, OST seems to have flexibility 
> between downloading & executing images from RAM AND downloading/burning 
> images to flash.
> 
> I was able to download the u-boot.bin (the raw binary) as well as u-boot 
> (ELF image) to P2's RAM using OST Tools over a serial line (COM1). I has 
> success in downloading u-boot to the specific address in RAM, but the 
> image doesn't seem to execute/run. ALso, there is a provision of 
> downloading images over the USB connection to the target, but in my case 
> my Windows PC does not detect the P2 board as a USB device when I connect 
> the board to the host PC with a USB cable. Rather, the charging LED on the 
> board blinks for a second. 

There is a bug in P2 (some combination of an on-die rom bug and a board
design issue, iirc) that prevents USB download from working.

Brian
