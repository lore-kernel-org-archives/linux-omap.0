From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: osk5912 boot failure with u-boot 1.1.4
Date: Wed, 31 May 2006 17:54:33 +0200
Message-ID: <447DBC39.5010202@gmail.com>
References: <933035583@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <933035583@web.de>
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
> #Error: unrecognized/unsupported machine ID (r1 = 0x00000003).
>
> #00000203        TI-OSK
>
> these are the settings i made in the kernel .config:

Your u-boot passes wrong machine ID to kernel (3, should be 
0x203). So your kernel should be correct, but your u-boot 
seems to be wrong. Looking at

http://www.denx.de/cgi-bin/gitweb.cgi?p=u-boot.git;a=blob;h=6993b136eebbf10cfdf1c678958ab4b6d3162577;hb=392c252efd5d2e67b47ebeb3b7e4f42e7e3d5127;f=board/omap5912osk/omap5912osk.c

recent u-boot passes the correct number if build correctly. 
Do you really built u-boot with

make omap5912osk_config
make

?

Regards

Dirk
