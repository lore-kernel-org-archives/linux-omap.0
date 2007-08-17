From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH] ARM: OMAP: MUSB: peripheral compile fix
Date: Fri, 17 Aug 2007 09:38:12 -0700
Message-ID: <46C5CEF4.70101@mvista.com>
References: <20070817161252.274402322@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070817161252.274402322@mvista.com>
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

Kevin Hilman wrote:
> Move error detection for "Stopping host session because of babble" 
> inside host-ifdef since it doesn't apply (or compile) for gadget.

Oops, sent the wrong fix.  Ignore this one.
