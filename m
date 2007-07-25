From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: OMAP2430sdp MMC driver for 2.6.21
Date: Wed, 25 Jul 2007 21:22:21 +0200
Message-ID: <fb249edb0707251222u42e0aff4pa176536c1e1468fb@mail.gmail.com>
References: <46A784AF.000063.16530@bj126app26.126.com>
	<80f873930707251017r2c557aa1mf642132e3930c964@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <80f873930707251017r2c557aa1mf642132e3930c964@mail.gmail.com>
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
To: "linux-omap-open-sour..." <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,
this may be unrelated but I found that the (not so) recent change in
mmc_omap_set_ios() broke SD support on OMAP310. I was digging into the
driver maybe two month sago and found that the change made the MMC
host send the init sequence to the card far too often during
initialisation. Sending it only once or reverting the following
commit:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=46a6730e3ff9add5089ddd007f998b97fb4e8571

made it work better. I haven't posted any information because I had to
give up before I managed to make the driver work completely, like it
did in 2.6.20. The issue of setting R1 response type instead of R6 and
other issues are still unresolved.

Regards
