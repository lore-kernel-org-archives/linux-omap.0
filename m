From: =?ISO-8859-15?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>
Subject: Re: change cpu_freq
Date: Wed, 14 Jun 2006 15:44:06 +0300
Message-ID: <44900496.40400@solidboot.com>
References: <44900251.3050702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <44900251.3050702@web.de>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Martin Margraf <m_margraf@web.de>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Martin Margraf wrote:

> my next question is, how can i read/write to the regs of the omap5912? 
> during using 2.4 kernel i was able to access the regs directly with a 
> module. but now with 2.6 kernel i get a segmentation fault. maybe 
> someone can help me?

Nowadays there isn't 1-to-1 mapping between physical and virtual I/O 
addresses.  If you're operating on a physical address, you can use the 
omap_{read,write} helper macros to access the registers.  Alternatively, 
you can convert the physical address to a virtual one first by io_p2v(), 
  after which the memory accesses can be done directly.

Cheers,
Juha
