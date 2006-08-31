From: Raja Mallik <raja.mallik@sqlstar.com>
Subject: Re: Loading program to OMAP5910
Date: Thu, 31 Aug 2006 14:39:40 +0530
Message-ID: <1157015380.2185.26.camel@Neo>
References: <B3FDBBC0428C8145A83F312B740CE67D075854@si-mail48.de.bosch.com>
	<1156870223.2844.28.camel@localhost.localdomain>
	<000a01c6cbda$36a4b1f0$4e0aa8c0@wbb> <1156942296.2151.18.camel@Neo>
	<44F5C477.7090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <44F5C477.7090108@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thank for the input.

Aparently, I am trying to look for steps as how to load program to my
LDK5910 board which has omap5910.

Now Omap5910 has ARM925T and DSP. 

We are able to load program,but not able to execute to ARM core using
Code Composer Studio 3.1. We are trying to load boot loader and execute
it to program flash through JTAG.

Also we trying to update/load bootloader using serial port. 

At this moment the default bootloader is not there in the board as we
are thinking the flash would have corrupted and serial console output is
not showing up in teraterm/hyperterm. All baud setting are fine as per
document.

we are using rrloader as bootloader.

Is there any other option through which can load the program & execute
in RAM/flash and write to flash.

Pl, give your input in this case..

Regards
Raja Mallik



On Wed, 2006-08-30 at 19:01 +0200, Dirk Behme wrote:
> Raja Mallik wrote:
> > We are able to load program,but not able to execute to ARM core using
> > Code Composer Studio 3.1.We are trying to load boot loader and execute
> > it to program flash through JTAG.
> 
> Check if section 2 of OMAP readme [1] can help you with JTAG 
> and CCS. Maybe the other stuff in HOWTO section of OMAP Wiki 
> [2] can help you as well.
> 
> Dirk
> 
> [1] 
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob_plain;h=f8ffb68e8588c5ad43a72c3534c5f963aa7c91af;f=Documentation/arm/OMAP/README
> 
> [2] http://tree.celinuxforum.org/CelfPubWiki/OSK
