From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: RE: NPTL on OMAP 5912
Date: Thu, 3 Aug 2006 16:15:16 +0100
Message-ID: <00b601c6b70f$a08b1620$642aa8c0@Buffy>
References: <20060803122348.GA23880@orphique>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-reply-to: <20060803122348.GA23880@orphique>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Ladislav Michl' <MICHL@2n.cz>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Thanks for the pointers. Which shared objects do you include in your target
filesystem?

TIA,

Richard.

-----Original Message-----
From: Ladislav Michl [mailto:MICHL@2n.cz] 
Sent: 03 August 2006 13:24
To: Richard Copeman
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: NPTL on OMAP 5912

On Thu, Aug 03, 2006 at 10:40:45AM +0100, Richard Copeman wrote:
> Hi,
> 
> I have a 2.6.15 kernel running on my 5912OSK board. Has anybody got the
NPTL
> stuff working on here? Can someone point me at a getting started guide?

http://kegel.com/crosstool/
I used hacked version 0.38 to build NTPLed toolchains. If you are not
familiar with building toolchains you may want to use precompiled ones:
http://www.codesourcery.com/gnu_toolchains/arm/

> I tried to figure out which version of threads my target supports:
> 
>             Getconf GNU_LIBPTHREAD_VERSION
> 
>  But the command returned an empty string :-(
> 
> I built my target with GCC 3.4.1 which I built using crosstool.

That's not enought recent gcc (unless you are using codesourcery patches).
I'm using gcc-4.1.1, glibc-2.4 and binutils-2.17 sucessfuly.

Best regards,
	ladis
