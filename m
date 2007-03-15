From: Steve Poulsen <spoulsen@css-design.us>
Subject: omap_udc does not respond to SETUP transfer properly (OMAP5912)
Date: Thu, 15 Mar 2007 13:42:57 -0500
Message-ID: <45F993B1.9040008@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

When I plug our device into a Windows PC, we receive the SETUP message 
(USB_REQ_GET_DESCRIPTOR).  The IRQ handler sets the EP_NUM values per 
Figure 16 of SPRU761A (EP_NUM.EPU_NUM = 0, EP_DIR = 1, EP_SEL = 1, 
SETUP_SEL=0), then it writes the response into the fifo.  After writing, 
FIFO_EN is set to 1, then EP_SEL to 0.  I then find it remains in this 
state forever (or at least until Windows decides the device is 
problematic and turns it off).
I have looked at the STAT register at the start of the IRQ and it shows 
the FIFO is empty (0x02).  After writing the STAT register shows (0x04) 
as expected.  However, even waiting 500 ms after the write, the STAT 
still shows 0x04.

I have confirmed the HHC and DC clocks are enabled by looking at 
SOFT_REQ_REG and MOD_CONF_CTRL_0.

Shouldn't the STAT 0x04 bit go to zero eventually and it show the fifo 
empty once again?


Thanks,

Steve
