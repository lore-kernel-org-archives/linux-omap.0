From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] [OMAP MMU FW] Translate printk to dev_*
Date: Mon, 03 Sep 2007 08:20:07 +0300 (EEST)
Message-ID: <20070903.082007.75494158.Hiroshi.DOYU@nokia.com>
References: <11879812502262-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11879812502262-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: edubezval@gmail.com
Cc: eduardo.valentin@indt.org.br, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This looks ok to me. Ack.

From: "ext Eduardo Valentin" <edubezval@gmail.com>
Subject: [PATCH 1/1] [OMAP MMU FW] Translate printk to dev_*
Date: Fri, 24 Aug 2007 14:47:30 -0400

> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> - Translates printk to dev_*
> - Breaks lines with more than 80 columns
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
