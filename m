From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: I2C TWL4030 Keypad
Date: Sat, 17 Feb 2007 08:08:30 -0600
Message-ID: <45D70C5E.60306@gmail.com>
References: <8bf247760702160325m6624817bpbced2b76db9ae30a@mail.gmail.com>	
	<45D706E7.60301@gmail.com>
	<8bf247760702170604h5b2e210cibe4de58d4f898d74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <8bf247760702170604h5b2e210cibe4de58d4f898d74@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ram <vshrirama@gmail.com>, Linux OMAP List <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Ram stated on 2/17/2007 8:04 AM:
> Hi,
> My speed setting are I2C_OMAP243X_BUS1 = 2600 and
> CONFIG_I2C_OMAP243X_BUS0 = 100.
>
> Actually, im confused.
>
> Porting TWL4030 keyboard to 2.6.19. Im using 2.6.14 for omap2430 as a
> reference.
>
ok, try doing this setting up
I2C_OMAP243X_BUS1 = 400

I understand ur not getting interrupts - normally that should not be
happening.. but am guessing here that ur i2c ops are failing due to some
reason...  if ur using the latest kernel with rt enabled, the drivers
have might not have been tested for it and timing issues are popping up..
Regards,
NM
