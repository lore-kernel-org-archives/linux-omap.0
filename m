From: "Khasim, Syed" <x0khasim@ti.com>
Subject: RE: MCSI & MCBSP howto configure as gpio
Date: Wed, 9 Aug 2006 23:51:47 -0500
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBEEC6821@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Arnold <abo_gwapo@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

If you have access to TRM of OMAP you are working on, then see the
relevant chapter for pin mux, it should tell you the mode to configure
(inorder to configure a McBSP1 pin as GPIO).

As a hack you can directly write this value to the mux register, but the
correct way would be to add an entry in arch/arm/mach-omap2/mux.c and
use the "omap_cfg_reg" API to configure the same.

Regards,
Khasim

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Arnold
Sent: Wednesday, August 09, 2006 8:14 PM
To: linux-omap-open-source@linux.omap.com
Subject: MCSI & MCBSP howto configure as gpio

Hi All,

Is there anyone who can help me configure MCSI1 or
MCBSP1 to a gpio pin? Is there a spec/howto on how to
configure it to a gpio pin? I hope to hear from you
guys.

Regards,
OJ

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
