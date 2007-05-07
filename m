From: Kevin Hilman <khilman@mvista.com>
Subject: Re: omap_2430sdp_defconfig modules compilation failures
Date: Mon, 07 May 2007 09:42:45 -0700
Message-ID: <1178556165.32585.16.camel@paris.hilman.org>
References: <463C3840.9020605@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <463C3840.9020605@googlemail.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sat, 2007-05-05 at 09:54 +0200, Dirk Behme wrote:
> Trying to compile modules for omap_2430sdp_defconfig fails:
> 
> drivers/usb/musb/plat_uds.c fails because MUSB_C_RAM_BITS definition 
> is missing. This is because we have no asm/arch/hdrc_cnf.h. Davinci 
> tree has this [1], can we take the same?
> 
> drivers/usb/musb/omap2430.c fails because missing AE5_2430_USB0HS_STP 
> and OMAP243X_HS_BASE defines. Actually no idea here.

I have forthcoming patches to get MUSB working on 2430.  In the
meantime, it should probably disabled in the default defconfig.

Kevin
