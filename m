From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Running u-boot directly from RAM
Date: Fri, 9 Mar 2007 14:48:51 +0530
Message-ID: <61445c750703090118y3c81b898y552a330c32df9152@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hello

I am working on a omap850 based custom board. As per my understanding,
one of the earlist things u-boot does is initializing the SDRAM
controller so that RAM can be used for setting up execution
environment i.e. setting up stack etc. then u-boot relocates itself to
RAM and so on.

If I have to run u-boot directly from RAM without flashing it i.e. I
copy u-boot to RAM directly using one of the utilities and make it run
from there, I am doing something wrong here? In this case when the
u-boot is copied directly to RAM, has the RAM been initialized? The
u-boot image gets successfully downloaded to RAM but is the RAM
initialized in order to executre u-boot directly. Very naive question
indeed.

-pharaoh.
