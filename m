From: "Girish" <girishsg@ti.com>
Subject: RE: touchscreen problem with H3
Date: Thu, 31 May 2007 16:34:58 +0530
Message-ID: <200705311104.l4VB4wAj004753@dbdp31.itg.ti.com>
References: <Pine.LNX.4.64.0705310951160.3089@ugly.blerp.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <Pine.LNX.4.64.0705310951160.3089@ugly.blerp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Jukka Honkela' <jukka@honkela.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 

 

>> -----Original Message-----

>> From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-

>> open-source-bounces@linux.omap.com] On Behalf Of Jukka Honkela

>> Sent: Thursday, May 31, 2007 12:29 PM

>> To: linux-omap-open-source@linux.omap.com

>> Subject: touchscreen problem with H3

>> 

>> 

>> Hi,

>> 

>> I've been trying to get touchscreen to work with omap1710 h3 board

>> but I seem to get

>> 

>> tsc2101 spi2.0: error reading from I/O EXPANDER

 I see this error coming while doin' some read_gpio_expa, it uses i2c
internally...u might want to check this...

 

>> tsc2101 spi2.0: platform init failed

>> 

>> during the boot; I believe that this is related to my

>> current problems, anyhow, as I'm using some precompiled

>> binaries of tslib etc, I can't be 100% sure that the

>> problems are not caused by the tslibrary...

>> 

>> I'm using the latest linux-omap kernel from the git

>> repository. The display itself and the keyboard works

>> on the board as expected. Any ideas?

>> 

>> --

>> Jukka

>> _______________________________________________

>> Linux-omap-open-source mailing list

>> Linux-omap-open-source@linux.omap.com

>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
