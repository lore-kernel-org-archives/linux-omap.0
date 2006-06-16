From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: gpmc.c: gpmc_get_clk_period missing
Date: Fri, 16 Jun 2006 03:57:40 -0700
Message-ID: <1150455460.28872.263968466@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
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

Juha,

gpmc_get_clk_period / get_gpmc_clk_period is missing, and didn't pop-up
any error as it was under #DEBUG. 

But I hope that function does 

(return 1000000000 / (clk_get_rate(gpmc_l3_clk)/div)/10000)


-- 
http://www.fastmail.fm - Send your email first class
