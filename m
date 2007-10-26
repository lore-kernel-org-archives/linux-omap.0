From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 0/2] CPU id and silicon rev check support
Date: Fri, 26 Oct 2007 19:03:03 +0300
Message-ID: <1193414583.23273.6.camel@localhost.localdomain>
References: <000101c817e6$59bb6770$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <000101c817e6$59bb6770$6a8918ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Girish <girishsg@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
On Fri, 2007-10-26 at 21:09 +0530, ext Girish wrote:
> Sorry, I guess the previous patch series might have got auto wrapped. Resending the patch series without auto wrapping.
> 
> Hi,
> I am sending across patch series to support CPU identification and run-time silicon revision check for OMAP2/3.

Is there any way to identify at runtime a speed sorted omap vs a
standard one?
Then some of the code we have for N800/N810 could be moved from board to
arch.

-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
