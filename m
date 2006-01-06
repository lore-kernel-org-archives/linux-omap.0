From: "Li Weichen" <iaadoa@gmail.com>
Subject: RE: Toolchain select
Date: Fri, 6 Jan 2006 20:13:36 +0800
Message-ID: <43be5ef9.0fd71e2d.4479.ffff8514@mx.gmail.com>
References: <1136498450.8801.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1136498450.8801.7.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Matthew Percival' <matthew@capgo.com>, 'Linux OMAP Open Source' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Well, if I use the toolchain consists of gcc-4.0.1, binutils-2.15,
glibc-2.3.5 to build u-boot and the kernel 2.6.15-omap1, I will still get
errors.  The error of building u-boot is "No rule to make target
`hello_world.srec', needed by `all'" and the error of building kernel
2.6.15-omap1 is syntax error in touchscreen.

I don't know where is the problem.
> 	u-boot may not be a good test.  Versions of u-boot older than 1.1.4
do
> not compile with 4.0 at all; even 1.1.4 seems to have problems, as some
> users have reported that it does not compile (most seem to be OK, but
> there are a few who cannot).  You said that kernel did not compile
> either, though, and that should work, so the problem in your case likely
> lies with the toolchain.
> 
> 	My toolchain was compile with gcc-4.0.1, binutils-2.15 and glibc
2.3.5:
> this combination is known to work.  Looking at the crosstool buildlogs,
> your combination is not listed, so it is somewhat of an unknown
> quantity, though it sounds like the combination you have picked does not
> work.  I would recommend looking at the crosstool buildlogs yourself, to
> see what combinations are known to work, and sticking with them, unless
> you want to experiment with different combinations.
> 
> 	-- Matthew
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
