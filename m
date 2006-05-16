From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Userspace GPIO
Date: Tue, 16 May 2006 07:09:55 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A505A85415@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Matt Callow <mc-lists@tesco.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Since the GPIO lines are mapped into the ARM memory space, you can use
a
> program like devmem2 to access the memory locations directly. Maybe
not
> the most elegant solution but I've used the program successfully on an
> OMAP board. Try searching for devmem2.c in google.

I wouldn't recommend that.  32 GPIOs are controlled per register.  A
direct user space write with out any locking could destroy the state of
a gpio owned by someone else.  If someone really wanted to use it, then
some proxy between (/proc/sys/syscall) to the real kernel API should be
created.  It might be fun to have some notification method if the GPIO
were configured as an interrupt source.

Regards,
Richard W.
