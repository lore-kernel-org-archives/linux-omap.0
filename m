From: Jukka Honkela <jukka@honkela.org>
Subject: touchscreen problem with H3
Date: Thu, 31 May 2007 09:59:15 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0705310951160.3089@ugly.blerp.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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


Hi,

I've been trying to get touchscreen to work with omap1710 h3 board
but I seem to get

tsc2101 spi2.0: error reading from I/O EXPANDER
tsc2101 spi2.0: platform init failed

during the boot; I believe that this is related to my
current problems, anyhow, as I'm using some precompiled
binaries of tslib etc, I can't be 100% sure that the
problems are not caused by the tslibrary...

I'm using the latest linux-omap kernel from the git
repository. The display itself and the keyboard works
on the board as expected. Any ideas?

-- 
Jukka
