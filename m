From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Nokia N810 support
Date: Fri, 23 Nov 2007 11:09:04 +0200
Message-ID: <1195808944.32096.11.camel@mort>
References: <1195778318-12008-1-git-send-email-lauri.leukkunen@nokia.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195778318-12008-1-git-send-email-lauri.leukkunen@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Lauri Leukkunen <lauri.leukkunen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
On Fri, 2007-11-23 at 02:38 +0200, ext Lauri Leukkunen wrote:
> This patch-set provides basic support for N810. Comments are welcome,
> especially concerning structuring of the board-nXX.c files in the
> future.

Would it make sense to have just one common set of files for platforms
that are almost identical and can run the same binaries?

The Nokia product naming scheme might not help us, but what about
board-nokia-2420.c ?

After all we already have a similar defconfig.

Everything that is board specific should be compiled as module and
loaded on-demand when doing board probing at runtime.

So it would be easier to have common stuff (like dvfs) in the
board-nokia-2420.c file, while other product specific stuff, like ALS or
keyboard could go to board-n810.c

If we assume that we can trust the parameter passed by the bootloader,
it would be pretty trivial to know which board the binary is running on.

-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
