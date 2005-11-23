From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [omap24xx] camera driver porting
Date: Wed, 23 Nov 2005 03:09:06 -0800 (PST)
Message-ID: <20051123110907.78731.qmail@web32907.mail.mud.yahoo.com>
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

Jian,

Some more points about omap24xx camera driver porting to
existing framework on linux-omap-git tree.

o How to handle csr_error used in omap24xxcam.c with
camera_core_sgdma_process(), as defines for csr_error is specific to
omap2 platform, so it should be passed from platform specific
file(omap24xxcam.c) to camera_core.c, but how? 

o How to port omap24xxcam_error_handler(), as it calls
omap24xxcam_sg_dma_sync()? Error handler is specific to 24xx so, should
be implemented from omap24xxcam.c , but then we can't call
sg_dma_sync() from omap24xxcam.c as it should be in camera_core.c ?

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
