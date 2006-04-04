From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: rfc - use clk api to handle timers?
Date: Tue, 4 Apr 2006 08:30:52 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5051197B4@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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

I was just wondering if it might be useful to use the clk api to control
gp-timers?

	enable/disable map well.
	set_parent maps to sys_clk, dpll clk, alt_clk.
	get_rate/set_rate/round_rate work well.  There is a well known
divider set to use round_rate against.

	One thing which might be nice is some kind of get_exclusive
which causes further gets from others to fail if a resource is already
owned.  Normal usecount's would handle a shared resource.

This doesn't cover interrupt generation and others those could be added
or handled separately.

Thoughts?

Regards,
Richard W.
