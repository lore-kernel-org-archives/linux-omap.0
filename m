From: "Wester de Cocq" <w.decocq@gmail.com>
Subject: DSP DMA Requests omap 5912 wont work.
Date: Fri, 28 Dec 2007 14:33:42 +0530
Message-ID: <d43870f30712280103q5c5cee9fqf0a8bc28eba2bfe@mail.gmail.com>
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

Hi All,

For the last few days I've been trying to get DMA requests to work with the
MCSI.
But no luck so far, there just doesn't seem to happen anything. For the sake
of testing I tried it with the UART, but this as well had no effect.

I've set the GDMA, to make sure its not set incorrectly.
Set the MCSI in DMA mode and of course set the SYNC bits on the DMA.

What else should I do?
I am not using the CSL and make use of the OSK with Montavista preview kit.


Thanks in advance,
Wester de Cocq
