From: Komal Shah <komal_shah802003@yahoo.com>
Subject: omap mmc build errors
Date: Mon, 10 Apr 2006 14:26:57 -0700 (PDT)
Message-ID: <20060410212657.90862.qmail@web32905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Well, latest OMAP MMC driver even doesn't build for H4. 

drivers/mmc/omap.c: In function `mmc_omap_xfer_data':
drivers/mmc/omap.c:343: warning: unused variable `reg'
drivers/mmc/omap.c:344: warning: unused variable `p'
drivers/mmc/omap.c:1227:30: unterminated argument list invoking macro
"dev_err"
drivers/mmc/omap.c: In function `mmc_omap_dma_cb':
drivers/mmc/omap.c:661: error: `dev_err' undeclared (first use in this
function)
drivers/mmc/omap.c:661: error: (Each undeclared identifier is reported
only once
drivers/mmc/omap.c:661: error: for each function it appears in.)
drivers/mmc/omap.c:661: error: syntax error at end of input
drivers/mmc/omap.c:658: warning: unused variable `mmcdat'
drivers/mmc/omap.c:111: warning: 'dev_attr_cover_switch' defined but
not used
drivers/mmc/omap.c:140: warning: 'dev_attr_enable_poll' defined but not
used
drivers/mmc/omap.c:265: warning: 'mmc_omap_dma_timer' defined but not
used
drivers/mmc/omap.c:275: warning: 'mmc_omap_dma_done' defined but not
used
drivers/mmc/omap.c:383: warning: 'mmc_omap_irq' defined but not used
drivers/mmc/omap.c:520: warning: 'mmc_omap_switch_irq' defined but not
used
drivers/mmc/omap.c:529: warning: 'mmc_omap_switch_timer' defined but
not used
drivers/mmc/omap.c:538: warning: 'mmc_omap_switch_callback' defined but
not used
drivers/mmc/omap.c:542: warning: 'mmc_omap_switch_handler' defined but
not used
drivers/mmc/omap.c:576: warning: 'mmc_omap_prepare_dma' defined but not
used
drivers/mmc/omap.c:656: warning: 'mmc_omap_dma_cb' defined but not used
make[2]: *** [drivers/mmc/omap.o] Error 1
make[1]: *** [drivers/mmc] Error 2
make: *** [drivers] Error 2

Even platform_get_irq is incorrect no. of arguments :). 

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
