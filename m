From: David Brownell <david-b@pacbell.net>
Subject: Re: Moving I2C2 init to plat-omap/devices.c  ?
Date: Thu, 16 Nov 2006 12:19:54 -0800
Message-ID: <200611161219.54874.david-b@pacbell.net>
References: <EA12F909C0431D458B9D18A176BEE4A508A01E5E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A508A01E5E@dlee02.ent.ti.com>
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

On Thursday 16 November 2006 6:58 am, Woodruff, Richard wrote:

> 	Getting any code into the I2C tree might take a bit of effort.
> Tony floated an interesting idea about creating an embedded I2C using
> David's frame work.  This might allow faster integration of performance
> related changes and the like with out fighting with SMB people.

I pinged the i2c list and got sort of mixed responses about that
notion of "embedded I2C" (i.e. rewrite) ... so I took a slightly
different and submitted patches aiming to add more driver model
compatibility to the current stack.

That means there'd still be a major functionality gap in the I2C
stack -- all the calls require a thread context, there are no
async callbacks -- but at least there's a solution for the setup
and configuration problems, potentially mergeable in 2.6.20 and
making the version of i2c-omap.c that's upstream become usable.

There may still be a need for a separate "embedded" stack though;
someone who can justify it should do so!

The patches are:

 http://lists.lm-sensors.org/pipermail/i2c/2006-November/000458.html
	... simple updates, some cleanup plus adding some missing
	driver model calls:  shutdown(), and suspend()/resume().
	Looks like this will be merged after minor tweaking.

 http://lists.lm-sensors.org/pipermail/i2c/2006-November/000469.html
	... not actually a patch; copied at the end of this message,
	this introduces the three interesting patches

 http://lists.lm-sensors.org/pipermail/i2c/2006-November/000470.html
	... first patch mentioned, adds new driver binding model
	that fully conforms to the Linux driver model

 http://lists.lm-sensors.org/pipermail/i2c/2006-November/000468.html
	... second patch mentioned, activates that new model

 http://lists.lm-sensors.org/pipermail/i2c/2006-November/000471.html
	... updates OSK support to use it, and tps65010 driver
	(but not aic23/ALSA, that's not upstream yet)

I figure getting those last three patches merged will "take a bit of
effort", so feel free to weigh in.  In terms of the original post on
this thread, it sort of assumes the OMAP I2C host would switch over
to a slightly different registration call, more or less passing the
platform_device.id ("2" etc) to the I2C layer and saying "use this
as the bus ID".

- Dave
