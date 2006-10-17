From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Recent additions to omap2 clock.c
Date: Tue, 17 Oct 2006 16:52:22 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5082AD7D7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: =?iso-8859-1?B?SnVoYSBZcmr2bOQ=?= <juha.yrjola@solidboot.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Juha,

I was looking to do some merging and I see you added the following:
	1: Force APLL always on control
	2: Enable/Disable for osc_clk
	3: addition delays: clk_wait_ready, wmb

For 1 and 2:
Aren't these more functions of idle control?  I was looking at porting =
over some of the omap1 idle api's and I though that associating the auto =
idle's of APLLs and the like would map to this.  Is there any reason you =
didn't take this route also?

For 3:=20
the original clock code had a clk_safe() api which was called after =
clock enables to synchronize and let the caller know if all was ok.  You =
might find when the functional clock was slow (32KHz) it might take a =
cycle for the peripheral to be accessible, generally after a wake up.  =
If you are talking about a timer, you must also watch posting vs. =
non-posting and the interconnect ratio during DVFS.

Also, status isn't always as you would infer.  Some blocks didn't hook =
up the OCP control signals so they don't consult with the module before =
setting status.  Other combined target/initiators like DSS only tie to =
mstandby state for idle, so you must stop mute before access works =
properly.

Was there some reason against just exporting another function as was =
originally done?

Regards,
Richard W.
