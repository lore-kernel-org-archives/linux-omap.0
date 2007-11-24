From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 0/1] OMAP: DMA: Attribution necessary only if the ch is not
 chained.
Date: Sat, 24 Nov 2007 18:29:34 -0400
Message-ID: <4748A5CE.7080602@indt.org.br>
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

Hi Anand and folks,

Since the merging of linux-omap tree with linus tree, I'm facing a problem with MMC multislot support on N800 boards, that stops working. 

Well, after investigating recent modifications on DMA, I was verifying Anand Gadiyar' patch 'OMAP: DMA: Added support for DMA chaining' and I realize a line of this patch is the source of the problem.

Apparently, the attribution 

+       status = OMAP_DMA_CSR_REG(ch);

is necessary only if the ch is not chained.

Tested on N800 with MMC multislot support and works fine again.

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
