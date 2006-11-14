From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] plat-omap changes for 2430 SDP
Date: Mon, 13 Nov 2006 18:47:23 -0800
Message-ID: <200611131847.23456.david-b@pacbell.net>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01DFA524@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01DFA524@DLEE09.ent.ti.com>
Content-Disposition: inline
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

Someone should also add an "musb_hdrc" platform device for
the high speed OTG controller ... I figure that would basically
live in mach-omap2/devices.c and be called from omap2430sdp_init().
(I'm assuming that controller is accessible on the SDP...)

- Dave
