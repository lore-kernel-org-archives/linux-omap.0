From: Kevin Hilman <khilman@mvista.com>
Subject: low-level debug output using CCS
Date: Tue, 24 Jan 2006 12:03:46 -0800
Message-ID: <43D68822.6030505@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The current kernels have support for low-level debug using the ARM 
EmbeddedICE DCC channel.

Does anyone know if it's possible to do something similar using the TI 
CCS tool?  Often for new TI boards, CCS is the only JTAG tool that works 
so for early bringup this could be useful.

If someone can point me in the right direction WRT CCS, I'd be happy to 
make a patch.

Thanks,
Kevin
