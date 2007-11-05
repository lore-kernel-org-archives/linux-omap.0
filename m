From: Ram <vshrirama@gmail.com>
Subject: DQBUF V4L2 Errors (camdma trasaction error?)
Date: Mon, 5 Nov 2007 17:21:24 +0530
Message-ID: <8bf247760711050351g5a0afc0ma8e98709d53c2dae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Hi,
   I am writing a camera sensor driver for a custom built OMAP2430 board.

   I am receiving images from the camera without any issues. However
   after continuously running the camera capture application for about a hour
   or so. I constantly get "VIDIOC_DQBUF" error.

  This is because a camera dma tranasction error has occurred. (Bit 8
in CSR Camera DMA  Channel status register).  Actually this is a
temporary condition.

 However, in my case i am getting too many of these camera dma
transaction error after running for an hour or so.

I am able to see camera interrupts. (cat /proc/interrupts)

However for every 20-30 interrupts i get a camera dma transaction error.

 Has anyone faced this problem before?


 Please advice.

Regards,
sriram
