From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: 64MB on OMAP1510/5910?
Date: Wed, 12 Dec 2007 14:21:40 +0100
Message-ID: <20071212132140.GA27842@michl.2n.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Jason Huang <jason.huang@wescongroup.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 12, 2007 at 05:09:46AM -0800, Jason Huang wrote:
> Thanks for your reply.
> 
> We got the same problem with USB OHCI unrecoverable error interrupt,
> OHCI_INTR_UE.
> 
> Is there any fix/patch to the USB host driver?

No fix exist to my knowledge. You need to implement memory management
for Local Bus or disallow USB driver code to allocate buffers outside of
staticaly mapped 32 MB.

Best regards,
	ladis
