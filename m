From: Tony Lindgren <tony@atomide.com>
Subject: Re: Moving I2C2 init to plat-omap/devices.c  ?
Date: Thu, 16 Nov 2006 23:01:22 +0200
Message-ID: <20061116210121.GU21064@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A508A01E5E@dlee02.ent.ti.com>
	<455CC603.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <455CC603.9050409@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <menon.nishanth@gmail.com> [061116 22:12]:
> Woodruff, Richard stated on 11/16/2006 8:28 PM:
> > IP version would clarify some aspects around differences and errata.
> > You would still end up with both (chip & IP) as the integration of the
> > IP into a chip is an area where things are different also.  I find USB
> > client to be one which can be confusing.  From 1510-2420 there are many
> > bug fixes and many are not apparent by register differences.  This can
> > result in older ones being broke or newer ones not running to their
> > potential when sharing.
> I think a V3.x driver, if defined to handle IP of range 3.0>= x <4.0,
> then it can have backward compatibility based on subversion information.
> I can think of more ways this will work than a omap-version based
> approach.. this may not be the thread to discuss that however..
 
Doing different handlers in the drivers depending on the version number
is probably cleanest way to share the code that can be shared. And that
keeps the code clean of lots of if then else.
 
> > By adding enough layers of indirection/functional pointer tables you can
> > usually merge things.  However, this can make the code harder to follow.
> > If people wanted to take the time to merge I suspect that making the HS
> > driver work in a backward compatible manner might be easier than
> > upgrading the FS one.  Given what you know today would you agree with
> > that?  Getting any code into the I2C tree might take a bit of effort.
> I am pointing at the fact that using FIFO changes our bulk of our logic,
> we need to be depending on a different set of interrupts, the transfer
> logic is different etc.. makes 70-80% code look different I think.. yes
> we can still have the same ARDY,NAK,timeout handling..
> I am not sure to what extent..

We could have omap_i2c_v123_whatever() and omap_i2c_v234_whatever() type
functions for the parts that are different to keep the code clean.

Regards,

Tony
