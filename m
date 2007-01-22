From: "rajeev  s" <rajeev2174@rediffmail.com>
Subject: Accessing DSP MMU on OMAP SDP2430
Date: 22 Jan 2007 09:55:04 -0000
Message-ID: <20070122095504.11749.qmail@webmail25.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
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
To: linux_omap_open_source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi All,I have an sdp2430 board (OMAP2430 based).I want to access the DSP MMU registers from the ARM side .The Address base of this DSP MMU Register is on the Address range 0x5d000000. To access these registers from ARM to setup the MMU Translation i added the following code in the file:include/asm/arch-omap/io.h (Linux source is 2.6-19):#define IO_VIRT_DSP_L2_RAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xED000000&nbsp; /* va of&nbsp;DSP MMU&nbsp;*/I arrived at this address using the following logic :0x5d000000&nbsp;+ 0x90000000 = 0xED000000.When i access the DSP MMU address registers from the Virtual Address base 0xED000000&nbsp;, i get an kernel crash.Also i have created an entry for this address in the io.c file as well.Could anybody let me know am i following the correct procedure.ThanksRajeev

raj
