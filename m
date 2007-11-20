From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: OSK5912 GPIO
Date: Tue, 20 Nov 2007 16:03:38 +0200
Message-ID: <20071120140338.GB31714@intune.research.nokia.com>
References: <589867.89402.qm@web7606.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <589867.89402.qm@web7606.mail.in.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Azhar Mr." <shaik.azharuddin@yahoo.co.in>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 20, 2007 at 01:20:34PM +0000, ext Azhar Mr. wrote:
> 	return 0;
>         led_glow();

'return' exits the function.  led_glow() will never be called.  I'd
recommend consulting some books on C (e.g. the C Programming Language by
Kernigan and Ritchie) before continuing much further, to be honest.

Cheers,
Daniel
