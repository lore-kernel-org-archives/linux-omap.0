From: Matthew Percival <matthew@capgo.com>
Subject: Re: How to compress the filesystem
Date: Tue, 03 Jan 2006 09:19:50 +1100
Message-ID: <1136240391.8899.4.camel@localhost.localdomain>
References: <7e6cc7550512270325m6cfef3cai88dfe007d3e60257@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7e6cc7550512270325m6cfef3cai88dfe007d3e60257@mail.gmail.com>
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

> around 14MB and it consists of all the library files in the /lib.I like to
> know how to compress my own filesystem to the factory filesystem
> level.Isthere any parameter has to be included with
> *mkfs.jffs2 *filesystem creation process?
> Please help me in this regard.

	JFFS2 already compresses, and quite extensively.  Your problem seems to
be that you have too many libraries: you almost certainly do not need
every library out there.  My /lib/ is 4.9MB, and this includes kernel
modules (my toolchain's lib/ is around 31MB, so you can see that most of
the libraries are not being used).  If you remove all the unused
libraries, you will likely cut things down considerably.  The OSK Newbie
Guide talks about this in the Filesystem chapter.

	-- Matthew
