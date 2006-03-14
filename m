From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: [PATCH] Fix OV9640 sensor and add h4 sensor power functions
Date: Tue, 14 Mar 2006 15:46:19 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA602949C0A@dlee05.ent.ti.com>
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
To: Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks, I see the difference now. I see the 11/29/05 patch changed to
copy to driver->driver.name. This for sure caused crash.

Regards,
Jian

-----Original Message-----
From: Komal Shah [mailto:komal_shah802003@yahoo.com]=20
Sent: Tuesday, March 14, 2006 11:04 AM
To: Zhang, Jian; linux-omap-open-source@linux.omap.com
Cc: david.cohen@indt.org.br
Subject: RE: [PATCH] Fix OV9640 sensor and add h4 sensor power functions

--- "Zhang, Jian" <jzhang@ti.com> wrote:

> Komal,
>=20
> I have strncpy in my code and don't experience any issue. I don't
> know
> when it became strlcpy.
>=20

Hmm, in your 2430 2.6.10 code (I hope this is your current tree) you
are copying into i2c_driver->name[32] not i2c_driver->driver.name,
which is the case in the latest git tree. So, I hope it is now clear
that why strlcpy/strncpy is failing in the latest tree.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
