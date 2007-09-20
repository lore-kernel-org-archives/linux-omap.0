From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 0/14] MMC: OMAP: Add MMC multislot support
Date: Thu, 20 Sep 2007 11:02:56 -0400
Message-ID: <46F28BA0.3080002@indt.org.br>
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony and folks,

This is the latest 'MMC: OMAP: Add MMC multislot support' patch series
with changes, corrections and improvements based on comments and
suggestions from community (mainly Tony, Brownell and Trilok) and coworkers.

Just to remind you, this patch series adds the MMC multislot support for
N800 and TI OMAP H2 and H3 boards. It's based on Juha's and Jarkko's
earlier implementation and it can be applied against most updated
linux-omap tree (2.6.23-rc6-omap1).

I've tested with MMC, SD and SDHC cards and looks fine for the boards
mentioned above.

Testing, comments and suggestions are welcome.

BR,

Carlos.

-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
