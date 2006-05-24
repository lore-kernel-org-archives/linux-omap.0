From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Kernel 2.6.16 hangs after start booting with U-Boot 1.1.2
Date: Wed, 24 May 2006 16:35:56 +0200
Message-ID: <44746F4C.60500@gmail.com>
References: <922740597@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <922740597@web.de>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Martin Margraf <m_margraf@web.de>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Martin Margraf wrote:
> my problem is that after updating u-boot from 1.1.1 to 1.1.2 and after patching /arch/arm/boot/compressed/makefilfe and head-omap.S
> the kernel is hanging up at start. i use the latest kernel (2.6.16.18) and patched it with the 2.6.16-omap1 patch.

You don't tell us which board you use, which patches you 
applied to makefile and head-omap.S and where kernel hangs.

Try to enable

Kernel hacking -> Kernel debugging -> Kernel low-level 
debugging functions

for debugging.

Often made mistake are wrong parameters passed from u-boot 
to kernel (e.g. board ID) after u-boot update.

Why do you update to u-boot 1.1.2 and not latest one (1.1.4)?

Cheers

Dirk
