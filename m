From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: 64MB on OMAP1510/5910?
Date: Wed, 12 Dec 2007 13:36:41 +0100
Message-ID: <20071212123641.GA26567@michl.2n.cz>
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

On Wed, Dec 12, 2007 at 01:21:56AM -0800, Jason Huang wrote:
> Hello All,
> 
> I searched over the mailing list and did not find a solution for
> OMAP1510/5910 to use more than 32 MB.
> 
> Has anyone made 64MB work on 1510/5910?

Voiceblue board comes with 64MB RAM, however USB host doesn't work,
because its driver code maps only 32MB staticaly.

Best regards,
	ladis
