From: Matthew Percival <matthew@capgo.com>
Subject: RE: Toolchain select
Date: Mon, 09 Jan 2006 14:06:28 +1100
Message-ID: <1136775989.8961.14.camel@localhost.localdomain>
References: <43c1c602.744e24c8.3c58.744e@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <43c1c602.744e24c8.3c58.744e@mx.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

> What version of u-boot are you using?  I use the u-boot-1.1.4 and
> u-boot-1.1.3, and my steps is,
> $tar xjvf u-boot-1.1.x
> $cd u-boot-1.1.x
> $make omap5912osk_config
> $make

	I am using 1.1.2; I have 1.1.4, but it does not link (I have not
investigated why yet, as it is pretty low priority).

	Your process is correct, so it is a little strange that the file does
not exist.  The command which creates the file (as called from the
Makefile) is:
	arm-linux-objcopy -O srec hello_world hello_world.srec 2>/dev/null
	I would suggest looking for where that command is used when you run it,
for there is likely a minor error being flagged at this point (run make
distclean first, then start afresh).

> And have you tried building the 2.6.15 kernel?

	Not yet: it is not on my current list of priorities.  I am running
2.6.14-omap1 at the moment.

	-- Matthew
