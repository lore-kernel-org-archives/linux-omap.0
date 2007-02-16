From: "rajeev  s" <rajeev2174@rediffmail.com>
Subject: Accessing Mailbox register on OMAP SDP2430
Date: 16 Feb 2007 14:49:01 -0000
Message-ID: <1169480869.S.3614.7806.webmail19.rediffmail.com.old.replied.1171637341.28201@webmail.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux_omap_open_source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi ,We are in the process of porting DSP/LINK to OMAP2430 (SDP2430).We are programming the mail boxes for the interprocess communication, In the process we are&nbsp;using the address 0x48094000.We did the ioremap of the Address range (0x48094000) and could see that it returns an virtual address, but the moment i access that virtual address&nbsp;the kernel crashes.Please find the sample code below:Code :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static unsigned int  *arm_addr2=NULL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arm_addr2 = (unsigned int *)ioremap(0x48094000,0xFFF );&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk ( \" 0x48094000 Virt Addr = 0x%p\\n\", arm_addr2 );
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp_var = readl(arm_addr2);Can anyone let me know is there anything wrong in the way these registers are accessed ?ThanksRajeev
