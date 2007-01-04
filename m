From: "Bhaskara Rao Kotla" <bhaskar12@gmail.com>
Subject: Question about SRAM access
Date: Thu, 4 Jan 2007 16:43:43 -0600
Message-ID: <1c5b04b60701041443s1dc8ee2cja1ced88ef8af4934@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
     I am new to linux driver development.
     I have a question(may be blind Qns) regarding SRAM access on OMAP2430.
     my task is write some chunk of data in SRAM from DDR SDRAM memory(data
transfer from DDRSDRAM to SRAM) using DMA.
     I have a question, how to allocate the SRAM memory(I mean, is it using
kmalloc() or malloc? ). I can allocate a memory space  using kmalloc() in
DDR SDRAM, by default kernel will do i guess.

Can someone suggest how to handle this?


Regards,
Bhaskara
