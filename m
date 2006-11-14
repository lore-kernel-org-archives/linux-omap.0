From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] plat-omap changes for 2430 SDP
Date: Mon, 13 Nov 2006 23:26:55 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01DFA5E0@DLEE09.ent.ti.com>
References: <200611131847.23456.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200611131847.23456.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Dave,

At present in our tree, we have "musb_plat"=20
(musb_hdrc_platform_data musb_plat) in our board_2430sdp.c.=20

It's treated like flash or smc91.x device and added as another 2430SDP
device to "__initdata " list. Do you see any issues with this approach?

I think we need to discuss more on these sorts of placements.=20

Thanks & Regards,
Khasim

-----Original Message-----
From: David Brownell [mailto:david-b@pacbell.net]=20
Sent: Monday, November 13, 2006 8:47 PM
To: linux-omap-open-source@linux.omap.com
Cc: Syed Mohammed, Khasim
Subject: Re: [PATCH] plat-omap changes for 2430 SDP

Someone should also add an "musb_hdrc" platform device for
the high speed OTG controller ... I figure that would basically
live in mach-omap2/devices.c and be called from omap2430sdp_init().
(I'm assuming that controller is accessible on the SDP...)

- Dave
