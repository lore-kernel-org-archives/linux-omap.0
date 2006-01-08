From: Matthew Percival <matthew@capgo.com>
Subject: RE: Toolchain select
Date: Mon, 09 Jan 2006 08:48:51 +1100
Message-ID: <1136756932.8961.3.camel@localhost.localdomain>
References: <43be5ef9.0fd71e2d.4479.ffff8514@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <43be5ef9.0fd71e2d.4479.ffff8514@mx.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

> The error of building u-boot is "No rule to make target `hello_world.srec',
> needed by `all'" and the error of building kernel 2.6.15-omap1 is syntax
> error in touchscreen.

	That is a make error, not a toolchain one: make does not have a rule to
make the said file, and so does not know what to do.  That likely
indicates that it is a file that either should already be there, or
created by an earlier process (eg running 'make something_config' type
operations).  In this case, I can see the file in my examples/
directory, so likely there is something wrong with your process.  Make
sure you have followed the steps for compiling u-boot correctly, as you
do not compile it the same as with most programs.

	-- Matthew
