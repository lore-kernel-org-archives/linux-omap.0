From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: omap850/f-sample patches
Date: Thu, 22 Feb 2007 18:02:26 +0530
Message-ID: <61445c750702220432l282cdd9dsfcc5310e949261f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hello,

I saw a similar thread recently but I received it in a digest mode, and I
dont know how to reply so that my queries go in same thread. So, apologies
for spawning new thread for almost same topic.

I am working on a omap850 based board and I have seen patches for
omap850/f-sample on this list. But afaik, these patches are just a starting
point for providing linux support for omap850 i.e. there provide core
support and I think they have been integrated in 2.6.20 kernel officially.
But, various drivers are not integrated in main kernel yet (e.g. in linux
omap git, one can see /drivers/media/video/omap folder but in Linus's
repository it is not there). Does it mean that, full support for omap850 (
i.e. drivers are modified/written to take care of all features of 850 which
are different from previous omaps) is there but not official yet?

So can I assume that the generic drivers etc will work for omap850 with some
tweaking? Board specific stuff remains to be done separately.

-Pharaoh
