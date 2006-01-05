From: Matthew Percival <matthew@capgo.com>
Subject: Re: Toolchain select
Date: Fri, 06 Jan 2006 09:00:50 +1100
Message-ID: <1136498450.8801.7.camel@localhost.localdomain>
References: <43bd2165.6762f2e2.3596.51a6@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <43bd2165.6762f2e2.3596.51a6@mx.gmail.com>
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

> I have already used the crosstool to make my own toolchain, and chose the
> gcc-4.0.1, binutils-2.16.1, glibc-2.3.5.  But it seems that it has some
> problem.  When I build u-boot it shows that the examples cannot be compiled.

	u-boot may not be a good test.  Versions of u-boot older than 1.1.4 do
not compile with 4.0 at all; even 1.1.4 seems to have problems, as some
users have reported that it does not compile (most seem to be OK, but
there are a few who cannot).  You said that kernel did not compile
either, though, and that should work, so the problem in your case likely
lies with the toolchain.

	My toolchain was compile with gcc-4.0.1, binutils-2.15 and glibc 2.3.5:
this combination is known to work.  Looking at the crosstool buildlogs,
your combination is not listed, so it is somewhat of an unknown
quantity, though it sounds like the combination you have picked does not
work.  I would recommend looking at the crosstool buildlogs yourself, to
see what combinations are known to work, and sticking with them, unless
you want to experiment with different combinations.

	-- Matthew
