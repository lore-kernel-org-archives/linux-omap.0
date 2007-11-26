From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 00/17] MMC: OMAP: Add MMC multislot support
Date: Mon, 26 Nov 2007 12:00:59 -0400
Message-ID: <474AEDBB.1070006@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony and folks,

This is the latest 'MMC: OMAP: Add MMC multislot support' patch series
with changes, corrections and improvements based on recent comments and
suggestions from community and coworkers.

Just to remind you, this patch series adds the MMC multislot support for
N800 and TI OMAP H2 and H3 boards, and Siemens SX1. It's based on Juha's and Jarkko's
earlier implementation and it can be applied against most updated
linux-omap tree (2.6.24-rc3-omap1, on top of commit 3e1251dd443d07f5a5298646adf746e4add89cf3).

After recent merging of linux omap tree with linus tree, such support was broken for N800.
After investigating it, I realize the source of the problem comes from DMA, from a line of 
Anand Gadiyar' earlier patch committed [1].

In order this support work properly on N800, please apply the patch I proposed at [2].

I've tested with MMC, SD and SDHC cards and looks fine for the boards
mentioned above (SX1 is compiled test only).

Testing, comments and suggestions are welcome.

BR,

Carlos.

PS: This week, I'll be sending the patches to provide such support for Innovator 1510.

[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=8691f1711eace1ee237a474a31574bdd59efb4c3
[2] http://linux.omap.com/pipermail/linux-omap-open-source/2007-November/012177.html

-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
