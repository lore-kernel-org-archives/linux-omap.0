From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] ARM: OMAP: Make McBSP KConfigurable.
Date: Tue, 13 Jun 2006 12:17:46 +0100
Message-ID: <20060613111746.GP14634@earth.li>
References: <1150196479.25232.263691468@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1150196479.25232.263691468@webmail.messagingengine.com>
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

On Tue, Jun 13, 2006 at 04:01:19AM -0700, Komal Shah wrote:
> Please take the rebased patch, some boards do not use McBSP :)

Shouldn't the Kconfig option default to y rather than breaking all the
boards that do currently use it?

J.

-- 
Programmer, |   "Do NOT disturb. (f**king)" --   | Tel/SMS (Vodafone):
sysadmin &  |     Note on Mike's room door.      |   +44-7974-678646
BHMF.       |                                    |  Made by HuggieTag
