From: DAMWID <damwid@gmail.com>
Subject: About the status of USB support on OMAP2430 SDP
Date: Tue, 30 Oct 2007 23:19:39 +0800
Message-ID: <47274B8B.1080802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB18030; format=flowed
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

I'm working on the USB dirver on my OMAP2430 SDP v3.0 board with 
linux-omap git tree, currently I can make the Inventra controller (musb) 
work in host/device/OTG mode, but only for one port on the processor 
board. How can I enable USB host on the other ports? Should I use the 
ohci-omap module? I'm not clear with the relationship between musb and 
ohci-omap, are they separate controllers?

I can't get the ohci-omap work on my board, and I was confused by the 
kernel configs in "USB support" section. Is it enough to get ohci-omap 
work by just enable USB_OHCI_HCD? I notice there is a ISP1301 
transceiver on the main borad, so is the isp1301_omap driver needed? I 
found it depends on OMAP_OTG, which is not selected by ARCH_OMAP2430, 
does this mean isp1301_omap dirver is not necessary for ohci-omap?

Does anyone get the ohci-omap work? Can you give some help?

Thanks,
Damwid
