From: Kevin Hilman <khilman@mvista.com>
Subject: Re: low-level debug output using CCS
Date: Tue, 24 Jan 2006 15:03:09 -0800
Message-ID: <43D6B22D.3060104@mvista.com>
References: <43D68822.6030505@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <43D68822.6030505@mvista.com>
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

After a little more digging, it turns out this is a CCS-feature on the 
host-side, not on the target.  CCS does in TI-toolchain generated 
binaries by setting a breakpoint in the low-level print function and 
then dumping the output to a window.

Kevin

Kevin Hilman wrote:
> The current kernels have support for low-level debug using the ARM 
> EmbeddedICE DCC channel.
> 
> Does anyone know if it's possible to do something similar using the TI 
> CCS tool?  Often for new TI boards, CCS is the only JTAG tool that works 
> so for early bringup this could be useful.
> 
> If someone can point me in the right direction WRT CCS, I'd be happy to 
> make a patch.
> 
> Thanks,
> Kevin
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
