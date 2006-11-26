From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: MMC not working on Z71
Date: Mon, 27 Nov 2006 00:16:04 +0100
Message-ID: <200611270016.04977.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Hi,
since this commit
http://source.mvista.com/git/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dcommit;h=
=3D36808520ce2c9ade647d36c80004c158c71d0510
MMC on palmz71 stopped working. With latest git it doesnt even get inited.=
=20
When I enable debug I get cmd3 timeout. I find out that when I compile=20
initramfs into kernel and try mounting mmc partition, the kernel tries to=20
init the card (I get that MMC: something and mmc: p1 p2 etc. [sorry, I dont=
=20
remember it exactly, I can give more details, if you need them, just ask])=
=20
but fails with a lot of io errors about probs with reading mmc block 0. And=
=20
that=B4s the end. Weird is, that mmc was working with 2618-omap1, but after=
=20
that sync with Linuses tree it just suddenly stopped. The diff against thos=
e=20
2 commits is 32megs, so it=B4s quite a prob to find what damaged the mmc. A=
lso,=20
it=B4s weird that mmc works on palmte. Can this be prob, that mmc isnt powe=
red=20
up? I doubt so though.

Thanx for any ideas.

Best regards
Marek Vasut
