From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Kernel not working
Date: Mon, 21 Nov 2005 02:55:57 -0800 (PST)
Message-ID: <20051121105557.5206.qmail@web32901.mail.mud.yahoo.com>
References: <004301c5ee89$153ff350$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <004301c5ee89$153ff350$642aa8c0@BUFFY>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Richard Copeman <richard.copeman@lauterbach.co.uk> wrote:

> Hello,
> 
>  
> 
> I'm a newbie, so please forgive me if this has been answered
> elsewhere.
> 
> I have the 2.6.8rc3 kernel source downloaded from linux.omap.com and
> have
> built with GCC 3.3.2. I have not done any tweaking in make xconfig,
> so it
> should be the standard OMAP 5912 OSK kernel. I get the vmlinux output
> which
> I put through objcopy and the appropriate mkimage for my version > of

I don't know if you need to update u-boot or not, but you can update
the kernel from 

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=log;t=7

A README for fetching the kernel tree is provided on 
http://www.muru.com/linux/omap/

You then please enable low-level debugging CONFIG_DEBUG_LL in the
kernel configuration and post the serial-output messages if any.

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
