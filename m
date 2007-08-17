From: Zgembo Adislic <adislic_zgembo@yahoo.com>
Subject: traffic controller priority adjustment
Date: Fri, 17 Aug 2007 01:36:02 -0700 (PDT)
Message-ID: <760329.90465.qm@web30615.mail.mud.yahoo.com>
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

Hello,

I'd like to adjust the priority register for EMIFF arbitration, so that DMA will get priority over other masters (MPU, DSP).  I wonder if there is  an API in kernel for this? 

I am using OMAP5910 and linux kernel 2.6.8.1. 

Any opinions about this?

Zgembo


       
---------------------------------
Ready for the edge of your seat? Check out tonight's top picks on Yahoo! TV. 
