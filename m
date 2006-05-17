From: Kevin Hilman <khilman@mvista.com>
Subject: [ANNOUNCE] TI DaVinci git tree available
Date: Tue, 16 May 2006 17:43:37 -0700
Message-ID: <1147826617.8739.32.camel@vence.internal.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: davinci-linux-open-source@linux.davincidsp.com
Cc: "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

The kernel git tree[1] for the TI DaVinci platform is now available at

  http://source.mvista.com/git/

This kernel is currently based on 2.6.17-rc4 and will follow the
mainline kernel.  

This is currently a minimal kernel with only serial and ethernet
support, but drivers will be added one by one as I forward port them
from the 2.6.10-based MontaVista product.

Included in the tree is a default config (via 'make
davinci_dm644x_defconfig') that should boot.

There are some known issues[2] as well as some areas that could use
updating to the newer kernel and updates for the Linux Driver model.

Patches are welcome!   

Like the OMAP site, TI is maintaining a Linux site for DaVinci at
http://linux.davincidsp.com/  Mailing-list subscription info can be
found there.

-- 
Kevin Hilman <khilman@mvista.com>
MontaVista Software, Inc.



[1] For those new to git, there is an overview, tutorial and man pages
available at http://www.kernel.org/git/  

[2] Known issues:  Something has changed in the 8250 serial driver since
2.6.10 which causes some problems on the serial console.  Interrupts
seem to be lost such that the driver seems to be a few characters behind
what you're typing.  This is still under investigation, but any help
appreciated.
