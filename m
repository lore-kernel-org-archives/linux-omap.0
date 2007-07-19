From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: My experiences with omap git tree and git-bisect
Date: Wed, 18 Jul 2007 21:35:50 -0500
Message-ID: <469ECE06.6000409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP List <linux-omap-open-source@linux.omap.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

Hi All,
Thought I'd share my inexperience with all.. Short story: i failed.. and
decided to do binary search with cg-switch

While tryng to track fb
issue(http://linux.omap.com/pipermail/linux-omap-open-source/2007-July/010591.html)
down to the right patch, I started with what Paul suggested (and saw
that Linus's pet suggestion is also the same). Armed with the following
references I started my journey :):
Ref
a: http://kerneltrap.org/node/11753
b: http://boinkor.net/archives/2006/11/using_git_bisect_to_locate_bug_1.html
c. http://www.kernel.org/pub/software/scm/git/docs/git-bisect.html

Since I know that Tony has not had time to tag our git with
2.6.22-omapx, I did the following (my criteria is that I should see
omap2430sdp defconfig, afterwhich i'd do a makedistclean,make
defconfig;make uImage):
[user@wontsay linux-omap.dev]$ git-bisect start
[user@wontsay linux-omap.dev]$ gitbisect bad
Bisecting: 788 revisions left to test after this
[27bb9e79bcfedc1888d23c3c212c189fa8534fe7] Blackfin SPI driver: tweak
spi cleanup function to match newer kernel changes
[user@wontsay linux-omap.dev]$ ls arch/arm/configs/*2430*
ls: arch/arm/configs/*2430*: No such file or directory
[user@wontsay linux-omap.dev]$ git bisect bad; ls arch/arm/configs/*2430*
Bisecting: 395 revisions left to test after this
[45efebf2492187e8915e2876c5bf6f3803b1c23f] Merge branch 'master' of
master.kernel.org:/pub/scm/linux/kernel/git/davem/net-2.6
ls: arch/arm/configs/*2430*: No such file or directory

<snip>

ls: arch/arm/configs/*2430*: No such file or directory
[user@wontsay linux-omap.dev]$ git bisect bad; ls arch/arm/configs/*2430*
3d4bd24b019981394fabb465b0c7932924b83d65 is first bad commit
commit 3d4bd24b019981394fabb465b0c7932924b83d65
Author: Florin Malita <fmalita@gmail.com>
Date:   Fri May 18 16:04:33 2007 -0400

 <snip>

:040000 040000 fe71bf80e9cf1b10a7ce91a4a92be56a3079ac37
cb8f7046285a2e6e32645d38cd331fd3a2bd9094 M      drivers
ls: arch/arm/configs/*2430*: No such file or directory
[user@wontsay linux-omap.dev]$

In short none of the bisected trees had the defconfig!!!

finally doing a bit of research, decided to use
cg-switch(http://linux.die.net/man/1/cg-switch):

cg-switch -r 4ed427693dd7e0d4fd00a493988cefaa17accebc testing
cg-switch -f -r dd1d9a62f7cd60b544013eb429d6a3137617f0b2 testing
and so on... till i found the right version...
To find the commit id's i am interested in: http://source.mvista.com/git/?p=linux-omap-2.6.git;a=summary and cherry picked the OMAP related + clock,fb,mux,dss related patches in reverse order.. essentially doing a binary search

The interesting question is why did git-bisect not work on omap linux git tree?? or was I being a dumbass and using it wrongly?

Regards,
Nishanth Menon
