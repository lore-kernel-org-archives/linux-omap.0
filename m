From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: [PATCH] OMAP1: camera core : Use platform driver structure
Date: Thu, 23 Feb 2006 18:49:32 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA602645AE0@dlee05.ent.ti.com>
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
To: Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Komal,

Is there any guideline on the way a driver is registered with LDM? e.g.
via driver_register() or platform_driver_register()? We are now always
using omap_driver_register() which is a wrapper to driver_register().

Again, is this the trend to move the bulk of init code to probe()
function?

If these are what other drivers do, I certainly don't want to see camera
driver being different.

Regards,
Jian
 =20
-----Original Message-----
From: Komal Shah [mailto:komal_shah802003@yahoo.com]=20
Sent: Thursday, February 23, 2006 6:53 AM
To: linux-omap-open-source@linux.omap.com
Cc: david.cohen@indt.org.br; Zhang, Jian
Subject: [PATCH] OMAP1: camera core : Use platform driver structure

Jian/David,

Attached patch uses the platform driver structure and introduced probe
and remove function from init and cleanup. It builds for H2, but unable
to test as not having H2 board access.

Please review it and if possible test it.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
