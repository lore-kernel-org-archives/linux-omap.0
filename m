From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] fix PWL macro names
Date: Mon, 3 Jul 2006 16:59:52 +0100
Message-ID: <20060703155952.GE3852@earth.li>
References: <fb249edb0606291210v45cd5bb5odf668ebbc98c3813@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0606291210v45cd5bb5odf668ebbc98c3813@mail.gmail.com>
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

On Thu, Jun 29, 2006 at 09:10:35PM +0200, andrzej zaborowski wrote:
> Remove "16XX" from the names of PWL-related defines as they are valid
> for other models as well.

Move them out of omap16xx.h as well then? I'm in favour of this change
though.

J.

-- 
noodles is on fire
