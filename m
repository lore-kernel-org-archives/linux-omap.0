From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Why does it increase the dsor value in MMC?
Date: Fri, 29 Jun 2007 10:28:47 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47013BF5FA@dlee13.ent.ti.com>
References: <3E32F84CD6CB95498A35B353CA3B930C0672DD@fioues08.ebgroup.elektrobit.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <3E32F84CD6CB95498A35B353CA3B930C0672DD@fioues08.ebgroup.elektrobit.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tuukka.Tikkanen@elektrobit.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi,

>Removing the line improves performance for most people, but might break
>some hardware combinations (the above case). If you can verify from TRM
>that the value written to register is the actual divisor (and not like
>1=3D0, 2=3D1 etc),=20
It is like this, writing 0 will disable the clock and 1 to 0x3FF are =
valid values.

Regards,
Khasim
