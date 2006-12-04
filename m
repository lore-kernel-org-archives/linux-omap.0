From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP I2C - probe question
Date: Mon, 4 Dec 2006 13:11:40 -0800
Message-ID: <200612041311.40802.david-b@pacbell.net>
References: <9C23CDD79DA20A479D4615857B2E2C4702AEA6@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4702AEA6@dlee13.ent.ti.com>
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

There seems to be rather more interest in a later series of patches
I posted:

  http://lists.lm-sensors.org/pipermail/i2c/2006-November/000516.html

The first part of that is cleanups.  The second half adds a "new style"
model for driver binding, which doesn't need SMBUS_QUICK probing.

That said, I've suspected that the "controller can't do SMBUS_QUICK"
issue is something that TI should fix.

- Dave
