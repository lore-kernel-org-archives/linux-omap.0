From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [00/17 PATCH] MMC: OMAP: Add MMC multislot support
Date: Fri, 17 Aug 2007 15:01:28 -0400
Message-ID: <46C5F088.1040507@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: "linux >> omap-linux" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony and folks,

These patch series adds the MMC multislot support for N800 and TI OMAP
H2 and H3 boards. It's based on Juha's and Jarkko's earlier
implementation and it can be applied against most updated linux-omap
tree (2.6.23-rc2-omap1).

I've tested with MMC, SD and SDHC cards and looks fine for the boards
mentioned above.

We are working now to conclude such support on Innovator 1510 and TI
OMAP H4.

I would like to thank a lot to my coworkers at OSMRC Core Team (Anderson
Briglia, David Cohen, Eduardo Valentin and Felipe Balbi), who help me
with this task.

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
