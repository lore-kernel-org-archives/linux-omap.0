From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: [PATCH] omap24xx IrDA update
Date: Fri, 23 Dec 2005 03:09:42 -0800 (PST)
Message-ID: <20051223110942.32107.qmail@web32908.mail.mud.yahoo.com>
References: <EA12F909C0431D458B9D18A176BEE4A503838845@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A503838845@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "G Kondaiah, Manjunath" <xgkondai@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- "G Kondaiah, Manjunath" <xgkondai@ti.com> wrote:

> Hi Komal,
>=20
> The I/O expander on H4 uses I2C calls for changing the speed of the
> IrDA
> transceiver. Speed change request some times occurs in interrupt
> context,=20
=20
I have added workqueue interface with board specific support now. I am
using run-time macros instead of DECLARE_WORK.=20

In the latest patch (not released yet) INIT_WORK only needs to be done
from _probe function and "transceiver_mode" will call PREPARE_WORK. But
to make this work we need to add "struct work_struct" in
omap_irda_config platform_data structure, assuming that some platforms
(using sleeping call path...), can utilize it.

I have tested it on h4, and it seems to be working. I will release the
patch once Tony comes back and reviews the earlier posted patch for any
other comments.

Could you please give "irdadump" arm binary if you have?

---Komal Shah
http://komalshah.blogspot.com/


	=09
__________________________________________=20
Yahoo! DSL =96 Something to write home about.=20
Just $16.99/mo. or less.=20
dsl.yahoo.com=20
