From: "k c" <omap_mails@hotmail.com>
Subject: libraries for software floating point emulation
Date: Fri, 02 Dec 2005 16:20:18 +0000
Message-ID: <BAY23-F151893AD590CF9C07CE43FF94C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

I have tried to force gcc to use software floating point emulation, but a 
binary with emulated floating point is not compatible with the glibc and 
other library binaries in the Linux distribution on the OMAP1710 wish uses 
hardware floats.
Perhaps there are binaries, primary glibc and libgcc that we can use to link 
statically with the application that uses software floating point?

Also is there a way to turn of the logging of the floating-point exception 
traps that occurs to the Linux-kernel. We would still have the exception 
overhead, which probably is many times larger then the actual emulation.
But at least would we get rid of the logging over network overhead.
Any suggestions will be helpful.

Regards,
k

_________________________________________________________________
Shah Rukh fan? Know all about the Baadshah of Bollywood. On MSN Search 
http://server1.msn.co.in/profile/shahrukh.asp
