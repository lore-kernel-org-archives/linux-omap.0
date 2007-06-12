From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: new PRCM breakage: 2430 FB
Date: Mon, 11 Jun 2007 22:05:54 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470117CBD8@dlee13.ent.ti.com>
References: <Pine.LNX.4.64.0706111821110.28778@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0706111821110.28778@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@mvista.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Paul / Kevin:

I looked some more into this code,

>
>the 'soft reset failed' message is coming from
>drivers/video/omap/dispc.c:1391.
>
Yes it's failing. Actually for a DSS reset to be successful all the DSS =
clocks (iclk and fclk) including TVout 54M fclk should be enabled =
otherwise the reset bit doesn't get cleared. I think this is what is =
happening now.
I tried enabling dss2_fck also but this didn't succeed either.

May be we were doing something wrong before and Paul's patches are doing =
some thing as per TRM :).

>The only PRCM-related code near that function is the display clock
>enable code, which, as Khasim mentioned, uses dss_ick, dss1_fck, and
>dss_54m_fck.  I just went back and checked the PRCM changes for those
>three clocks and omap2_clk_enable(), and they look good.
>
I have to put some debugger to see if all required clocks are ON before =
hitting this reset logic.

Is this reset logic passing for 2420? I didn't try this.=20

>Could be a TWL4030 problem given the lack of power.
>
No, its not a TWL4030 power enable problem. As the reset logic fails, it =
returns with an error in ctrl_init. The control doesn't even enter the =
T2-LDO enabling functions.

>git-bisect perhaps?
>
>Unfortunately, no 2430 SDP here, or I'd take a closer look.
>
Can we bypass reset logic for 2430 ? he he he .. :)

Regards,
Khasim
