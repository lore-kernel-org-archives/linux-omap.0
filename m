From: David Brownell <david-b@pacbell.net>
Subject: Re: FSUSB Port 0 in OAMP2430 SDP
Date: Fri, 17 Aug 2007 17:54:45 -0700
Message-ID: <200708171754.45233.david-b@pacbell.net>
References: <78d6ed630708041237v56338867hd88514c428a56b54@mail.gmail.com>
	<31e679430708090419j77cf9a60s786f0582fa3af24@mail.gmail.com>
	<78d6ed630708091136u75f83411xb7ee8bcc08870b52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <78d6ed630708091136u75f83411xb7ee8bcc08870b52@mail.gmail.com>
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
Cc: Amit Gupta <amit_jobs05@inbox.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 09 August 2007, Amit Gupta wrote:
> But consider the linux isp1301_omap.c, isp1301_set_host function. In
> this it tries to power up the vbus(setting the vbus_drv), but I
> suppose mandatory requirement for this is that I have mini A plug is
> connected since transceiver is having atleast logic to power up the
> vbus only if it is connected to function on the other end, or else it
> would not power up the bus just for some breakdown since it should not
> happen that from both of cable is powered up(5 volts).

As originally written, the ID Pin in the isp1301 driver was ignored
except in OTG mode.  If the driver was given a host-only config, the
isp1301 chip was forced into a mode where it provided 8mA VBUS power
regardless of anything else -- handy if you have no Mini-A cable
or adapter.  For a peripheral-only config, it was forced into a mode
where VBUS was never provided.

Latest code shouldn't be *too* different from that, but it might
not be happy on such current silicon since I don't knwo the last
time anyone really worked with that fullspeed OTG stuff.
