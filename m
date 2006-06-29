From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: OMAP850 with "uboot_load.exe" ? How become "debug info" ?
Date: Thu, 29 Jun 2006 20:00:42 +0300
Message-ID: <44A4073A.9080305@cc.jyu.fi>
References: <20060629114114.75224.qmail@web27803.mail.ukl.yahoo.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060629114114.75224.qmail@web27803.mail.ukl.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Omap 850 <omap850@yahoo.de>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

The uboot_load.exe and bootstrap.bin have only been tested for booting
Linux from wince with omap1510 based
devices. uboot_load.exe is wince executable which purpose is to load and
launch the OS independent bootstrap.bin.
(And pass linux boot parameters read from the config file for it)
Bootstrap.bin will then load the image or zImage and then launch the
Linux boot process with

Somebody in freenodes htc-linux irc channel tried recently to use
uboot_load.exe and bootstrap.bin also for booting the omap850 but did
not have success with it.
So propably there are needed some changes at least for the bootstrap.bin
code.

Sources for both of these are available in
svn://fuzzyneural.net/h6300/bootstrap/trunk &
svn://fuzzyneural.net/h6300/uboot_load/trunk
For compiling the bootstrap.bin I have used gcc-3.3 based
arm-crosscompiler from the familiar site. (Binaries made with gcc 3.4
have not worked for some reason)
For compiling uboot_load you can use either the Microsoft eVC 4.0 or
arm-wince-pe gcc crosscompiler.

Mika
Omap 850 wrote:
> hello togehter,
>
> can sombody tell me how to become a debug file from "uboot_load.exe" ?
>
> i try to boot my "Vodafone compact II", with OMAP850
> with the "uboot_load.exe" ... but nothing happens.
> How must i configure the "uboot.txt" that "uboot_load.exe"
> write a logfile/debugfile ?
>
> thanks
>
> bye
>
> omap850
>
>  		
> ---------------------------------
> Mit Yahoo! Mail SpamGuard lesen Sie nur die Mails, die Sie auch wirklich lesen wollen.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>   
