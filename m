From: Tony Lindgren <tony@atomide.com>
Subject: Git pull request for omap patches for post 2.6.26
Date: Thu, 3 Jul 2008 13:11:42 +0300
Message-ID: <20080703101139.GE14276@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Russell,

Please pull the omap patches for post-2.6.26 from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap2-upstream

The patches in question have been posted earlier to linux-arm-kernel
as three separate sets:

[PATCH 00/21] Omap upstream patches for post 2.6.26 [1]
[PATCH 00/12] Omap2 clock patches for post 2.6.26 [2]
[PATCH 00/16] Omap2 patches for post 2.6.26 [3]

These patches can be also viewed at [4][5][6].

As the earlier omap fixes have now been merged, I've rebased
these patches on top of v2.6.26-rc8-204-gc461a97.

Regards,

Tony


[1]
http://lists.arm.linux.org.uk/lurker/message/20080607.014741.c6666812.en.html
http://lists.arm.linux.org.uk/lurker/message/20080607.013033.9ad5054e.en.html
...

[2]
http://lists.arm.linux.org.uk/lurker/message/20080607.015122.ee025150.en.html
http://lists.arm.linux.org.uk/lurker/message/20080607.013506.bdb3222f.en.html
...

[3]
http://lists.arm.linux.org.uk/lurker/message/20080607.014741.c6666812.en.html
http://lists.arm.linux.org.uk/lurker/message/20080607.014742.746c44a3.en.html
http://lists.arm.linux.org.uk/lurker/message/20080607.021228.06b0242e.en.html#linux-arm-kernel
...

[4]
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=097c584cd48844d9ef8402bdc6ab49e7e2135f31

[5]
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=5114490e93ae9e445365bd9ff9e6bd96ae816307

[6]
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=457dfc3bf3ac4ac1f6a5ab6651b52caed3f8d4da

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
